function [E,score] = resolvecollision( collide, E )
objcol = sum(collide,3);
e=0;
mew = .1;
len = size(collide);
doubleflag = zeros(len(1),len(1));
thrfric =1;
thravelg = .05;
thrlvelg = .05;
thravelu = 2;
thrlvelu = .1;
score = 0;
for i=1:len(1)
    for j = i+1:len(1)
        if (objcol(i,j)>0)||(objcol(j,i)>0)

            if E(i).ground ==1
                E(i).lvelocity1 = 0;
                E(i).avelocity1 = 0;
            end
            if E(j).ground ==1
                E(j).lvelocity1 = 0;
                E(j).avelocity1 = 0;
            end
            if E(i).style == 1
                E(i).lvelocity1 = 0;
                E(i).avelocity1 = 0;
                E(i).aavelocity = 0;
                E(i).alvelocity = 0;
            end
            if E(j).style == 1
                E(j).lvelocity1 = 0;
                E(j).avelocity1 = 0;
                E(j).aavelocity = 0;
                E(j).alvelocity = 0;
            end
            if objcol(i,j)==1 && objcol(j,i)==0%if the collision is a point>edge collision
                %% init
                indices = collide(i,j,:)==1;%locate the number of point of collision
                pointt = {E(j).center2+E(j).Ar2+E(j).Br2 E(j).center2-E(j).Ar2+E(j).Br2 ...
                    E(j).center2-E(j).Ar2-E(j).Br2 E(j).center2+E(j).Ar2-E(j).Br2};%a vector with all the point of a rectangle
                
                point1 = pointt{indices};%the cordinates of the point
                
                %the line equasions in a cell array
                linet = {};
                linet{1} = [E(i).center2+E(i).Ar2+E(i).Br2 E(i).center2-E(i).Ar2+E(i).Br2];
                linet{2} = [E(i).center2-E(i).Ar2+E(i).Br2 E(i).center2-E(i).Ar2-E(i).Br2];
                linet{3} = [E(i).center2-E(i).Ar2-E(i).Br2 E(i).center2+E(i).Ar2-E(i).Br2];
                linet{4} = [E(i).center2+E(i).Ar2-E(i).Br2 E(i).center2+E(i).Ar2+E(i).Br2];
                
                %the distance from the point to all the lines
                d = [max(abs(det([linet{1}(:,2)-linet{1}(:,1),point1-linet{1}(:,1)]))/abs(linet{1}(:,2)-linet{1}(:,1)))...
                    max(abs(det([linet{2}(:,2)-linet{2}(:,1),point1-linet{2}(:,1)]))/abs(linet{2}(:,2)-linet{2}(:,1)))...
                    max(abs(det([linet{3}(:,2)-linet{3}(:,1),point1-linet{3}(:,1)]))/abs(linet{3}(:,2)-linet{3}(:,1)))...
                    max(abs(det([linet{4}(:,2)-linet{4}(:,1),point1-linet{4}(:,1)]))/abs(linet{4}(:,2)-linet{4}(:,1)))];
                
                leastd = min(d);%the shortest distance between the point and one line
                l = find(d == leastd);%locate the line with which this short distance exists
                lineclosest= l(1);
                
                %create a line vector equasions to calculate normal
                linesegm = (linet{lineclosest}(:,1)-linet{lineclosest}(:,2));
                normal = [-linesegm(2);linesegm(1)]/norm(linesegm);
                
                
                r1 = point1-E(j).center2;
                r2 = point1-E(i).center2;
                r1p = [r1(2);-r1(1)];
                r2p = [r2(2);-r2(1)];
                v1 = E(j).lvelocity1-r1p*E(j).avelocity1;
                v2 = E(i).lvelocity1-r2p*E(i).avelocity1;
                vrel = v1-v2;
                %% collision
                if dot(vrel,normal) <0
                    impu = (dot(-(1+e)*(v1-v2),normal))/(dot(normal,(normal*((1/E(i).mass)+(1/E(j).mass)))) + (dot(r1p,normal)^2)/E(j).I + (dot(r2p,normal)^2)/E(i).I);
                    E(j).alvelocity=E(j).alvelocity+(impu/E(j).mass)*normal;
                    E(i).alvelocity=E(i).alvelocity-(impu/E(i).mass)*normal;
                    E(j).aavelocity=E(j).aavelocity-(dot(r1p,(impu*normal))/E(j).I);
                    E(i).aavelocity=E(i).aavelocity+(dot(r2p,(impu*normal))/E(i).I);
                    fric = [-normal(2);normal(1)];
                    vlrel = E(j).lvelocity1+E(j).alvelocity-E(i).lvelocity1-E(i).alvelocity;
                    E(j).alvelocity = E(j).alvelocity- dot(vlrel,fric)*fric*mew;
                    E(i).alvelocity = E(i).alvelocity+ dot(vlrel,fric)*fric*mew;
                    if norm(vlrel) <thrfric
                        E(j).alvelocity = normal*dot(E(j).alvelocity,normal);
                        E(i).alvelocity = normal*dot(E(i).alvelocity,normal);
                    end
                    if E(i).ground == 1
                        if norm(E(j).lvelocity1+E(j).alvelocity) <thrlvelg&& abs(E(j).avelocity1+E(j).aavelocity) <thravelg
                            E(j).ground =1;
