function attitude321 = EulerAngles321(DCM)

% Purpose: Use an input DCM to output euler angles in desired parameters for use in
% analysis of a aircraft system.

% Inputs:
% • DCM: a 3x3 rotation matrix containing the transformation processes for an Euler 321
% transformation

% Outputs:
% • attitude321: 3 x 1 vector with the 3-2-1 Euler angles in the form attitude321 = [𝛼𝛼, 𝛽𝛽, 𝛾𝛾]T (In
% ASEN 3728 notation, this would be equivalent to [𝜙,𝜃,𝜓]T ).

attitude321 = zeros(3, 1, length(DCM));

for i = 1 : length(DCM)

% Use definitions of angles from DCM elements to attain each euler angle
phi = atan2(DCM(2,3,i),DCM(3,3,i));
theta = -1*asin(DCM(1,3,i));
psi = atan2( (DCM(1,2,i)),(DCM(1,1,i)) );

% Define attitude in terms of extracted euler angles
attitude321(:,:,i) = [phi, theta, psi]';

end


end

