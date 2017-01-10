function[ctimagePoints]=FiducialSimulator(transmatrix)
%Input: 4x4 transformation matrix 
%output: 9 CT image points


%%These points represent the bottom and top point of each rod, the set of
%%points created the 3 rods for each side (left, right and anterior) of the
%%fiducial cage

a=10; %Length of rod
%%Anterior frame points
anteriorbottomRod1=[a/2,3*a/2,-a/2];
anteriortopRod1=[a/2,3*a/2,a/2];
anteriorbottomRod2=[-a/2,3*a/2,-a/2];
anteriortopRod3=[-a/2,3*a/2,a/2];
rod1=[anteriorbottomRod1;anteriortopRod1];
rod2=[anteriortopRod1;anteriorbottomRod2];
rod3=[anteriorbottomRod2;anteriortopRod3];

%Left Frame
leftbottomRod1=[-a,a/2,-a/2];
lefttopRod1=[-a,a/2,a/2];
leftbottomRod2=[-a,-a/2,-a/2];
lefttopRod3=[-a,-a/2,a/2];
leftrod1=[leftbottomRod1;lefttopRod1];
leftrod2=[lefttopRod1;leftbottomRod2];
leftrod3=[leftbottomRod2;lefttopRod3];
 
%Right Frame
rightbottomRod1=[a,-a/2,-a/2];
righttopRod1=[a,-a/2,a/2];
rightbottomRod2=[a,a/2,-a/2];
righttopRod3=[a,a/2,a/2];
rightrod1=[rightbottomRod1;righttopRod1];
rightrod2=[righttopRod1;rightbottomRod2];
rightrod3=[rightbottomRod2;righttopRod3];



%Matrix of all points which construct the fiducial rods (for simplicity in
%creating intersection points)
wholeMatrixanterior=[anteriorbottomRod1;anteriortopRod1;anteriorbottomRod2;anteriortopRod3];
wholeMatrixleft=[leftbottomRod1;lefttopRod1;leftbottomRod2;lefttopRod3];
wholeMatrixright=[rightbottomRod1;righttopRod1;rightbottomRod2;righttopRod3];

%%3 for loops in order to faciliate adding points in order of anterior
%%frame, left frame, followed by right frame

%deconstructing transmatrix into rotation matrix and translation matrix 
transformationMatrix=[transmatrix(1,1:3) 0; transmatrix(2,1:3) 0; transmatrix(3,1:3) 0; transmatrix(4,1:3) 1];
translation=[1 0 0 transmatrix(1,4); 0 1 0 transmatrix(2,4); 0 0 1 transmatrix(3,4); 0 0 0 transmatrix(4,4)];

ctimagePoints=[];
%%Points are padded by a 1, then multiplied by rotation matrix followed by
%%translation matrix. Then, the line plane intersect is determined between
%%the rods which lie on a diagonal, and the xy plane
for i=1:3 
    Points1anterior=[wholeMatrixanterior(i,1:3); wholeMatrixanterior(i+1,1:3)]; %points padded by 1 for matrix multiplication
    rotatedpaddedPointanterior=[transformationMatrix(1:3,1:3)*Points1anterior(1,1:3)';transformationMatrix(1:3,1:3)*Points1anterior(2,1:3)']; %rotating points
    rotatedpaddedPointanterior=[rotatedpaddedPointanterior(1:3,1)' 1; rotatedpaddedPointanterior(4:6,1)' 1]; % rotating matrix and padding each point with a 1 for matrix multipliaction
    rtranslatedpaddedPointanterior=[translation*rotatedpaddedPointanterior(1,1:4)' translation*rotatedpaddedPointanterior(2,1:4)'];%multiplying rotated point by translation matrix
    ctPoint=linePlane(rtranslatedpaddedPointanterior(1,1),rtranslatedpaddedPointanterior(2,1),rtranslatedpaddedPointanterior(3,1),rtranslatedpaddedPointanterior(1,2),rtranslatedpaddedPointanterior(2,2),rtranslatedpaddedPointanterior(3,2),0,0,0,0,0,1);
    ctimagePoints=[ctimagePoints;ctPoint];
