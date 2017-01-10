function[result]=ctToCageTransform (CTpoints)
%%Ct to cage transoform
%input: 9 CT points (ordered as: 3 anterior points, followed by 
% 3 points left side, followed by 3 points right side
%Output:  4x4 tranformation matrix(result) which determines how to transform CT points
%to fiducial cage space

a=10; %dimension of straight rod as given (10 cm)

%Diagonal rods which form "N" sttructure on anterior, left and right side
%are used. On each side (left, anterior and right) the two points were used to determine a direction
%vector, and the topRod1 points were used as a point on the line
%Formula was point=topRod1 +directionvector*t

%points on anterior of fiducial cage
anteriortopRod1=[a/2,3*a/2,a/2];
anteriorbottomRod2=[-a/2,3*a/2,-a/2];
directionVector1=anteriorbottomRod2-anteriortopRod1;
directionVector1=directionVector1/norm(directionVector1);

%points on left of fiducial cage
lefttopRod1=[-a,a/2,a/2];
leftbottomRod2=[-a,-a/2,-a/2];
directionVector2=leftbottomRod2-lefttopRod1;
directionVector2=directionVector2/norm(directionVector2);

% points on right side of fiducial cage
righttopRod1=[a,-a/2,a/2];
rightbottomRod2=[a,a/2,-a/2];
directionVector3=rightbottomRod2-righttopRod1;
directionVector3=directionVector3/norm(directionVector3);

Length=10*(sqrt(2)); %As seen in write up, we calculate Length of longest dimension of fiducial cage

%%Finding center point for anterior side of fiducial cage
distancepoint1point2=sqrt(sum((CTpoints(1,1:3) - (CTpoints(2,1:3))) .^2,2)); %d12 in write up
distancepoint2point3=sqrt(sum((CTpoints(2,1:3) - (CTpoints(3,1:3))) .^2,2));% d23 in write up
t=Length*(distancepoint1point2/(distancepoint1point2+distancepoint2point3));%calculate t using d12, d23 and Length
point1=anteriortopRod1+t*directionVector1;

%%Finding center point for left side of fiducial cage (uses same method as
%%above)
leftdistancepoint1point2=sqrt(sum((CTpoints(4,1:3) - (CTpoints(5,1:3))) .^2,2));
leftdistancepoint2point3=sqrt(sum((CTpoints(5,1:3) - (CTpoints(6,1:3))) .^2,2));
tleft=Length*(leftdistancepoint1point2)/(leftdistancepoint1point2+leftdistancepoint2point3);
point2= lefttopRod1+directionVector2*tleft;

%%Finding center point for left side of fiducial cage (same method) 
rightdistancepoint1point2=sqrt(sum((CTpoints(7,1:3) - (CTpoints(8,1:3))) .^2,2));
rightdistancepoint2point3=sqrt(sum((CTpoints(8,1:3) - (CTpoints(9,1:3))) .^2,2));
rightt=Length*(rightdistancepoint1point2/(rightdistancepoint1point2+rightdistancepoint2point3));
point3=righttopRod1 +directionVector3*rightt;

%point1,point2,point3 create an orthonormal coordinate system as do center
%CT points. These are input into The rigid registration transform from
%assignment 1

result=Rigid_Registration(CTpoints(2,1:3),CTpoints(5,1:3),CTpoints(8,1:3),point1,point2,point3);

end
