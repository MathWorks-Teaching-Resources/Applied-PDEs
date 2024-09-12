function PlotSolutionWithRarefaction(tRange,xRange,IC,xFun,tStar,opts)
% This function computes the initial values of u over a given range of x
% values, tRange must always start with t0, and moves the values according
% to the characteristic curves.  The value tStar is the time at which
% the rarefaction starts. You must also pass xPlus and xMinus that
% bound the region.
arguments
    tRange (1,2) double
    xRange (1,2) double
    IC sym
    xFun sym
    tStar (1,1) double
    opts.xLimRange = xRange
    opts.xPlus sym
    opts.xMinus sym
end
figure
syms t x0 u0

% Set up xFun as a linearizable function
xFun(x0,t,u0) = xFun;

% Compute the initial range of values for both x and u
xBds = range(xRange);
xInit = linspace(xRange(1)-xBds,xRange(2)+xBds,300);
u0Vals = double(IC(xInit));

tVals = linspace(tRange(1),tRange(2),200);

% Set up a function that will identify the x-position of each characteristic curve
% through an initial value as a function of time t
xFun(t) = xFun(xInit,t,u0Vals);

% Draw the initial plot to determine a reasonable window to fix moving forward
p = plot(xInit,u0Vals,SeriesIndex=1);
xlabel("Position (x)")
ylabel("Wave Speed (u)")
[uMin,uMax] = bounds(u0Vals,"all");
yRange = uMax-uMin;
ylim([uMin-0.5*yRange uMax+0.5*yRange])
xlim(xRange)
p.Parent.Title.String = "A plot of $u(x,t)$";
p.Parent.Subtitle.String = "$t =$ " + tRange(1);
p.Parent.Title.Interpreter = "latex";
p.Parent.Subtitle.Interpreter = "latex";

xStar = double(subs(opts.xPlus,t,tStar));
xStarIdx = find(xInit>=xStar,1)-1;
hold on
r = plot(xInit(xStarIdx:xStarIdx+1),u0Vals(xStarIdx:xStarIdx+1),LineWidth=2,SeriesIndex=3);
hold off

for tIdx = 1:length(tVals)
    p.Parent.Subtitle.String = "$t =$ " + tVals(tIdx);

    xNormal = double(xFun(tVals(tIdx)));
    xTop = double(opts.xPlus(tVals(tIdx)));
    xBot = double(opts.xMinus(tVals(tIdx)));
    if tIdx == 1
        p.YData = [p.YData(1:xStarIdx) r.YData(1) nan r.YData(end) p.YData(xStarIdx+1:end)];
    end
    p.XData = [xNormal(1:xStarIdx) xBot nan xTop xNormal(xStarIdx+1:end)];

    if xTop~=xBot
        r.XData = linspace(xBot,xTop,2+ceil(10*(xTop-xBot)));
        r.YData = [r.YData(1) (r.XData(2:end)-r.XData(1))/(tVals(tIdx)-tStar)];
    end
    drawnow
end
end