%                             set(E(j).handle, 'facecolor','b')
                        elseif norm(E(i).alvelocity)>thrlvelu||abs(E(i).aavelocity)>thravelu
                            E(i).ground =0;
%                             set(E(i).handle, 'facecolor','y')
                        end
                    end
                    if E(j).ground ==1
                        if norm(E(i).lvelocity1+E(i).alvelocity) <thrlvelg&& abs(E(i).avelocity1+E(i).aavelocity) <thravelg
                            E(i).ground =1;
%                             set(E(i).handle, 'facecolor','b')
                        elseif norm(E(j).alvelocity)>thrlvelu||abs(E(j).aavelocity)>thravelu
                            E(j).ground =0;
%                             set(E(j).handle, 'facecolor','y')
                        end
                    end
                    
                end
                E(j).center2 = E(j).center2 +(leastd*normal);
                
            end
            if objcol(j,i)==1 && objcol(i,j)==0%if the collision is a point>edge collision
                %% init
                indices = collide(j,i,:)==1;%locate the number of point of collision
                pointt = {E(i).center2+E(i).Ar2+E(i).Br2 E(i).center2-E(i).Ar2+E(i).Br2 ...
                    E(i).center2-E(i).Ar2-E(i).Br2 E(i).center2+E(i).Ar2-E(i).Br2};%a vector with all the point of a rectangle
                
                point1 = pointt{indices};%the cordinates of the point
                
                %the line equasions in a cell array
                linet = {};
                linet{1} = [E(j).center2+E(j).Ar2+E(j).Br2 E(j).center2-E(j).Ar2+E(j).Br2];
                linet{2} = [E(j).center2-E(j).Ar2+E(j).Br2 E(j).center2-E(j).Ar2-E(j).Br2];
                linet{3} = [E(j).center2-E(j).Ar2-E(j).Br2 E(j).center2+E(j).Ar2-E(j).Br2];
                linet{4} = [E(j).center2+E(j).Ar2-E(j).Br2 E(j).center2+E(j).Ar2+E(j).Br2];
                
                %the distance from the point to all the lines
                d = [max(abs(det([linet{1}(:,2)-linet{1}(:,1),point1-linet{1}(:,1)]))/abs(linet{1}(:,2)-linet{1}(:,1)))...
                    max(abs(det([linet{2}(:,2)-linet{2}(:,1),point1-linet{2}(:,1)]))/abs(linet{2}(:,2)-linet{2}(:,1)))...
                    max(abs(det([linet{3}(:,2)-linet{3}(:,1),point1-linet{3}(:,1)]))/abs(linet{3}(:,2)-linet{3}(:,1)))...
                    max(abs(det([linet{4}(:,2)-linet{4}(:,1),point1-linet{4}(:,1)]))/abs(linet{4}(:,2)-linet{4}(:,1)))];
                
                leastd = min(d);%the shortest distance between the point and one line
                l = find(d == leastd);%locate the line with which this short distance exists
                lineclosest= l(1);
                
                %create a line vector equasions to calculate normal
                linesegm = (linet{lineclosest}(:,1)-linet{lineclosest}(:,2));
                normal = [-linesegm(2);linesegm(1)]/norm(linesegm);
                
                
                r1 = point1-E(i).center2;
                r2 = point1-E(j).center2;
                r1p = [r1(2);-r1(1)];
                r2p = [r2(2);-r2(1)];
                v1 = E(i).lvelocity1-r1p*E(i).avelocity1;
                v2 = E(j).lvelocity1-r2p*E(j).avelocity1;
                vrel = v1-v2;
                %% collision
                if dot(vrel,normal) <0
                    impu = (dot(-(1+e)*(v1-v2),normal))/(dot(normal,(normal*((1/E(i).mass)+(1/E(j).mass)))) + (dot(r1p,normal)^2)/E(j).I + (dot(r2p,normal)^2)/E(i).I);
                    E(i).alvelocity=E(i).alvelocity+(impu/E(i).mass)*normal;
                    E(j).alvelocity=E(j).alvelocity-(impu/E(j).mass)*normal;
                    E(i).aavelocity=E(i).aavelocity-(dot(r1p,(impu*normal))/E(i).I);
                    E(j).aavelocity=E(j).aavelocity+(dot(r2p,(impu*normal))/E(j).I);
                    fric = [-normal(2);normal(1)];
                    vlrel = E(j).lvelocity1+E(j).alvelocity-E(i).lvelocity1-E(i).alvelocity;
                    E(j).alvelocity = E(j).alvelocity- dot(vlrel,fric)*fric*mew;
                    E(i).alvelocity = E(i).alvelocity+ dot(vlrel,fric)*fric*mew;
                    if norm(vlrel) <thrfric
                        E(j).alvelocity = normal*dot(E(j).alvelocity,normal);
                        E(i).alvelocity = normal*dot(E(i).alvelocity,normal);
                    end
                    if E(i).ground == 1
                        if norm(E(j).lvelocity1+E(j).alvelocity) <thrlvelg&& abs(E(j).avelocity1+E(j).aavelocity) <thravelg
                            E(j).ground =1;
