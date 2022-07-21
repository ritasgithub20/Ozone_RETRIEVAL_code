function proc_meas = select_meas_length()

%% 
% load all existent mat files in the current directory (incl. all subdirs)
% Comment: this command will load all .mat files in MatFiles, so make sure
%          there are no other .mat files in MIRA_AOS_Files than those you 
%          want to process
MatFiles = dir('**/*.mat');
proc_meas.MatFiles = MatFiles;     

j = 1;
% for all measurement files saved in MatFiles select only those that
% fullfil the condition at meas_condition(2) >= x (x=time in minutes) and
% store them in the structure ecmwf.dataList
for i = 1:length(MatFiles)
    buffer = load(fullfile(MatFiles(i).folder,MatFiles(i).name));
    % calculate measurement time
    meas_duration = (buffer.end_hour*60+buffer.end_min)-(buffer.start_hour.*60+buffer.start_min);   
    if meas_duration(2) >= 1 % a good measurment is a measurement >= 1h in minutes
       dataList(j) = buffer; % saves only good measurement files in dataList 
       j = j+1;
    end
    proc_meas.dataList = dataList; 
end

end 
