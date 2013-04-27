function [ E ] = makeobject( E )
for i = 1:length(E)
    if E(i).style == 31||E(i).style == 3
        E(i).imghandle = image(E(i).imgdata);
    end
    if E(i).style ==5
        E(i).imghandle = image(E(i).imgdata);
    end
E(i).center2 = E(i).center1;
E(i).angle2 = E(i).angle1;
E(i).avelocity1=E(i).avelocity;
E(i).Ar1 = [cos(E(i).angle1) -sin(E(i).angle1); sin(E(i).angle1) cos(E(i).angle1)]*E(i).A;
E(i).Br1 = [cos(E(i).angle1) -sin(E(i).angle1); sin(E(i).angle1) cos(E(i).angle1)]*E(i).B;
E(i).Ar2 = E(i).Ar1;
E(i).Br2 = E(i).Br1;
vert = [E(i).center1+E(i).Ar1+E(i).Br1 E(i).center1-E(i).Ar1+E(i).Br1 E(i).center1-E(i).Ar1-E(i).Br1 E(i).center1+E(i).Ar1-E(i).Br1];


% E.handle = fill(vert(1,:),vert(2,:),E.color);
E(i).handle = fill(vert(1,:),vert(2,:),E(i).color);


end