%                             set(E(j).handle, 'facecolor','b')
                        elseif norm(E(i).alvelocity)>thrlvelu||abs(E(i).aavelocity)>thravelu
                            E(i).ground =0;
%                             set(E(i).handle, 'facecolor','y')
                        end
                    end
                    if E(j).ground ==1
                        if norm(E(i).lvelocity1+E(i).alvelocity) <thrlvelg&& abs(E(i).avelocity1+E(i).aavelocity) <thravelg
                            E(i).ground =1;
%                             set(E(i).handle, 'facecolor','b')
                        elseif norm(E(j).alvelocity)>thrlvelu||abs(E(j).aavelocity)>thravelu
                            E(j).ground =0;
%                             set(E(j).handle, 'facecolor','y')
                        end
                    end
                    E(j).center2 = E(j).center2 -(leastd*normal);
                end
            end
            if objcol(i,j)==2 && objcol(j,i)~=2 && doubleflag(i,j)==0
                %% init
                doubleflag(i,j)=1;%flag to prevent double collision response
                indices = find(collide(i,j,:)==1);
                pointt = {E(j).center2+E(j).Ar2+E(j).Br2 E(j).center2-E(j).Ar2+E(j).Br2 E(j).center2-E(j).Ar2-E(j).Br2 E(j).center2+E(j).Ar2-E(j).Br2};
                point1 = pointt{indices(1)};
                point2 = pointt{indices(2)};
                pointc = ((point1+point2)/2);
                linet = {};
                linet{1} = [E(i).center2+E(i).Ar2+E(i).Br2 E(i).center2-E(i).Ar2+E(i).Br2];
                linet{2} = [E(i).center2-E(i).Ar2+E(i).Br2 E(i).center2-E(i).Ar2-E(i).Br2];
                linet{3} = [E(i).center2-E(i).Ar2-E(i).Br2 E(i).center2+E(i).Ar2-E(i).Br2];
                linet{4} = [E(i).center2+E(i).Ar2-E(i).Br2 E(i).center2+E(i).Ar2+E(i).Br2];
                d =[max(abs(det([linet{1}(:,2)-linet{1}(:,1),pointc-linet{1}(:,1)]))/abs(linet{1}(:,2)-linet{1}(:,1)))...
                    max(abs(det([linet{2}(:,2)-linet{2}(:,1),pointc-linet{2}(:,1)]))/abs(linet{2}(:,2)-linet{2}(:,1)))...
                    max(abs(det([linet{3}(:,2)-linet{3}(:,1),pointc-linet{3}(:,1)]))/abs(linet{3}(:,2)-linet{3}(:,1)))...
                    max(abs(det([linet{4}(:,2)-linet{4}(:,1),pointc-linet{4}(:,1)]))/abs(linet{4}(:,2)-linet{4}(:,1)))];
                
                leastd = min(d);
                l1 = find(d == leastd);
                lineclosest= l1(1);
                linesegm = (linet{lineclosest}(:,1)-linet{lineclosest}(:,2));
                normal = [-linesegm(2);linesegm(1)]/norm(linesegm);
                
                r1 = pointc-E(j).center2;
                r2 = pointc-E(i).center2;
                r1p = [r1(2);-r1(1)];
                r2p = [r2(2);-r2(1)];
                v1 = E(j).lvelocity1-r1p*E(j).avelocity1;
                v2 = E(i).lvelocity1-r2p*E(i).avelocity1;
                vrel = v1-v2;
                %% collision
                if dot(vrel,normal) <=0
                    impu = (dot(-(1+e)*(v1-v2),normal))/(dot(normal,(normal*((1/E(i).mass)+(1/E(j).mass)))) + (dot(r1p,normal)^2)/E(j).I + (dot(r2p,normal)^2)/E(i).I);
                    E(j).alvelocity=E(j).alvelocity+(impu/E(j).mass)*normal;
                    E(i).alvelocity=E(i).alvelocity-(impu/E(i).mass)*normal;
                    E(j).aavelocity=E(j).aavelocity-(dot(r1p,(impu*normal))/E(j).I);
                    E(i).aavelocity=E(i).aavelocity+(dot(r2p,(impu*normal))/E(i).I);
                    fric = [-normal(2);normal(1)];
                    vlrel = E(j).lvelocity1+E(j).alvelocity-E(i).lvelocity1-E(i).alvelocity;
                    E(j).alvelocity = E(j).alvelocity- dot(vlrel,fric)*fric*mew;
                    E(i).alvelocity = E(i).alvelocity+ dot(vlrel,fric)*fric*mew;
                    if norm(vlrel) <thrfric
                        E(j).alvelocity = normal*dot(E(j).alvelocity,normal);
                        E(i).alvelocity = normal*dot(E(i).alvelocity,normal);
                    end
                    if E(i).ground == 1
                        if norm(E(j).lvelocity1+E(j).alvelocity) <thrlvelg&& abs(E(j).avelocity1+E(j).aavelocity) <thravelg
                            E(j).ground =1;
