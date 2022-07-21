function Y_F_BACKEND = extract_y_f_backend(proc_meas,curr_meas,i)
%%
  % extract y and f_backend from spec{} field within the .mat file
    % getting f_backend from good data list
    f_backend_ini = proc_meas.dataList(i).spec{1};      
    % flip f_backend_real (f_backend_real is the initial extended f_backend)
    f_backend_ext = flip(f_backend_ini);
    % getting y from good data list
    y_ini = proc_meas.dataList(i).spec{2};    
    % flip y
    y_ext = flip(y_ini);

    % extract frequencies between 272.5 - 273.5 GHz
    % reduce y_ext array according to f_backend
    f_backend = []; 
    y =[];  
    for i_fy = 1:length(f_backend_ext)
        if (f_backend_ext(i_fy) >= 2.725e+11 && f_backend_ext(i_fy) <= 2.735e+11) 
            f_backend = [f_backend, f_backend_ext(i_fy)];
            y = [y, y_ext(i_fy)];
            i_fy = i_fy + 1;
        end
    end    

    % export measurement vector and frequency backend as .xml files
    % and save them in the Y_F_BACKEND structure
    fullfile_f = fullfile(curr_meas.curr_path,'input','f_backend.xml');                        
    xmlStore(fullfile_f,f_backend,'Vector');
    Y_F_BACKEND.f_backend = f_backend; 
    fullfile_y = fullfile(curr_meas.curr_path,'input','y.xml'); 
    xmlStore(fullfile_y,y,'Vector');
    Y_F_BACKEND.y = y;

end  
