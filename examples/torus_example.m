%% Numerical solution


[~,y] = ode45(@(t,y) TorusGeodesicD(t,y,3),[0 10],[0,pi,1,0]');
%N = 100;
%testcurve = [(pi/2)*ones(N,1), linspace(pi,2*pi,N)'];
PlotOnTorus(y(:,[1 2]),3)
title("Initially $\theta'(0) = 1$, and  $\phi'(0) = 0$")
exportgraphics(gcf, "torus10.pdf", 'ContentType','vector')

[~,y] = ode45(@(t,y) TorusGeodesicD(t,y,3),[0 10],[0,pi,0,1]');
%N = 100;
%testcurve = [(pi/2)*ones(N,1), linspace(pi,2*pi,N)'];
PlotOnTorus(y(:,[1 2]),3)
title("Initially $\theta'(0) = 0$, and  $\phi'(0) = 1$")
exportgraphics(gcf, "torus01.pdf", 'ContentType','vector')

[~,y] = ode45(@(t,y) TorusGeodesicD(t,y,3),[0 20],[pi/2,pi,2,1]');
%N = 100;
%testcurve = [(pi/2)*ones(N,1), linspace(pi,2*pi,N)'];
PlotOnTorus(y(:,[1 2]),3)
title("Initially $\theta'(0) = 2$, and  $\phi'(0) = 1$")
exportgraphics(gcf, "torus11.pdf", 'ContentType','vector')