%                             set(E(j).handle, 'facecolor','b')
                        elseif norm(E(i).alvelocity)>thrlvelu||abs(E(i).aavelocity)>thravelu
                            E(i).ground =0;
%                             set(E(i).handle, 'facecolor','y')
                        end
                    end
                    if E(j).ground ==1
                        if norm(E(i).lvelocity1+E(i).alvelocity) <thrlvelg&& abs(E(i).avelocity1+E(i).aavelocity) <thravelg
                            E(i).ground =1;
%                             set(E(i).handle, 'facecolor','b')
                        elseif norm(E(j).alvelocity)>thrlvelu||abs(E(j).aavelocity)>thravelu
                            E(j).ground =0;
%                             set(E(j).handle, 'facecolor','y')
                        end
                    end
                end
                E(j).center2 = E(j).center2 +(leastd*normal);
            end
            if objcol(j,i)==2 && objcol(i,j)~=2 && doubleflag(j,i)==0
                %% init
                doubleflag(j,i)=1;%flag to prevent double collision response
                indices = find(collide(j,i,:)==1);
                pointt = {E(i).center2+E(i).Ar2+E(i).Br2 E(i).center2-E(i).Ar2+E(i).Br2 E(i).center2-E(i).Ar2-E(i).Br2 E(i).center2+E(i).Ar2-E(i).Br2};
                point1 = pointt{indices(1)};
                point2 = pointt{indices(2)};
                pointc = ((point1+point2)/2);
                linet = {};
                linet{1} = [E(j).center2+E(j).Ar2+E(j).Br2 E(j).center2-E(j).Ar2+E(j).Br2];
                linet{2} = [E(j).center2-E(j).Ar2+E(j).Br2 E(j).center2-E(j).Ar2-E(j).Br2];
                linet{3} = [E(j).center2-E(j).Ar2-E(j).Br2 E(j).center2+E(j).Ar2-E(j).Br2];
                linet{4} = [E(j).center2+E(j).Ar2-E(j).Br2 E(j).center2+E(j).Ar2+E(j).Br2];
                d =[max(abs(det([linet{1}(:,2)-linet{1}(:,1),pointc-linet{1}(:,1)]))/abs(linet{1}(:,2)-linet{1}(:,1)))...
                    max(abs(det([linet{2}(:,2)-linet{2}(:,1),pointc-linet{2}(:,1)]))/abs(linet{2}(:,2)-linet{2}(:,1)))...
                    max(abs(det([linet{3}(:,2)-linet{3}(:,1),pointc-linet{3}(:,1)]))/abs(linet{3}(:,2)-linet{3}(:,1)))...
                    max(abs(det([linet{4}(:,2)-linet{4}(:,1),pointc-linet{4}(:,1)]))/abs(linet{4}(:,2)-linet{4}(:,1)))];
                
                leastd = min(d);
                l1 = find(d == leastd);
                lineclosest= l1(1);
                linesegm = (linet{lineclosest}(:,1)-linet{lineclosest}(:,2));
                normal = [-linesegm(2);linesegm(1)]/norm(linesegm);
                
                r1 = pointc-E(i).center2;
                r2 = pointc-E(j).center2;
                r1p = [r1(2);-r1(1)];
                r2p = [r2(2);-r2(1)];
                v1 = E(i).lvelocity1-r1p*E(i).avelocity1;
                v2 = E(j).lvelocity1-r2p*E(j).avelocity1;
                vrel = v1-v2;
                %% collide
                if dot(vrel,normal) <=0
                    impu = (dot(-(1+e)*(v1-v2),normal))/(dot(normal,(normal*((1/E(i).mass)+(1/E(j).mass)))) + (dot(r1p,normal)^2)/E(j).I + (dot(r2p,normal)^2)/E(i).I);
                    E(j).alvelocity=E(j).alvelocity-(impu/E(j).mass)*normal;
                    E(i).alvelocity=E(i).alvelocity+(impu/E(i).mass)*normal;
                    E(j).aavelocity=E(j).aavelocity+(dot(r1p,(impu*normal))/E(j).I);
                    E(i).aavelocity=E(i).aavelocity-(dot(r2p,(impu*normal))/E(i).I);
                    fric = [-normal(2);normal(1)];
                    vlrel = E(j).lvelocity1+E(j).alvelocity-E(i).lvelocity1-E(i).alvelocity;
                    E(j).alvelocity = E(j).alvelocity- dot(vlrel,fric)*fric*mew;
                    E(i).alvelocity = E(i).alvelocity+ dot(vlrel,fric)*fric*mew;
                    if norm(vlrel) <thrfric
                        E(j).alvelocity = normal*dot(E(j).alvelocity,normal);
                        E(i).alvelocity = normal*dot(E(i).alvelocity,normal);
                    end
                    if E(i).ground == 1
                        if norm(E(j).lvelocity1+E(j).alvelocity) <thrlvelg&& abs(E(j).avelocity1+E(j).aavelocity) <thravelg
                            E(j).ground =1;
