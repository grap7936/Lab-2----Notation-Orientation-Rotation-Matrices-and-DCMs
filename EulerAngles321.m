function attitude321 = EulerAngles321(DCM)

% Function Purpose: Use an input DCM to output euler angles in desired parameters for use in
% analysis of a aircraft system.

% Inputs:
% • DCM: a 3x3 rotation matrix containing the transformation processes for an Euler 321
% transformation

% Outputs:
% • attitude321: 3 x 1 vector with the 3-2-1 Euler angles in the form attitude321 = [𝛼𝛼, 𝛽𝛽, 𝛾𝛾]T (In
% ASEN 3728 notation, this would be equivalent to [𝜙,𝜃,𝜓]T ).


% Use definitions of angles from DCM elements to attain each euler angle
phi = arctan2d( (DCM(3,1))/(-1*DCM(3,2)) );
theta = -1*arcsin(DCM(1,3));
psi = arctan2d( (DCM(1,2))/(DCM(1,1)) );

% Define attitude in terms of extracted euler angles
attitude321 = [phi, theta, psi]';


end

