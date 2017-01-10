function  [point] = linePlane (linePoint1x, linePoint1y, linePoint1z,linePoint2x, linePoint2y, linePoint2z,planePointX, planePointY, planePointZ, planeNormalX, planeNormalY, planeNormalZ)

%input for this function is all coordinates of points, each component
%seperated by a comma
%output is a 1x3 matrix displaying the coordinates of a point
%This function calculates the intersection between a line and a plane

% The two cases for dot product are explained in the write-up
%If neither of these is the case, then we know there is an intersection
%between the line and the plane. 
%math logic from wikipedia
%https://en.wikipedia.org/wiki/Line%E2%80%93plane_intersection
point=[0 0 0]; % initialize return result
pointOnLine=[linePoint1x linePoint1y linePoint1z];
normal=[planeNormalX planeNormalY planeNormalZ];
u=[linePoint1x linePoint1y linePoint1z]-[linePoint2x linePoint2y linePoint2z];
v=[planePointX planePointY planePointZ]-[linePoint1x linePoint1y linePoint1z];
if dot(u,normal)~=0
    s=dot(u,normal);
    t=dot(v,normal);
    %solving for equation of line
    %p=dl+l0 where d is scalar, l is direction vector and l0 is a point on
    %the line
    d=t/s;
    % point of intersection can be found  by dl+l0
    %d * the vector line + point on line will achieve the point of intersection
    point=d.*u + pointOnLine;
    return 
end

