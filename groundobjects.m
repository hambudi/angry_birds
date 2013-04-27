function [ E ] = groundobjects( E )
%GROUNDOBJECTS Summary of this function goes here
%   Detailed explanation goes here
    for i = 1:length(E)
        if norm(E(i).lvelocity1) <.3 && norm(E(i).lvelocity1) ~= 0 && abs(E(i).avelocity1) <.1
            E(i).ground =1;
            set(E(i).handle, 'facecolor','b')
        end
    end
            

end