%                             set(E(j).handle, 'facecolor','b')
                        elseif norm(E(i).alvelocity)>thrlvelu||abs(E(i).aavelocity)>thravelu
                            E(i).ground =0;
%                             set(E(i).handle, 'facecolor','y')
                        end
                    end
                    if E(j).ground ==1
                        if norm(E(i).lvelocity1+E(i).alvelocity) <thrlvelg&& abs(E(i).avelocity1+E(i).aavelocity) <thravelg
                            E(i).ground =1;
%                             set(E(i).handle, 'facecolor','b')
                        elseif norm(E(j).alvelocity)>thrlvelu||abs(E(j).aavelocity)>thravelu
                            E(j).ground =0;
%                             set(E(j).handle, 'facecolor','y')
                        end
                    end
                end
                E(j).center2 = E(j).center2 -(leastd*normal);
            end
            if objcol(i,j)==2 && objcol(j,i)==2 && doubleflag(i,j)==0 && doubleflag(j,i)==0
                %% init
                doubleflag(i,j)=1;%flag to prevent double collision response
                doubleflag(j,i)=1;%flag to prevent double collision response
                indices = find(collide(i,j,:)==1);
                pointt = {E(j).center2+E(j).Ar2+E(j).Br2 E(j).center2-E(j).Ar2+E(j).Br2 E(j).center2-E(j).Ar2-E(j).Br2 E(j).center2+E(j).Ar2-E(j).Br2};
                point1 = pointt{indices(1)};
                point2 = pointt{indices(2)};
                pointc = ((point1+point2)/2);
                linet = {};
                linet{1} = [E(i).center2+E(i).Ar2+E(i).Br2 E(i).center2-E(i).Ar2+E(i).Br2];
                linet{2} = [E(i).center2-E(i).Ar2+E(i).Br2 E(i).center2-E(i).Ar2-E(i).Br2];
                linet{3} = [E(i).center2-E(i).Ar2-E(i).Br2 E(i).center2+E(i).Ar2-E(i).Br2];
                linet{4} = [E(i).center2+E(i).Ar2-E(i).Br2 E(i).center2+E(i).Ar2+E(i).Br2];
                d =[max(abs(det([linet{1}(:,2)-linet{1}(:,1),pointc-linet{1}(:,1)]))/abs(linet{1}(:,2)-linet{1}(:,1)))...
                    max(abs(det([linet{2}(:,2)-linet{2}(:,1),pointc-linet{2}(:,1)]))/abs(linet{2}(:,2)-linet{2}(:,1)))...
                    max(abs(det([linet{3}(:,2)-linet{3}(:,1),pointc-linet{3}(:,1)]))/abs(linet{3}(:,2)-linet{3}(:,1)))...
                    max(abs(det([linet{4}(:,2)-linet{4}(:,1),pointc-linet{4}(:,1)]))/abs(linet{4}(:,2)-linet{4}(:,1)))];
                
                leastd = min(d);
                l1 = find(d == leastd);
                lineclosest= l1(1);
                linesegm = (linet{lineclosest}(:,1)-linet{lineclosest}(:,2));
                normal = [-linesegm(2);linesegm(1)]/norm(linesegm);
                
                r1 = pointc-E(j).center2;
                r2 = pointc-E(i).center2;
                r1p = [r1(2);-r1(1)];
                r2p = [r2(2);-r2(1)];
                v1 = E(j).lvelocity1-r1p*E(j).avelocity1;
                v2 = E(i).lvelocity1-r2p*E(i).avelocity1;
                vrel = v1-v2;
                %% collide
                if dot(vrel,normal) <0
                    impu = (dot(-(1+e)*(v1-v2),normal))/(dot(normal,(normal*((1/E(i).mass)+(1/E(j).mass)))) + (dot(r1p,normal)^2)/E(j).I + (dot(r2p,normal)^2)/E(i).I);
                    E(j).alvelocity=E(j).alvelocity+(impu/E(j).mass)*normal;
                    E(i).alvelocity=E(i).alvelocity-(impu/E(i).mass)*normal;
                    E(j).aavelocity=E(j).aavelocity-(dot(r1p,(impu*normal))/E(j).I);
                    E(i).aavelocity=E(i).aavelocity+(dot(r2p,(impu*normal))/E(i).I);
                    fric = [-normal(2);normal(1)];
                    vlrel = E(j).lvelocity1+E(j).alvelocity-E(i).lvelocity1-E(i).alvelocity;
                    E(j).alvelocity = E(j).alvelocity- dot(vlrel,fric)*fric*mew;
                    E(i).alvelocity = E(i).alvelocity+ dot(vlrel,fric)*fric*mew;
                    if norm(vlrel) <thrfric
                        E(j).alvelocity = normal*dot(E(j).alvelocity,normal);
                        E(i).alvelocity = normal*dot(E(i).alvelocity,normal);
                    end
                    if E(i).ground == 1
                        if norm(E(j).lvelocity1+E(j).alvelocity) <thrlvelg&& abs(E(j).avelocity1+E(j).aavelocity) <thravelg
                            E(j).ground =1;
