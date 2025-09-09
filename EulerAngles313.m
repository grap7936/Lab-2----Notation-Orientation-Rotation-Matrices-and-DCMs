function attitude313 = EulerAngles313(DCM)

Y = atan2((DCM(3,1)),(-1*DCM(3,2)));
B = acos(DCM(3,3));
A = atan2((DCM(1,3)),(-1*DCM(2,3)));

attitude313 = [A;B;Y];
end