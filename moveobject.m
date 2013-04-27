function [E] = moveobject( E ,dt)
%MOVEOBJECT Summary of this function goes here
%   Detailed explanation goes here
a = length(E);
for i = 2:a
    E(i).lvelocity1 = E(i).lvelocity +dt*E(i).lacc;
    E(i).center2 = E(i).center1 + dt*E(i).lvelocity;
    E(i).angle2 = E(i).angle1 + dt*E(i).avelocity;
    E(i).Ar2 = [cos(E(i).angle2) -sin(E(i).angle2); sin(E(i).angle2) cos(E(i).angle2)]*E(i).A;
    E(i).Br2 = [cos(E(i).angle2) -sin(E(i).angle2); sin(E(i).angle2) cos(E(i).angle2)]*E(i).B;
end
end

