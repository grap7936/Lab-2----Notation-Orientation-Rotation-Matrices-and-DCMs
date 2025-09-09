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
filename = readmatrix("Lab2Data1.csv");

pos_av_N =  filename(:,11:13).' ./1000; 
att_av_N = filename(:,8:10).' ./1000;
pos_tar_N = filename(:,5:7).' ./1000;
att_tar_N = filename(:,2:4).' ./1000;

[t_vec, av_pos_inert, av_att, tar_pos_inert, tar_att] = LoadASPENData(filename);

%% Calling DCM 1 (3-2-1) using Function 2

DCM_321 = RotationMatrix321(av_att);

%% Getting 3-1-3 Euler Angles using Function 5

attitude313 = EulerAngles313(DCM_321);

%% Calling DCM 2 (3-1-3) using Function 4

DCM_313 = RotationMatrix313(attitude313);

%% Getting 3-2-1 Euler Angles using Function 3

attitude321 = EulerAngles321(DCM_313);

%% Question 3

% Devectorize inertial position vector --> For the drone
x_pos_drone = pos_av_N(1,:);
y_pos_drone = pos_av_N(2,:);
z_pos_drone = pos_av_N(3,:);

% Devectorize inertial position vector --> For the target
x_pos_tar = pos_tar_N(1,:);
y_pos_tar = pos_tar_N(2,:);
z_pos_tar = pos_tar_N(3,:);


figure();
plot3(x_pos_drone, y_pos_drone, z_pos_drone, "b", 'LineWidth', 1.5)
hold on;
plot3(x_pos_tar, y_pos_tar, z_pos_tar, "r--", 'LineWidth', 1.5)
legend('Position vector of Drone in Inertial Frame', 'Position vector of Target in Inertial Frame', 'Location', 'best')
xlabel('X Position [m]')
ylabel('Y Position [m]')
zlabel('Z Position [m]')
title("3D Inertial Vehicle Path")

%% Question 4

% Devectorize inertial position vector --> For the drone
x_pos_drone_E = av_pos_inert(1,:);
y_pos_drone_E = av_pos_inert(2,:);
z_pos_drone_E = av_pos_inert(3,:);

% Devectorize inertial position vector --> For the target
x_pos_tar_E = tar_pos_inert(1,:);
y_pos_tar_E = tar_pos_inert(2,:);
z_pos_tar_E = tar_pos_inert(3,:);



figure();
subplot(3,1,1)
plot(t_vec, x_pos_drone_E, "b", "LineWidth",1.5)
hold on 
plot(t_vec, y_pos_tar_E, "r--", "LineWidth",1.5)
subplot(3,1,2)
plot(t_vec, y_pos_drone_E, "b", "LineWidth",1.5)
hold on 
plot(t_vec, x_pos_tar_E, "r--", "LineWidth",1.5)
subplot(3,1,3)
plot(t_vec, z_pos_drone_E, "b", "LineWidth",1.5)
hold on 
plot(t_vec, z_pos_tar_E, "r--", "LineWidth",1.5)


attitude321_deg = rad2deg(attitude321);
phi = zeros(1,length(attitude321_deg));
theta = phi;
psi = phi;
for i = 1 : length(attitude321_deg(1,1,:))
phi(1,i) = attitude321_deg(1,1,i);
theta(1,i) = attitude321_deg(2,1,i);
psi(1,i) = attitude321_deg(3,1,i);
end

figure();
subplot(3,1,1)
plot(t_vec, phi,"b", "LineWidth",1.5)
subplot(3,1,2)
plot(t_vec, theta,"b","LineWidth",1.5)
subplot(3,1,3)
plot(t_vec, psi,"b","LineWidth",1.5)
