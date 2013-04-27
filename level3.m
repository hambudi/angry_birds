clear
close all
clc
% figure('position',[0 0 ])
hold on
axis([0 400 0 150])
% axis equa5l
grid on
hold on

[birdimgdata , ~, birdalphadata] = imread('bird.png');
[pigimgdata , ~, pigalphadata] = imread('Pigs.png');


imbk = imread('background.png');
background = imshow(imbk, 'xdata', [0 500], 'ydata', [150 0]); hold on
[imgr map alphagr] = imread('background.png');
hold on
% gr = imshow(imgr);
% set(gr,'XData',[0 150],'YData',[50 0],'alphadata',alphagr);
set(gca, 'visible', 'off', 'position', [0, 0, 1, 1], 'YDir','normal');

% set(gca,'YDir','normal');

dt = .01;

a = -15;
levelset3

% testlevel
mouseLoc = zeros(2,3);
pressed = 0;
justClicked = 0;
set(gcf, 'WindowButtonMotionFcn', 'mouseLoc = get(gca, ''CurrentPoint'');',...
    'WindowButtonDownFcn', 'pressed = 1; justClicked = 1;',...
    'WindowButtonUpFcn', 'pressed = 0;');

tic
flag = 0;
E = makeobject(E);
foreg = imread('foreground.png');

fill([45,55,60,70,68,57.5,47],[20,0,0,20,20,3,20],'r')
string1 = plot(0,0);
string2 = plot(0,0);
score = 0;
scoreagg = 0;
numturns = 1;
game = 1;
scorehandel = text(0,140,['Score ' num2str(score)],'fontname', 'calibre','fontsize',20 );
set(E(1).handle,'visible','off')
while game
    while pressed == 0 && flag ==0
        for i = 1:length(E)
            if numel(find([E.style]==3)) == 0&& flag ==0
                text(100,65,['YOU LOOSE!!!'],'fontname', 'calibre','fontsize',50 );
                text(100,35,['RESTARTING'],'fontname', 'calibre','fontsize',50 );

                    pause(2)
                    level3
            end
                
            if E(i).style == 3 && flag ==0
                
                if norm(([57.5;20]-mouseLoc(1,1:2)'))>30
                    E(i).center2 = [57.5;20];
                    E(i).center1 = [57.5;20];
                else
                    E(i).center2 = mouseLoc(1,1:2)';
                    E(i).center1 = mouseLoc(1,1:2)';
                end
                
                E = catchup(E);
                set(string1, 'xdata', [E(i).center2(1) 46],'ydata',[E(i).center2(2) 20])
                E = setobject(E);
                set(string2, 'xdata', [E(i).center2(1) 69],'ydata',[E(i).center2(2) 20])
                
                pause(dt)
                indi = find([E.style]==31);
                
                if  pressed == 1
                    flag =1;
                    E(i).lvelocity1 = 10*([52.5;20]-E(i).center1);
                    E(i).lvelocity = 10*([52.5;20]-E(i).center1);
                    E(i).ground =0;
                    
                    set(string1,'xdata',0,'ydata',0)
                    set(string2,'xdata',0,'ydata',0)
                    E(i).style = 32;
                    if numel(indi)>0
                        E(indi(1)).style = 3;
                    end
                    tic
                end
            end
        end
    end
    Ehight = [E.center2];
    [Ehight,order] = sort(Ehight(2,:));
    E = E(order);
    E = moveobject(E,dt);
    g = checkcollide(E);
    [E,score] = resolvecollision(g,E);
    scoreagg = scoreagg + score;
    disp(score)
    E = catchup(E);
    E = setobject(E);
    pause(dt)
    set(scorehandel, 'string', ['Score ' num2str(scoreagg)])
    if numel(find([E.style]==5)) == 0
        text(100,65,['YOU WIN!!!'],'fontname', 'calibre','fontsize',50 );
        text(100,35,['THE END'],'fontname', 'calibre','fontsize',50 );
                
        pause(2)
        break
    end
    disp(toc)
    if toc >10
        flag = 0;
    end
end