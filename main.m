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
filename(any(isnan(filename), 2), :) = [];

% Define initial target and drone position in the inertial frame as given by the .csv
pos_av_N =  filename(:,11:13).' ./1000; 
att_av_N = filename(:,8:10).' ./1000;
pos_tar_N = filename(:,5:7).' ./1000;
att_tar_N = filename(:,2:4).' ./1000;

% Apply function to convert into data in the E frame
[t_vec, av_pos_inert, av_att, tar_pos_inert, tar_att] = LoadASPENData(filename);

%% Calling DCM 1 (3-2-1) using Function 2

DCM_321_Vehicle = RotationMatrix321(av_att);
DCM_321_Target = RotationMatrix321(tar_att);

%% Getting 3-1-3 Euler Angles using Function 5

attitude313_Vehicle = EulerAngles313(DCM_321_Vehicle);
attitude313_Target = EulerAngles313(DCM_321_Target);

%% Calling DCM 2 (3-1-3) using Function 4

DCM_313_Vehicle = RotationMatrix313(attitude313_Vehicle);
DCM_313_Target = RotationMatrix313(attitude313_Target);

%% Getting 3-2-1 Euler Angles using Function 3

attitude321_Vehicle = EulerAngles321(DCM_313_Vehicle);
attitude321_Target = EulerAngles321(DCM_313_Target);

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


% Plot position in X,Y,Z of the target in the E-frame (after converting with convertASPENData)
figure();

subplot(3,1,1)
plot(t_vec, x_pos_drone_E, "b", "LineWidth",1.5)
hold on 
plot(t_vec, x_pos_tar_E, "r--", "LineWidth",1.5)
xlabel('Time')
ylabel('X position [m]')
title('Position in X of the Drone and Target in E Frame')
legend('Position X of Drone in E Frame', 'Position X of Target in E Frame', 'Location', 'best')


subplot(3,1,2)
plot(t_vec, y_pos_drone_E, "b", "LineWidth",1.5)
hold on 
plot(t_vec, y_pos_tar_E, "r--", "LineWidth",1.5)
xlabel('Time')
ylabel('Y position [m]')
title('Position in Y of the Drone and Target in E Frame')
legend('Position Y of Drone in E Frame', 'Position Y of Target in E Frame', 'Location', 'best')

subplot(3,1,3)
plot(t_vec, z_pos_drone_E, "b", "LineWidth",1.5)
hold on 
plot(t_vec, z_pos_tar_E, "r--", "LineWidth",1.5)
xlabel('Time')
ylabel('Z position [m]')
title('Position in Z of the Drone and Target in E Frame')
legend('Position Z of Drone in E Frame', 'Position Z of Target in E Frame', 'Location', 'best')

% Convert 321 attitude to degrees and assign to each vector component to graph
attitude321_deg = rad2deg(attitude321_Vehicle);
phi = zeros(1,length(attitude321_deg));
theta = phi;
psi = phi;
for i = 1 : length(attitude321_deg(1,1,:))
phi(1,i) = attitude321_deg(1,1,i);
theta(1,i) = attitude321_deg(2,1,i);
psi(1,i) = attitude321_deg(3,1,i);
end

attitude321_deg2 = rad2deg(attitude321_Target);
phi2 = zeros(1,length(attitude321_deg2));
theta2 = phi2;
psi2 = phi2;
for i = 1 : length(attitude321_deg2(1,1,:))
phi2(1,i) = attitude321_deg2(1,1,i);
theta2(1,i) = attitude321_deg2(2,1,i);
psi2(1,i) = attitude321_deg2(3,1,i);
end

% Graph changing euler angle values with time
figure();

subplot(3,1,1)
plot(t_vec, phi,"b", "LineWidth",1.5)
hold on 
plot(t_vec, phi2,"r--", "LineWidth",1.5)
xlabel('Time')
ylabel('Phi [degrees]')
title('Changing Euler Angle Phi (321) Over Time')
legend('Phi of Drone in E Frame', 'Phi of Target in E Frame', 'Location', 'best')

