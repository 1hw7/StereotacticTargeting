function[x,y,z,ctr]=OrthonormalCoordinate(point1,point2,point3)
% The center of gravity
%was simply determined to be the average of the 3 points of the triangle. The orthonormal
%coordinate system was calculated using the 3 points of the triangle, then
%the system could simply be translated to the center of gravity point. The
%three vectors were calculated by 
% 1. determining the vector between point 1 and 2
% 2. taking the cross product of vector1 with vector between points 1 and 3, we will obtain a second vector which is orthogonal to the 1st
% 2. taking the cross product of the 1st and 2nd orthogonal vectors, we obtain a 3rd orthogonal vector
% 4. All vectors are normalized, and we have obtained an orthonormal coordinate system centered at the centre of gravity of the triangle
    ctr=point1+point2+point3;
    ctr=ctr/3;
    x=point1-point3;
    y=cross(x,point1-point2);
    z=cross(x,y);
    x=x/norm(x);
    y=y/norm(y);
    z=z/norm(z); 
    return
end
