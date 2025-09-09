%{
Author(s): Graeme Appel, Drake Klenz, Daniel Ghoreyshi, Harroop Sooch
Course: ASEN 3801 -- Aero Vehicle Dynamics and Controls Lab 2:  Notation, Orientation, Rotation
Matrices and DCMs
Goal: Complete Applications Regarding Dynamical Systems

Application 1 -- 
Inputs: TBD
Outputs: TBD
Purpose:

Application 2 -- 
Inputs: TBD
Outputs: TBD
Purpose:

%}

%% Housekeeping 

clc
clear
close all

%% Load in Data from .csv file using Function 1

% Create data set and then read in .csv file information 

data = readmatrix("Lab2Data1.csv");
[t_vec, av_pos_inert, av_att, tar_pos_inert, tar_att] = LoadASPENData(data);

%% Calling DCM 1 (3-2-1) using Function 2

DCM_321 = RotationMatrix321(av_att);

%% Getting 3-1-3 Euler Angles using Function 5

attitude313 = EulerAngles313(DCM_321);

%% Calling DCM 2 (3-1-3) using Function 4

DCM_313 = RotationMatrix313(attitude313);

%% Getting 3-2-1 Euler Angles using Function 3

attitude321 = EulerAngles321(DCM_313);

%% Question 3

