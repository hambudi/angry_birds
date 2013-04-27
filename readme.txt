Sumary: This is a matlab angrybirds clone with a lot of emphsis on the physics.The basic implimentation is for the physics engine and so a physics demo has been included so as to show the usefullness and the problems with the implimentation.

Usage: start the game using runme.m
	Options
you can chose to play the game or use the physics demo.
The game has 3 levels and clicking the mouse causes the bird to fly as in the angrybird demo. the game is won by killling the bird and lost by running out of pigs.
on the case of loosing the game the level restarts automatically.

Incase of the phyics demo, there is no win/loose condition and as such we only have it there to play around with

	Features
In the game there is a system of scoring which adds score per object broken and extra score for killing the bird.


programming:
Usual features:
there is many unusual features in the game. Most of them are implimentations of Chris Hecklers physics papers. Infact this game uses most of the features in that article. Furthermore in evey iteration of the loop the objects are sorted in order bottom to top, this allows us to resolve collision better but also makes a few rare gliches that are seen in the video runme.avi.

Structure:
breakobject.m and eradicate.m are fungtions that break an object

catchup, moveobject.m are both fungtions that impliment impulses, accerations, and other integration fungtions.

checkcollide checks all objects against all objects for any collision, this fungtion is one of the main innovative parts of the game.

Level2 level3 levelset1 levelset2 levelset3 start are all level m files and include while loops and block position data

linesegmentintersect is a fungtion mfile taken from the web that checks for linesegment intersections.

resolvecollision.m and collsionresolutionbreak. are the other innovative and perhaps most innovative part of the code,which applies impulses, friction, collision resolution, resting contacts, breaking contacts, breaking, and win/loose condition returns.

runme.m is the main runfile which also includes all the code for the physics demo as well.

