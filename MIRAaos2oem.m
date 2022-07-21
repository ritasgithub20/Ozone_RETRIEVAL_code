%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%  
% This file should be ran from the same directory where the AOSData.mat 
% files and the ECMWF_tfiles and ECMWF_zfiles directories are stored
%
% collects all mat files from the current directory (including subdirectories) 
% only saves data from good measurements (>= 3h measurements)
%
% once 3h measurements are selected each measurement is processed 
% separately and parameters needed by TestOEM.arts are extracted. 
% y and f_backend coressponding to each measurement are extracted from 
% the spec{} structure of each .mat file, while ecmwf data files are
% selected from the ECMWF_tfiles and ECWMF_zfiles by calculating 
% the minimum difference between the date and time of the measurement
% and and date and time of the ecmwf_t and ecmwf_z files.
% 
% for each processed measurement there will be a sequence of subdirectories
% created based on the date and hour of the measurement where y, f, 
% ecmwf_t and ecmwf_z will be stored 
%
% script initiated by Veronika Ettrichrätz and Rita Kajtar - 25.04.2020
% developed and logged by Rita Kajtar
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; clear; close all
temp = tempdir; % create temporary directory

% user sets paths needed by the program in read_wrapper_ini.txt
settings = read_wrapper_ini;
save(fullfile(temp,'settings.mat'),'settings'); 

% this fct selects measurements to be processed acc. to their duration
proc_meas = select_meas_length;
save(fullfile(temp,'proc_meas.mat'),'proc_meas'); 

% this fct loads all ECMWF files and stores their names as serial no.
ecmwf = ecmwf_back_in_time; 
save(fullfile(temp,'ecmwf.mat'), 'ecmwf'); 

%%%%%%%%%%%%%%% LOOP THROUGH ALL MEAS SELECTED IN proc_meas %%%%%%%%%%%%%%%

aos_date = [];
for i = 1:length(proc_meas.dataList) 

    curr_meas = find_meas_date_time(proc_meas,i); 
    save(fullfile(temp,'curr_meas.mat'), 'curr_meas');

    % go to the current meas dir and create an input dir where y, f_backend
    % corresponding to the current measurement and closest ecmwf_t and 
    % ecmwf_z will be copied; these vars will then be used by the ARTS cf 
    meas_path = fullfile(curr_meas.curr_path,'input');
    mkdir(meas_path); 

    curr_ecmwf = import_curr_ecmwf(ecmwf,curr_meas);
    save(fullfile(temp,'curr_ecmwf.mat'),'curr_ecmwf');

    % this fct extracts y & f_backend and adapts f_backend 
    Y_F_BACKEND = extract_y_f_backend(proc_meas,curr_meas,i); 
    save(fullfile(temp,'Y_F_BACKEND.mat'),'Y_F_BACKEND');

    % from local directory TestOEM copy its contents into the subdirectory 
    % coresponding to the measurement that is being processed. 
    copyfile(settings.oem_dir, curr_meas.curr_path);

    % adapt p_grid_ret here
    p_grid_ret = adapt_p_grid_ret(curr_meas,curr_ecmwf); 
    %save(fullfile(temp,' p_grid_ret.mat'),' p_grid_ret');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%% RUN ARTS HERE %%%%%%%%%%%%%%%%%%%%%%%%%%%%

    run_arts = strcat(settings.arts_path," ",'-r002'," ", ... 
                            settings.arts_file,'>log');
    disp('ARTS is running now ...');
    system(run_arts); 
    disp('Everything looks OK.');

    %%%%%%%%%%%%%%%%%% EXTRACT RETRIEVAL PARAMETERS HERE %%%%%%%%%%%%%%%%%%

    cd (settings.parent_path) 
    ret_param = extract_ret_param(settings,curr_meas); 

    %%%%%%%%%%%%%%%%%%%%%%% SAVE OEM2L2 STRUCT HERE %%%%%%%%%%%%%%%%%%%%%%%

    OEM2L2_struct = save_OEM2L2(settings,curr_meas,proc_meas,ret_param,i); 

    %%%%%%%%%%%%%%%%%%% MAKE PLOTS HERE AND SAVE FIGURE %%%%%%%%%%%%%%%%%%%

    set(0,'DefaultFigureVisible','off');
    myO3_profile(ret_param.species1_x,ret_param.species1_xa, ... 
                 ret_param.zgrid,ret_param.f_backend,ret_param.y, ... 
                 ret_param.yf,ret_param.avk,ret_param.jac, ... 
                 curr_meas.year,curr_meas.month,curr_meas.day, ... 
                 curr_meas.hour,curr_meas.minute,curr_meas.second, ... 
                 ret_param.ret_eo,ret_param.ret_ss)
    saveas(gca,curr_meas.meas2str,'png');

    %%%%%%%%%%%%%%%%%%%%%%% PROCESS NEXT MEASUREMENT %%%%%%%%%%%%%%%%%%%%%%

    disp('Processing the next measurement');
end
