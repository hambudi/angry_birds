function E = setobject( E )
for i = 1:length(E)
    if E(i).style == 31||E(i).style == 3||E(i).style == 32
        set(E(i).imghandle, 'xdata',[E(i).center1(1)-E(i).A(1) E(i).center1(1)+E(i).A(1)], 'ydata',[E(i).center1(2)+E(i).B(2) E(i).center1(2)-E(i).B(2)])
        set(E(i).handle,'visible','off')
    end
    if E(i).style ==5
        set(E(i).imghandle, 'xdata',[E(i).center1(1)-E(i).A(1) E(i).center1(1)+E(i).A(1)], 'ydata',[E(i).center1(2)+E(i).B(2) E(i).center1(2)-E(i).B(2)])
        set(E(i).handle,'visible','off')
    end
vert = [E(i).center1+E(i).Ar1+E(i).Br1 E(i).center1+E(i).Ar1-E(i).Br1 E(i).center1-E(i).Ar1-E(i).Br1 E(i).center1-E(i).Ar1+E(i).Br1];
% set(E.handle,'Xdata',vert(1,:),'Ydata',vert(2,:),'facecolor',E.color);
set(E(i).handle,'Xdata',vert(1,:),'Ydata',vert(2,:));




end

