function ret_param = extract_ret_param(settings,curr_meas)
%%
% return to parent directory
input_path = fullfile(curr_meas.curr_path,'input');
output_path = fullfile(curr_meas.curr_path,'output');

f_backend = xmlLoad(fullfile(input_path,'f_backend.xml')); 
ret_param.f_backend = f_backend;
y = xmlLoad(fullfile(input_path,'y.xml'));       
ret_param.y = y;
species1_x = xmlLoad(fullfile(output_path,'x.xml')); 
ret_param.species1_x = species1_x; 
species1_xa = xmlLoad(fullfile(output_path,'vmr_field_apriori.xml'));  
ret_param.species1_xa = species1_xa;
zgrid = xmlLoad(fullfile(output_path,'z_field_ret.xml'));    
ret_param.zgrid = zgrid;
yf = xmlLoad(fullfile(output_path,'yf_ret.xml'));             
ret_param.yf = yf; 
avk = xmlLoad(fullfile(output_path,'avk.xml'));          
ret_param.avk = avk;
jac = xmlLoad(fullfile(output_path,'jacobian.xml'));
ret_param.jac = jac; 
ret_eo = xmlLoad(fullfile(output_path,'retrieval_eo.xml'));
ret_param.ret_eo = ret_eo;
ret_ss = xmlLoad(fullfile(output_path,'retrieval_ss.xml')); 
ret_param.ret_ss = ret_ss;
%Sx = xmlLoad(fullfile(output_path, 'covmat_sx2.xml'));
%ret_param.Sx = Sx;

end
