% Initiated by Veronika Ettrichrätz 
% Adapted by Rita Kajtar

% gets all mat files from the current directory (including subdirectories) 
% only saves data from good measurements (>= 3h measurements)

clear all
close all

%loading all mat files in the directory including all subfolders
MatFiles = dir('**/*.mat');

j = 1
for i = 1:length(MatFiles)

    buffer = load(fullfile(MatFiles(i).folder,MatFiles(i).name));
    % a good measurment is a measurement over 3 houres in minutes
    % calculate measurement time
    time = (buffer.L2.end_hour*60+buffer.L2.end_min)-(buffer.L2.start_hour.*60+buffer.L2.start_min)   
    if time(2) >= 3*60 % a good measurment is a measurement >= 3 houres in minutes
    dataList(j) = buffer; % saves only good measurement files in dataList 
    j = j+1
    end

end

i = 1;
for i = 1:length(dataList)                     % loop through good data

    species1_x = dataList(i).L2.species1_x;    % getting O3 vmr from good data list
    species1_xa = dataList(i).L2.species1_xa;  % getting apriori vmr from good data list
    zgrid = dataList(i).L2.zgrid;              % getting altitude from good data list
    f_backend = dataList(i).L2.f;              % getting f_backend from good data list
    y = dataList(i).L2.y;                      % getting measurement data from good data list
    yf = dataList(i).L2.yf;                    % getting fitted data from good data list
    avk = dataList(i).L2.species1_A;           % getting AvKe from good data list
    jac = dataList(i).L2.J;                    % getting jacobians from good data list

    % extracting date and time of measurement
    year = dataList(i).L2.year;                % extract year
    month = dataList(i).L2.month;              % extract month
    day = dataList(i).L2.day;                  % extract day 
    hour = dataList(i).L2.hour;                % extract hour
    minute = dataList(i).L2.minute;            % extract minute
    second = dataList(i).L2.second;            % extract second

    % plots (O3 profile / meas vs fit spectra / AvKe / Jacobians)
    myO3_profile(species1_x,species1_xa,zgrid,f_backend,y,yf,avk,jac,year,month,day,hour,minute,second)  

    % save figure 
    str1 = strcat(num2str(year),":",num2str(month),":",num2str(day),"-"); 
    str2 = strcat(num2str(hour),".",num2str(minute),".",num2str(fix(second)));
    saveas(gca, 'meas'+str1+str2+'.png');

end 
