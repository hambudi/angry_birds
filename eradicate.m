function [E] = eradicate( E,num)
%ERADICATE Summary of this function goes here
%   Detailed explanation goes here
     E = [E(1:num-1) E(num+1:end)];

end

