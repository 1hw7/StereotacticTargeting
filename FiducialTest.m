% Testing function for FiducialSimulator and ctToCageTransofrm function
% 
% Rotation matrices (used 5 degree rotation around x,y, and z)
xmatrix= makehgtform('xrotate',deg2rad(5));
ymatrix= makehgtform('yrotate',deg2rad(5));
zmatrix= makehgtform('zrotate',deg2rad(5));


%Test 1: x rotation
disp('Test 1:x rotation (result should be [0 0 0 1])');
GFC=[0 0 0 1]*xmatrix; %pad [0 0 0] point with a 1 to multiply by 4x4 rotation matrix
CTpoints=FiducialSimulator(xmatrix);   
solution=ctToCageTransform(CTpoints)
multiply=GFC(1,1:3)*solution(1:3,1:3);
answer= [multiply';1];
translation=[1 0 0 solution(1,4); 0 1 0 solution(2,4); 0 0 1 solution(3,4); 0 0 0 1];
result=translation*answer;
num2str(result,'%.1f')

%Test 2: y rotation
disp('Test 2:y rotation (result should be [0 0 0 1])');
GFC=[0 0 0 1]*ymatrix;
CTpoints=FiducialSimulator(ymatrix);   
solution=ctToCageTransform(CTpoints)    
multiply=GFC(1,1:3)*solution(1:3,1:3);
answer= [multiply';1];
translation=[1 0 0 solution(1,4); 0 1 0 solution(2,4); 0 0 1 solution(3,4); 0 0 0 1];
result=translation*answer;
num2str(result,'%.1f')

%Test 3: z rotation
disp('Test 3:z rotation (result should be [0 0 0 1])');
GFC=[0 0 0 1]*zmatrix;
CTpoints=FiducialSimulator(zmatrix);   
solution=ctToCageTransform(CTpoints)    
multiply=GFC(1,1:3)*solution(1:3,1:3);
answer= [multiply';1];
translation=[1 0 0 solution(1,4); 0 1 0 solution(2,4); 0 0 1 solution(3,4); 0 0 0 1];
result=translation*answer;
num2str(result,'%.1f')

% Test 4: x translation
disp('Test 4:x translation (result should be [0 0 0 1])');
GFC=[0 0 0 1]+[2 0 0 0]; %adding x translation of 2
CTpoints=FiducialSimulator([1 0 0 2; 0 1 0 0; 0 0 1 0; 0 0 0 1]);  %adding x translation of 2 
solution=ctToCageTransform(CTpoints)
multiply=GFC(1,1:3)*solution(1:3,1:3);
answer= [multiply';1];
translation=[1 0 0 solution(1,4); 0 1 0 solution(2,4); 0 0 1 solution(3,4); 0 0 0 1];
result=translation*answer;
num2str(result,'%.1f')

% Test 5: y translation
disp('Test 5:y translation (result should be [0 0 0 1])');
GFC=[0 0 0 1]+[0 2 0 0]; %adding y translation of 2
CTpoints=FiducialSimulator([1 0 0 0; 0 1 0 2; 0 0 1 0; 0 0 0 1]);   %adding y translation of 2
solution=ctToCageTransform(CTpoints)
multiply=GFC(1,1:3)*solution(1:3,1:3);
answer= [multiply';1];
translation=[1 0 0 solution(1,4); 0 1 0 solution(2,4); 0 0 1 solution(3,4); 0 0 0 1];
result=translation*answer;
num2str(result,'%.1f')

%Test 6: z translation
disp('Test 6:z translation (result should be [0 0 0 1])');
GFC=[0 0 0 1]+[0 0 2 0]; %adding z translation of 2
CTpoints=FiducialSimulator([1 0 0 0; 0 1 0 0; 0 0 1 2; 0 0 0 1]);  %adding z translation of 2 
solution=ctToCageTransform(CTpoints)
multiply=GFC(1,1:3)*solution(1:3,1:3);
answer= [multiply';1];
translation=[1 0 0 solution(1,4); 0 1 0 solution(2,4); 0 0 1 solution(3,4); 0 0 0 1];
result=translation*answer;
num2str(result,'%.1f')

%Test 7: x rotation and x translation
disp('Test 7:x rotation and translation (result should be [0 0 0 1])');
GFC=([0 0 0 1]*xmatrix)+[2 0 0 0];%Rotation around x of 5 degrees, translation of +2 in x direction
xmatrix2=[xmatrix(1,1:3) 2; xmatrix(2,1:4);xmatrix(3,1:4);xmatrix(4,1:4)];
CTpoints=FiducialSimulator(xmatrix2);   
solution=ctToCageTransform(CTpoints)   
multiply=GFC(1,1:3)*solution(1:3,1:3);
answer= [multiply';1];
translation=[1 0 0 solution(1,4); 0 1 0 solution(2,4); 0 0 1 solution(3,4); 0 0 0 1];
result=translation*answer;
num2str(result,'%.1f')

%Test 8: y rotation and y translation
disp('Test 8:y rotation and translation (result should be [0 0 0 1])');
GFC=([0 0 0 1]*ymatrix)+[0 2 0 0]; %Rotation around y of 5 degrees, translation of +2 in y direction
ymatrix2=[ymatrix(1,1:4); ymatrix(2,1:3) 2;ymatrix(3,1:4);ymatrix(4,1:4)];
CTpoints=FiducialSimulator(ymatrix2);   
solution=ctToCageTransform(CTpoints)    
multiply=GFC(1,1:3)*solution(1:3,1:3);
answer= [multiply';1];
translation=[1 0 0 solution(1,4); 0 1 0 solution(2,4); 0 0 1 solution(3,4); 0 0 0 1];
result=translation*answer;
num2str(result,'%.1f')

% Test 9: z rotation and z translation
disp('Test 9:z rotation and translation (result should be [0 0 0 1])');
GFC=([0 0 0 1]*zmatrix)+[0 0 2 0]; %Rotation around y of 5 degrees, translation of +2 in y direction
zmatrix2=[zmatrix(1,1:4); zmatrix(2,1:4);zmatrix(3,1:3) 2;zmatrix(4,1:4)];
CTpoints=FiducialSimulator(zmatrix2);   
solution=ctToCageTransform(CTpoints)    
multiply=GFC(1,1:3)*solution(1:3,1:3);
answer= [multiply';1];
translation=[1 0 0 solution(1,4); 0 1 0 solution(2,4); 0 0 1 solution(3,4); 0 0 0 1];
result=translation*answer;
num2str(result,'%.1f')


