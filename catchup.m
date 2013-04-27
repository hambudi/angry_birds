function [E] = catchup(E)
for i = 2:length(E)
    E(i).Ar1 =E(i).Ar2;
    E(i).Br1 =E(i).Br2;
    E(i).angle1 =E(i).angle2;
    if E(i).ground ~= 1
        if E(i).style ~= 1
            E(i).center1 =E(i).center2;
        end
        E(i).lvelocity1 =E(i).lvelocity1 + E(i).alvelocity;
        E(i).avelocity1 =E(i).avelocity1*.9+ E(i).aavelocity;
    end
    E(i).lvelocity = E(i).lvelocity1;
    E(i).avelocity = E(i).avelocity1;
    E(i).aavelocity = 0;
    E(i).alvelocity = [0;0];
end
end

