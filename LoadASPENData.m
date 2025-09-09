function [t_vec, av_pos_inert, av_att, tar_pos_inert, tar_att] = LoadASPENData(filename)
%Time vector
t_vec = (filename(:,1).' )./100; % divide by 100 to account for frame rate of 100Hz
%Assigning names to intial arrays
pos_av_aspen =  filename(:,11:13).' ./1000; % Divide by 1000 to yield results in meters
att_av_aspen = filename(:,8:10).' ./1000;
pos_tar_aspen = filename(:,5:7).' ./1000;
att_tar_aspen = filename(:,2:4).' ./1000;
%Data conversion from N to E frame
[av_pos_inert, av_att, tar_pos_inert, tar_att] = ConvertASPENData(pos_av_aspen, att_av_aspen,  pos_tar_aspen, att_tar_aspen);
end

