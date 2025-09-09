function [t_vec, av_pos_inert, av_att, tar_pos_inert, tar_att] = LoadASPENData(filename)
%Time vector
t_vec = filename(:,1).';
%Assigning names to intial arrays
pos_av_aspen =  filename(:,11:13).'; 
att_av_aspen = filename(:,8:10).';
pos_tar_aspen = filename(:,5:7).';
att_tar_aspen = filename(:,2:4).';
%Data conversion
[av_pos_inert, av_att, tar_pos_inert, tar_att] = ConvertASPENData(pos_av_aspen, att_av_aspen,  pos_tar_aspen, att_tar_aspen);
end