%                             set(E(j).handle, 'facecolor','b')
                        elseif norm(E(i).alvelocity)>thrlvelu||abs(E(i).aavelocity)>thravelu
                            E(i).ground =0;
%                             set(E(i).handle, 'facecolor','y')
                        end
                    end
                    if E(j).ground ==1
                        if norm(E(i).lvelocity1+E(i).alvelocity) <thrlvelg&& abs(E(i).avelocity1+E(i).aavelocity) <thravelg
                            E(i).ground =1;
%                             set(E(i).handle, 'facecolor','b')
                        elseif norm(E(j).alvelocity)>thrlvelu||abs(E(j).aavelocity)>thravelu
                            E(j).ground =0;
%                             set(E(j).handle, 'facecolor','y')
                        end
                    end
                    
                end
                E(j).center2 = E(j).center2 +(leastd*normal);
            end
            if objcol(i,j)==1 && objcol(j,i)==1 && doubleflag(i,j)==0 && doubleflag(j,i)==0
                %% init
                doubleflag(i,j)=1;%flag to prevent double collision response
                doubleflag(j,i)=1;%flag to prevent double collision response
                indexj = find(collide(i,j,:)==1);
                indexi = find(collide(j,i,:)==1);
                pointj = {E(j).center2+E(j).Ar2+E(j).Br2 E(j).center2-E(j).Ar2+E(j).Br2 E(j).center2-E(j).Ar2-E(j).Br2 E(j).center2+E(j).Ar2-E(j).Br2};
                pointi = {E(i).center2+E(i).Ar2+E(i).Br2 E(i).center2-E(i).Ar2+E(i).Br2 E(i).center2-E(i).Ar2-E(i).Br2 E(i).center2+E(i).Ar2-E(i).Br2};
                
                pointjj = pointj{indexj(1)};
                pointii = pointi{indexi(1)};
                %                 plot([E(j).center2(1) pointc(1)],[E(j).center2(2) pointc(2)])
                linei = [];
                linei(1,:) = [E(i).center2'+E(i).Ar2'+E(i).Br2' E(i).center2'-E(i).Ar2'+E(i).Br2'];
                linei(2,:) = [E(i).center2'-E(i).Ar2'+E(i).Br2' E(i).center2'-E(i).Ar2'-E(i).Br2'];
                linei(3,:) = [E(i).center2'-E(i).Ar2'-E(i).Br2' E(i).center2'+E(i).Ar2'-E(i).Br2'];
                linei(4,:) = [E(i).center2'+E(i).Ar2'-E(i).Br2' E(i).center2'+E(i).Ar2'+E(i).Br2'];
                linej = [];
                linej(1,:) = [E(j).center2'+E(j).Ar2'+E(j).Br2' E(j).center2'-E(j).Ar2'+E(j).Br2'];
                linej(2,:) = [E(j).center2'-E(j).Ar2'+E(j).Br2' E(j).center2'-E(j).Ar2'-E(j).Br2'];
                linej(3,:) = [E(j).center2'-E(j).Ar2'-E(j).Br2' E(j).center2'+E(j).Ar2'-E(j).Br2'];
                linej(4,:) = [E(j).center2'+E(j).Ar2'-E(j).Br2' E(j).center2'+E(j).Ar2'+E(j).Br2'];
                
                intsectpjli = lineSegmentIntersect([E(j).center2' pointjj'],linei);
                intsectpilj = lineSegmentIntersect([E(i).center2' pointii'],linej);
                
                linenumpjli = find(intsectpjli.intAdjacencyMatrix(1,:)==1);
                linenumpilj = find(intsectpilj.intAdjacencyMatrix(1,:)==1);
                dpjli = 0;
                dpilj = 0;
                if ~isempty(linenumpjli)
                    dpjli = max(abs(det([linei(linenumpjli(1),3:4)'-linei(linenumpjli(1),1:2)',pointjj-linei(linenumpjli(1),1:2)']))/abs(linei(linenumpjli(1),3:4)'-linei(linenumpjli(1),1:2)'));
                end
                if ~isempty(linenumpilj)
                    dpilj = max(abs(det([linej(linenumpilj(1),3:4)'-linej(linenumpilj(1),1:2)',pointii-linej(linenumpilj(1),1:2)']))/abs(linej(linenumpilj(1),3:4)'-linej(linenumpilj(1),1:2)'));
                end
                if dpilj>dpjli && numel(linenumpilj) ~=0
                    d = dpilj;
                    pointc = pointii;
                    linesegm = (linej(linenumpilj(1),1:2)-linej(linenumpilj(1),3:4));
                    normal = [linesegm(2);-linesegm(1)]/norm(linesegm);
                    
                elseif numel(linenumpjli) ~=0
                    d = dpjli;
                    pointc = pointjj;
                    linesegm = (linei(linenumpjli(1),1:2)-linei(linenumpjli(1),3:4));
                    normal = [-linesegm(2);linesegm(1)]/norm(linesegm);
                else
                    continue
                end
                r1 = pointc-E(j).center2;
                r2 = pointc-E(i).center2;
                r1p = [r1(2);-r1(1)];
                r2p = [r2(2);-r2(1)];
                v1 = E(j).lvelocity1-r1p*E(j).avelocity1;
                v2 = E(i).lvelocity1-r2p*E(i).avelocity1;
                %% collide
                impu = (dot(-(1+e)*(v1-v2),normal))/(dot(normal,(normal*((1/E(i).mass)+(1/E(j).mass)))) + (dot(r1p,normal)^2)/E(j).I + (dot(r2p,normal)^2)/E(i).I);
                E(j).alvelocity=E(j).alvelocity+(impu/E(j).mass)*normal;
                E(i).alvelocity=E(i).alvelocity-(impu/E(i).mass)*normal;
                E(j).aavelocity=E(j).aavelocity-(dot(r1p,(impu*normal))/E(j).I);
                E(i).aavelocity=E(i).aavelocity+(dot(r2p,(impu*normal))/E(i).I);
                fric = [-normal(2);normal(1)];
                vlrel = E(j).lvelocity1+E(j).alvelocity-E(i).lvelocity1-E(i).alvelocity;
                E(j).alvelocity = E(j).alvelocity- dot(vlrel,fric)*fric*mew;
                E(i).alvelocity = E(i).alvelocity+ dot(vlrel,fric)*fric*mew;
                if norm(vlrel) <thrfric
                    E(j).alvelocity = normal*dot(E(j).alvelocity,normal);
                    E(i).alvelocity = normal*dot(E(i).alvelocity,normal);
                end
                if E(i).ground == 1
                    if norm(E(j).lvelocity1+E(j).alvelocity) <thrlvelg&& abs(E(j).avelocity1+E(j).aavelocity) <thravelg
                        E(j).ground =1;
%                         set(E(j).handle, 'facecolor','b')
                    elseif norm(E(i).alvelocity)>thrlvelu||abs(E(i).aavelocity)>thravelu
                        E(i).ground =0;
%                         set(E(i).handle, 'facecolor','y')
                    end
                end
                if E(j).ground ==1
                    if norm(E(i).lvelocity1+E(i).alvelocity) <thrlvelg&& abs(E(i).avelocity1+E(i).aavelocity) <thravelg
                        E(i).ground =1;
%                         set(E(i).handle, 'facecolor','b')
                    elseif norm(E(j).alvelocity)>thrlvelu||abs(E(j).aavelocity)>thravelu
                        E(j).ground =0;
%                         set(E(j).handle, 'facecolor','y')
                    end
                end
                E(j).center2 = E(j).center2 +(d*normal);
            end
        end
    end
end
end