end
for i=1:3%Same process, adding left frame CT points
    Pointsleft=[wholeMatrixleft(i,1:3); wholeMatrixleft(i+1,1:3)];
    rotatedpaddedPointleft=[transformationMatrix(1:3,1:3)*Pointsleft(1,1:3)';transformationMatrix(1:3,1:3)*Pointsleft(2,1:3)'];
    rotatedpaddedPointleft=[rotatedpaddedPointleft(1:3,1)' 1; rotatedpaddedPointleft(4:6,1)' 1];
    leftrtranslatedpaddedPoint=[translation*rotatedpaddedPointleft(1,1:4)' translation*rotatedpaddedPointleft(2,1:4)'];
    ctPoint=linePlane(leftrtranslatedpaddedPoint(1,1),leftrtranslatedpaddedPoint(2,1),leftrtranslatedpaddedPoint(3,1),leftrtranslatedpaddedPoint(1,2),leftrtranslatedpaddedPoint(2,2),leftrtranslatedpaddedPoint(3,2),0,0,0,0,0,1);
    ctimagePoints=[ctimagePoints;ctPoint];
end
for i=1:3 %Same process, adding right frame points
    Points1right=[wholeMatrixright(i,1:3); wholeMatrixright(i+1,1:3)];
    rotatedpaddedpointright=[transformationMatrix(1:3,1:3)*Points1right(1,1:3)';transformationMatrix(1:3,1:3)*Points1right(2,1:3)'];
    rotatedpaddedpointright=[rotatedpaddedpointright(1:3,1)' 1; rotatedpaddedpointright(4:6,1)' 1];
    rightrtranslatedpaddedPoint=[translation*rotatedpaddedpointright(1,1:4)' translation*rotatedpaddedpointright(2,1:4)'];
    ctPoint=linePlane(rightrtranslatedpaddedPoint(1,1),rightrtranslatedpaddedPoint(2,1),rightrtranslatedpaddedPoint(3,1),rightrtranslatedpaddedPoint(1,2),rightrtranslatedpaddedPoint(2,2),rightrtranslatedpaddedPoint(3,2),0,0,0,0,0,1);
    ctimagePoints=[ctimagePoints;ctPoint];
end 

%%The following code is for plotting. Uncomment if you would like a figure
%%of the ground truth fiducial cage.

%     
% %%Plotting the fiducial rods and plane of intersect, code from following
% point = [0,0,0];
% normal = [0,0,1];
% 
% %# a plane is a*x+b*y+c*z+d=0
% %# [a,b,c] is the normal. Thus, we have to calculate
% %# d and we're set
% d = -point*normal'; %'# dot product for less typing
% 
% %# create x,y
% [xx,yy]=ndgrid(-10:10,-10:20);
% 
% %# calculate corresponding z
% z = (-normal(1)*xx - normal(2)*yy - d)/normal(3);
% 
% 
% %%Plotting the fiducial rods and the plane (ct image)
% hold on
% plot3(rod1(:,1),rod1(:,2),rod1(:,3));
% plot3(rod2(:,1),rod2(:,2),rod2(:,3));
% plot3(rod3(:,1),rod3(:,2),rod3(:,3));
% 
% plot3(leftrod1(:,1),leftrod1(:,2),leftrod1(:,3));
% plot3(leftrod2(:,1),leftrod2(:,2),leftrod2(:,3));
% plot3(leftrod3(:,1),leftrod3(:,2),leftrod3(:,3));
% 
% plot3(rightrod1(:,1),rightrod1(:,2),rightrod1(:,3));
% plot3(rightrod2(:,1),rightrod2(:,2),rightrod2(:,3));
% plot3(rightrod3(:,1),rightrod3(:,2),rightrod3(:,3));
% surf(xx,yy,z);
% alpha(0.1);
end
