function attitude313 = EulerAngles313(DCM)

Y = arctan2d((DCM(3,1))/(-1*DCM(3,2)));
B = arccos(DCM(3,3));
A = arctan2d((DCM(1,3))/(-1*DCM(2,3)));

attitude313 = [A;B;Y];
end