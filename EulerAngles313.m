function attitude313 = EulerAngles313(DCM)

attitude313 = zeros(3,1,length(DCM));

for i = 1 : length(DCM)

Y = atan2((DCM(3,1,i)),(-1*DCM(3,2,i)));
B = acos(DCM(3,3,i));
A = atan2((DCM(1,3,i)),(DCM(2,3,i)));

attitude313(:,:, i) = [A;B;Y];

end

end
