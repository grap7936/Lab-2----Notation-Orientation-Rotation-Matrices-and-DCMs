close all;
clear;
clc;
data=readmatrix("Lab2Data1.csv")
[t_vec, av_pos_inert, av_att, tar_pos_inert, tar_att] = LoadASPENData(data);
