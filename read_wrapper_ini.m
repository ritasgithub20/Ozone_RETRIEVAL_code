function settings = read_wrapper_ini()

%% Comments

working_machine = hostname;
fid = fopen('/Users/ritkaj/Desktop/work/MIRA_AOS_Files/read_wrapper_ini.txt');

while 1
    tline = fgetl(fid);

    if ~ischar(tline)                % as long as content of tline is char don't break
        break;
    end

    in = regexp(tline,' ','split');  % splits contents of tline at each space

    if  strcmp(in(1),'#') && strcmp(in(2), working_machine)
        tline = fgetl(fid); 
        in = regexp(tline,' +','split');
        if strcmp(in{1},'INSTRUMENT') && (strcmp(in{2},'kimra') || strcmp(in{2},'mira2'));
            settings.instrument = in{2};
            out=sprintf('<read_wrapper_ini> : INSTRUMENT defined as %s', settings.instrument);
            disp(out);
        else
            disp('No valuable INSTRUMENT defined');
            break
        end

        tline = fgetl(fid);
        in = regexp(tline,' +','split');
        if strcmp(in(1), 'parent_path') && exist(in{2},'dir') == 7;
            settings.parent_path = in{2};
        else
            disp('Path to parent_path incorrect');
            break
        end
        % disp(tline);
        tline = fgetl(fid);
        in = regexp(tline,' +','split');
        if strcmp(in(1), 'OEM2L2_path') && exist(in{2},'dir') == 7;
            settings.OEM2L2_path = in{2};
        else
            disp('Path to OEM2L2_path incorrect');
            break
        end
        % disp(tline)
        tline = fgetl(fid);
        in = regexp(tline,' +','split');
        if strcmp(in(1), 'arts_path') && exist(in{2},'dir') == 0;
            settings.arts_path = in{2};
        else
            disp('Path to arts_path incorrect');
            break
        end
        % disp(tline)
        tline = fgetl(fid);
        in = regexp(tline,' +','split');
        if strcmp(in(1), 'arts_file') && exist(in{2},'dir') == 0;
            settings.arts_file = in{2};
        else
            disp('Path to arts_file incorrect');
            break
        end
        % disp(tline)
        tline = fgetl(fid);
        in = regexp(tline,' +','split');
        if strcmp(in(1), 'oem_dir') && exist(in{2},'dir') == 7;
            settings.oem_dir = in{2};
        else
            disp('Path to oem_dir incorrect');
            break
        end
        % disp(tline)
        tline = fgetl(fid);
        in = regexp(tline,' +','split');
        if strcmp(in(1), 'ECMWF_tFiles') && exist(in{2},'dir') == 7;
            settings.ECMWF_tFiles = in{2};
        else
            disp('Path to ECMWF_tFiles incorrect');
            break
        end
        % disp(tline)
        tline = fgetl(fid);
        in = regexp(tline,' +','split');
        if strcmp(in(1), 'ECMWF_zFiles') && exist(in{2},'dir') == 7;
            settings.ECMWF_zFiles = in{2};
        else
            disp('Path to ECMWF_zFiles incorrect');
            break
        end
    end    
end
fclose(fid);
disp(settings);
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp(' ');

end 
