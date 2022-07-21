function curr_ecmwf = import_curr_ecmwf(ecmwf,curr_meas)
%% 
% find closest ECMWF data for the currently processed measurement
    [ecmwf.ECMWF_t,indext] = min(abs(ecmwf.ecmwf_tdate-curr_meas.aos_date));
    [ecmwf.ECMWF_z,indexz] = min(abs(ecmwf.ecmwf_zdate-curr_meas.aos_date));

    %%%%%%%%%%%%%%%%%%%%%%%%% IMPORT ECMWF FILES %%%%%%%%%%%%%%%%%%%%%%%%%%

    % export corresponding ECMWF_t file as .xml  
    % indicate path to the corresponding ECMWF_t file
    % OBS: 2 positions are added (+2) to the index to correct for the offset 
    % introduced at line 9 in ecmwf_back_in_time.m
    load_t = fullfile('ECMWF_tfiles',ecmwf.ECMWF_tFiles(indext+2).name);
    ecmwf_t_data = xmlLoad(load_t);   
    fullfile_t = fullfile(curr_meas.curr_path,'input','ecmwf_t.xml');                                          
    % store content of ECMWF t file in the right directory
    xmlStore(fullfile_t,ecmwf_t_data,'GriddedField3');
    curr_ecmwf.ecmwf_t_data = ecmwf_t_data; 

    % export corresponding ECMWF_z file as .xml  
    % indicate path to the corresponding ECMWF_z file
    % OBS: 2 positions are added to the index to correct for the offset 
    % introduced at line 18 in ecmwf_back_in_time.m
    load_z = fullfile('ECMWF_zfiles',ecmwf.ECMWF_zFiles(indexz+2).name);
    ecmwf_z_data = xmlLoad(load_z);
    fullfile_z = fullfile(curr_meas.curr_path,'input','ecmwf_z.xml');                         
    % store content of ECMWF z file in the right directory
    xmlStore(fullfile_z,ecmwf_z_data,'GriddedField3');
    curr_ecmwf.ecmwf_z_data = ecmwf_z_data;

    disp(strcat('Closest ECMWF data to this date:'," ",num2str(ecmwf.ECMWF_tFiles(indext+2).name), ... 
        ' and'," ",num2str(ecmwf.ECMWF_zFiles(indexz+2).name)));

end 
