E(1).angle1 = 0;
E(1).angle2 = 0;
E(1).center1 = [200;0];
E(1).center2 = [];
E(1).mass=9999999996;
E(1).ground = 1;
E(1).broken = 0;
E(1).I=1000000000000;
E(1).A = [300;0];
E(1).Ar1 = [];
E(1).Ar2 = [];
E(1).B = [0;2];
E(1).Br1 = [];
E(1).Br2 = [];
E(1).lvelocity = [0;0];
E(1).lvelocity1 = [0;0];
E(1).alvelocity = [0;0];
E(1).lacc = [0;0];
E(1).avelocity = 0;
E(1).aavelocity = 0;
E(1).avelocity1 = 0;
E(1).color = [1 0 0];
E(1).handle = [];
E(1).style = 1;


E(2).angle1 = 0;
E(2).angle2 = 0;
E(2).center1 = [258;20];
E(2).center2 = [];
E(2).handle = [];
E(2).mass=10;
E(2).ground = 1;
E(2).broken = 0;
E(2).A = [4;0];
E(2).Ar1 = [];
E(2).B = [0;18];
E(2).Br1 = [];
E(2).Ar2 = [];
E(2).Br2 = [];
E(2).mass=20*max(E(2).A)*max(E(2).B);
E(2).I=5*E(2).mass*(E(2).A(1)^2 + E(2).B(2)^2)/12;
E(2).lvelocity = [0;0];
E(2).alvelocity = [0;0];
E(2).lvelocity1 = [0;0];
E(2).lacc = [0;a];
E(2).avelocity = 0;
E(2).aavelocity = 0;
E(2).avelocity1 = 0;
E(2).style = 6;
E(2).color = [1 1 1]/3;


E(3).angle1 = 0;
E(3).angle2 = 0;
E(3).center1 = [232;20];
E(3).center2 = [];
E(3).handle = [];
E(3).mass=15;
E(3).ground = 1;
E(3).broken = 0;
E(3).A = [4;0];
E(3).Ar1 = [];
E(3).B = [0;18];
E(3).Br1 = [];
E(3).Ar2 = [];
E(3).Br2 = [];
E(3).mass=20*max(E(3).A)*max(E(3).B);
E(3).I=E(3).mass*(E(3).A(1)^2 + E(3).B(2)^2)/12;
E(3).lvelocity = [0;0];
E(3).alvelocity = [0;0];
E(3).aavelocity = 0;
E(3).lvelocity1 = [0;0];
E(3).lacc = [0;a];
E(3).avelocity = 0;
E(3).avelocity1 = 0;
E(3).style = 6;
E(3).color = [1 1 1]/3;

E(4).angle1 = 0;
E(4).angle2 = 0;
E(4).center1 = [245;42.2];
E(4).center2 = [];
E(4).handle = [];
E(4).mass=10;
E(4).ground = 1;
E(4).broken = 0;
E(4).A = [18;0];
E(4).Ar1 = [];
E(4).Ar2 = [];
E(4).B = [0;4];
E(4).Br1 = [];
E(4).Br2 = [];
E(4).mass=max(E(4).A)*max(E(4).B);
E(4).I=E(4).mass*(E(4).A(1)^2 + E(4).B(2)^2)/12;
E(4).lvelocity = [0;0];
E(4).alvelocity = [0;0];
E(4).aavelocity = 0;
E(4).lvelocity1 = [0;0];
E(4).lacc = [0;a];
E(4).avelocity = 0;
E(4).avelocity1 = 0;
E(4).style = 4;
E(4).color = [0 1 1];

E(5).angle1 = 0;
E(5).angle2 = 0;
E(5).center1 = [238;55];
E(5).center2 = [];
E(5).handle = [];
E(5).ground = 1;
E(5).broken = 0;
E(5).A = [2;0];
E(5).Ar1 = [];
E(5).Ar2 = [];
E(5).B = [0;9];
E(5).Br1 = [];
E(5).Br2 = [];
E(5).mass=10*max(E(5).A)*max(E(5).B);
E(5).I=E(5).mass*(E(5).A(1)^2 + E(5).B(2)^2)/12;
E(5).lvelocity = [0;0];
E(5).alvelocity = [0;0];
E(5).aavelocity = 0;
E(5).lvelocity1 = [0;0];
E(5).lacc = [0;a];
E(5).avelocity = 0;
E(5).avelocity1 = 0;
E(5).style = 6;
E(5).color = [1 1 1]/3;

E(7).angle1 = 0;
E(7).angle2 = 0;
E(7).center1 = [252;55];
E(7).center2 = [];
E(7).handle = [];
E(7).ground = 1;
E(7).broken = 0;
E(7).A = [2;0];
E(7).Ar1 = [];
E(7).Ar2 = [];
E(7).B = [0;9];
E(7).Br1 = [];
E(7).Br2 = [];
E(7).mass=10*max(E(7).A)*max(E(7).B);
E(7).I=E(7).mass*(E(7).A(1)^2 + E(7).B(2)^2)/12;
E(7).lvelocity = [0;0];
E(7).alvelocity = [0;0];
E(7).aavelocity = 0;
E(7).lvelocity1 = [0;0];
E(7).lacc = [0;a];
E(7).avelocity = 0;
E(7).avelocity1 = 0;
E(7).style = 6;
E(7).color =  [1 1 1]/3;

