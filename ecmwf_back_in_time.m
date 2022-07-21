function ecmwf = ecmwf_back_in_time()

%% 
% load all ECMWF t and z files
ECMWF_tFiles = dir('ECMWF_tfiles'); ECMWF_zFiles = dir('ECMWF_zfiles');
ecmwf.ECMWF_tFiles = ECMWF_tFiles;  ecmwf.ECMWF_zFiles = ECMWF_zFiles; 
t_buffer = [];                      z_buffer = []; 
% looping starts from pos 3 to skip the first two '.' files in the dir.
for t_i = 3:length(ECMWF_tFiles) 
    % extract substrings from ecmwf_t file names indicating time and hour 
    t_buffer =[t_buffer,(extractBetween(ECMWF_tFiles(t_i).name,1,8))];
    % convert date and time to serial number
    ecmwf_tdate = datenum(t_buffer,'yymmddHH');
end    
    ecmwf.ecmwf_tdate = ecmwf_tdate;

% lopping starts from pos 3 to skip the first two '.' files in the dir.
for z_i = 3:length(ECMWF_zFiles) 
    % extract substrings from ecmwf_z file names indicating time and hour 
    z_buffer =[z_buffer,(extractBetween(ECMWF_zFiles(z_i).name,1,8))]; 
    % convert date and time to serial number
    ecmwf_zdate = datenum(z_buffer,'yymmddHH');
end  
    ecmwf.ecmwf_zdate = ecmwf_zdate;      

end 
