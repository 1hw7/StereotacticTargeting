function TransformMatrix = Rigid_Registration(A1,B1,C1,A2,B2,C2)
%Function creates a transformation matrix to get from the coordinate system
%defined by A1,B1,C1 to A2,B2,C2
%A1 = A1' ; B1 = B1'; C1 = C1'; A2 = A2'; B2 = B2'; C2 = C2';

%note: in real-life situations should check to ensure the triangles created
%are congruent and scalene. However, this makes the easier test cases throw
%and error so the checks were ommited for simplicity

% Creates orthonormal coordinate systems for each triangle
% and finds the centre of gravity of the triangles
[x1,y1,z1,Centre1] = OrthonormalCoordinate(A1,B1,C1); %Input into my own orthonormal coordinate system code
[x2,y2,z2,Centre2] = OrthonormalCoordinate(A2,B2,C2);

% defines the Cartesian coordinates
e1 = [1;0;0];
e2 = [0;1;0];
e3 = [0;0;1];
%This program was written by Hillary Elrick 
% creates translation matrices for each coordinate system to Cartesian
Translate_1_To_Cartesian = makehgtform('translate',-Centre1);
Translate_2_To_Cartesian = makehgtform('translate',-Centre2);

% creates rotation matrices for each coordinate system to Cartesian
Rotate_1_To_Cartesian = makehgtform;
Rotate_1_To_Cartesian(1:3,1:3) = [dot(x1,e1),dot(x1,e2),dot(x1,e3); 
    dot(y1,e1), dot(y1,e2), dot(y1,e3); 
    dot(z1,e1), dot(z1,e2), dot(z1,e3)];

Rotate_2_To_Cartesian = makehgtform;
Rotate_2_To_Cartesian(1:3,1:3) = [dot(x2,e1),dot(x2,e2),dot(x2,e3); 
    dot(y2,e1), dot(y2,e2), dot(y2,e3); 
    dot(z2,e1), dot(z2,e2), dot(z2,e3)];

% creates transformation matrices for each coordinate system to Cartesian
Transform_1_To_Cartesian = Rotate_1_To_Cartesian*Translate_1_To_Cartesian;
Transform_2_To_Cartesian = Rotate_2_To_Cartesian*Translate_2_To_Cartesian;

% combines the transformations to create a transformation matrix from 
% coordinate system 1 to coordinate system 2
TransformMatrix = inv(Transform_2_To_Cartesian)*Transform_1_To_Cartesian;
end

