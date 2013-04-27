function [ E ] = breakobject( E,num )
set(E(num).handle, 'visible','off')
if E(num).imghandle >0
    set(E(num).imghandle, 'visible','off')
end
end