subplot(3,1,2)
plot(t_vec, theta,"b","LineWidth",1.5)
hold on 
plot(t_vec, theta2,"r--", "LineWidth",1.5)
xlabel('Time')
ylabel('Theta [degrees]')
title('Changing Euler Angle (321) Theta Over Time')
legend('Theta of Drone in E Frame', 'Theta of Target in E Frame', 'Location', 'best')

subplot(3,1,3)
plot(t_vec, psi,"b","LineWidth",1.5)
hold on 
plot(t_vec, psi2,"r--", "LineWidth",1.5)
xlabel('Time')
ylabel('Psi [degrees]')
title('Changing Euler Angle (321) Psi Over Time')
legend('Psi of Drone in E Frame', 'Psi of Target in E Frame', 'Location', 'best')



%% Question 5

% Convert 313 attitude to degrees and assign to each vector component to graph
attitude313_deg3 = rad2deg(attitude313_Vehicle);
phi3 = zeros(1,length(attitude313_deg3));
theta3 = phi3;
psi3 = phi3;
for i = 1 : length(attitude313_deg3(1,1,:))
phi3(1,i) = attitude313_deg3(1,1,i);
theta3(1,i) = attitude313_deg3(2,1,i);
psi3(1,i) = attitude313_deg3(3,1,i);
end

% Convert 313 attitude to degrees and assign to each vector component to graph
attitude313_deg4 = rad2deg(attitude313_Target);
phi4 = zeros(1,length(attitude313_deg4));
theta4 = phi4;
psi4 = phi4;
for i = 1 : length(attitude313_deg4(1,1,:))
phi4(1,i) = attitude313_deg4(1,1,i);
theta4(1,i) = attitude313_deg4(2,1,i);
psi4(1,i) = attitude313_deg4(3,1,i);
end

% Graph changing euler angle values with time
figure();

subplot(3,1,1)
plot(t_vec, phi3,"b", "LineWidth",1.5)
hold on 
plot(t_vec, phi4,"r--", "LineWidth",1.5)
xlabel('Time')
ylabel('Phi [degrees]')
title('Changing Euler Angle (313) Phi Over Time')

subplot(3,1,2)
plot(t_vec, theta3,"b","LineWidth",1.5)
hold on 
plot(t_vec, theta4,"r--", "LineWidth",1.5)
xlabel('Time')
ylabel('Theta [degrees]')
title('Changing Euler Angle (313) Theta Over Time')

subplot(3,1,3)
plot(t_vec, psi3,"b", "LineWidth",1.5)
hold on 
plot(t_vec, psi4,"r--", "LineWidth",1.5)
xlabel('Time')
ylabel('Psi [degrees]')
title('Changing Euler Angle (313) Psi Over Time')

%% Question 6

r_rel_E = tar_pos_inert - av_pos_inert; 

% Extract components for plotting
x_rel_E = r_rel_E(1,:);
y_rel_E = r_rel_E(2,:);
z_rel_E = r_rel_E(3,:);

figure();
subplot(3,1,1)
plot(t_vec, x_rel_E, "LineWidth", 1.5)
xlabel('Time [s]')
ylabel('X_rel [m]')
title('Relative X Position (Target wrt Vehicle) in Frame E')

subplot(3,1,2)
plot(t_vec, y_rel_E, "LineWidth",1.5)
xlabel('Time [s]')
ylabel('Y_rel [m]')
title('Relative Y Position (Target wrt Vehicle) in Frame E')

subplot(3,1,3)
plot(t_vec, z_rel_E, "LineWidth",1.5)
xlabel('Time [s]')
ylabel('Z_rel [m]')
title('Relative Z Position (Target wrt Vehicle) in Frame E')

%% Question 7

