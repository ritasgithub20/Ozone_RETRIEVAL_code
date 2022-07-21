function curr_meas = find_meas_date_time(proc_meas,i)

%% 
% extract date and time of measurement and save in structure curr_meas
    year = proc_meas.dataList(i).start_year;     curr_meas.year = year; 
    month = proc_meas.dataList(i).start_month;   curr_meas.month = month;
    day = proc_meas.dataList(i).start_day;       curr_meas.day = day;
    hour = proc_meas.dataList(i).start_hour;     curr_meas.hour = hour;
    minute = proc_meas.dataList(i).start_min;    curr_meas.minute = minute;
    second = proc_meas.dataList(i).start_sec;    curr_meas.second = second; 

    meas2str = strcat(num2str(year),num2str(month),num2str(day),'_',num2str(hour));
    curr_meas.meas2str = meas2str; 
    curr_path = fullfile(num2str(year),num2str(month),num2str(day),num2str(hour));
    curr_meas.curr_path = curr_path; 

    % display currently processed measurement file
    AOSmeas = strcat('AOSData_',meas2str,num2str(minute),num2str(second));
    disp(strcat('The currently processed MIRA measurement is:'," ",num2str(AOSmeas)));

    % create date string for AOS meas
    meas_date = strcat(year,month,day,hour,minute,second);  
    curr_meas.meas_date = meas_date;
    % create serial date no.
    aos_date = datenum(meas_date,'yyyymmddHHMMSS'); 
    curr_meas.aos_date = aos_date; 

end 