E(8).angle1 = pi/2;
E(8).angle2 = 0;
E(8).center1 = [245;66];
E(8).center2 = [];
E(8).handle = [];
E(8).ground = 1;
E(8).broken = 0;
E(8).A = [2;0];
E(8).Ar1 = [];
E(8).Ar2 = [];
E(8).B = [0;9];
E(8).Br1 = [];
E(8).Br2 = [];
E(8).mass=max(E(8).A)*max(E(8).B);
E(8).I=E(8).mass*(E(8).A(1)^2 + E(8).B(2)^2)/12;
E(8).lvelocity = [0;0];
E(8).alvelocity = [0;0];
E(8).aavelocity = 0;
E(8).lvelocity1 = [0;0];
E(8).lacc = [0;a];
E(8).avelocity = 0;
E(8).avelocity1 = 0;
E(8).style = 4;
E(8).color =  [0 1 1];



E(9).angle1 = 0;
E(9).angle2 = 0;
E(9).center1 = [245;15];
E(9).center2 = [];
E(9).handle = [];
E(9).ground = 0;
E(9).broken = 0;
E(9).A = [5;0];
E(9).Ar1 = [];
E(9).Ar2 = [];
E(9).B = [0;5];
E(9).Br1 = [];
E(9).Br2 = [];
E(9).mass=max(E(9).A)*max(E(9).B);
E(9).I=E(9).mass*(E(9).A(1)^2 + E(9).B(2)^2)/12;
E(9).lvelocity = [0;0];
E(9).alvelocity = [0;0];
E(9).aavelocity = 0;
E(9).lvelocity1 = [0;0];
E(9).lacc = [0;a];
E(9).avelocity = 0;
E(9).avelocity1 = 0;
E(9).style = 5;
E(9).color =  [0 0 1];
E(9).imgdata = birdimgdata;
E(9).imgalphadata = birdalphadata;

E(12).angle1 = 0;
E(12).angle2 = 0;
E(12).center1 = [245;52];
E(12).center2 = [];
E(12).handle = [];
E(12).ground = 0;
E(12).broken = 0;
E(12).A = [4;0];
E(12).Ar1 = [];
E(12).Ar2 = [];
E(12).B = [0;4];
E(12).Br1 = [];
E(12).Br2 = [];
E(12).mass=max(E(12).A)*max(E(12).B);
E(12).I=E(12).mass*(E(12).A(1)^2 + E(12).B(2)^2)/12;
E(12).lvelocity = [0;0];
E(12).alvelocity = [0;0];
E(12).aavelocity = 0;
E(12).lvelocity1 = [0;0];
E(12).lacc = [0;a];
E(12).avelocity = 0;
E(12).avelocity1 = 0;
E(12).style = 5;
E(12).color =  [0 0 1];
E(12).imgdata = birdimgdata;
E(12).imgalphadata = birdalphadata;



E(6).angle1 = pi/4;
E(6).angle2 = 0;
E(6).center1 = [30;40];
E(6).center2 = [];
E(6).handle = [];
E(6).ground = 1;
E(6).broken = 0;
E(6).A = [4;0];
E(6).Ar1 = [];
E(6).Ar2 = [];
E(6).B = [0;4];
E(6).Br1 = [];
E(6).Br2 = [];
E(6).mass=1*max(E(6).A)*max(E(6).B);
E(6).I=E(6).mass*(E(6).A(1)^2 + E(6).B(2)^2)/12;
E(6).lvelocity = [0;0];
E(6).alvelocity = [0;0];
E(6).aavelocity = 0;
E(6).lvelocity1 = [0;0];
E(6).lacc = [0;6*a];
E(6).avelocity = 0;
E(6).avelocity1 = 0;
E(6).style = 3;
E(6).color =  [0 1 0];
E(6).imgdata = pigimgdata;
E(6).imgalphadata = pigalphadata;

E(10).angle1 = pi/4;
E(10).angle2 = 0;
E(10).center1 = [17;10];
E(10).center2 = [];
E(10).handle = [];
E(10).ground = 1;
E(10).broken = 0;
E(10).A = [4;0];
E(10).Ar1 = [];
E(10).Ar2 = [];
E(10).B = [0;4];
E(10).Br1 = [];
E(10).Br2 = [];
E(10).mass=1*max(E(10).A)*max(E(10).B);
E(10).I=E(10).mass*(E(10).A(1)^2 + E(10).B(2)^2)/12;
E(10).lvelocity = [0;0];
E(10).alvelocity = [0;0];
E(10).aavelocity = 0;
E(10).lvelocity1 = [0;0];
E(10).lacc = [0;6*a];
E(10).avelocity = 0;
E(10).avelocity1 = 0;
E(10).style = 31;
E(10).color =  [0 1 0];
E(10).imgdata = pigimgdata;
E(10).imgalphadata = pigalphadata;

E(11).angle1 = pi/4;
E(11).angle2 = 0;
E(11).center1 = [5;10];
E(11).center2 = [];
E(11).handle = [];
E(11).ground = 1;
E(11).broken = 0;
E(11).A = [4;0];
E(11).Ar1 = [];
E(11).Ar2 = [];
E(11).B = [0;4];
E(11).Br1 = [];
E(11).Br2 = [];
E(11).mass=1*max(E(11).A)*max(E(11).B);
E(11).I=E(11).mass*(E(11).A(1)^2 + E(11).B(2)^2)/12;
E(11).lvelocity = [0;0];
E(11).alvelocity = [0;0];
E(11).aavelocity = 0;
E(11).lvelocity1 = [0;0];
E(11).lacc = [0;6*a];
E(11).avelocity = 0;
E(11).avelocity1 = 0;
E(11).style = 31;
E(11).color =  [0 1 0];
E(11).imgdata = pigimgdata;
E(11).imgalphadata = pigalphadata;



