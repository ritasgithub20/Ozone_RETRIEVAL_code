function p_grid_ret = adapt_p_grid_ret(curr_meas,curr_ecmwf)

%%
% open measurement subdirectory 
    cd (curr_meas.curr_path);
    % go to data/general/p_grid_41elem.xml
    p_grid_path = fullfile('data','general','p_grid_41elem.xml');
    % load p_grid_ini (p_grid41elem)
    load_p_grid = xmlLoad(p_grid_path);
    % replace 1st and 2nd (TOPMOST) elem of p_grid_ret with 1st and 2nd elem of  
    % the p values from ecmwf_z (or ecmwf_t). 
    % This is done in order to include pressures close enough to
    % the surface of the Earth such that z_surface (420m alt. for Kiruna) 
    % will be within the considered p_grid, otherwise ARTS will throw
    % and error as it doesn't extrapolate to such extents by itself. 
    load_p_grid(1) = curr_ecmwf.ecmwf_z_data.grids{1,1}(1); 
    %load_p_grid(2) = ecmwf_z_data.grids{1,1}(2);
    % write out newly modified p_grid_ret and replace old file 
    fullfile_p = fullfile('data','general','p_grid_ret.xml'); 
    xmlStore(fullfile_p,load_p_grid,'Vector'); 

    % save the new pressure grid in the structure p_grid_ret
    % currently we use the p grid both for RT calcs and for the retrieval
    p_grid_ret.load_p_grid = load_p_grid; 

end
