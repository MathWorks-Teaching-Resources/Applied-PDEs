function PlotSolutionWithShock(uSol,tVals,x0Vals,IC,xEqn,xShockVals,tShockVals,uPlus,uMinus,yStar,opts)
arguments
    uSol sym
    tVals (1,:) double
    x0Vals (1,:) double
    IC sym
    xEqn sym
    xShockVals (1,:) double = nan
    tShockVals (1,:) double = nan
    uPlus (1,:) double = nan
    uMinus (1,:) double = nan
    yStar (1,1) double = xShockVals(1)
    opts.HasShock logical = false
    opts.XBounds (1,2) double = [min(x0Vals,[],"all") max(x0Vals,[],"all")];
end
figure
xStar = xShockVals(1);
syms x x0 t0 u0 t 
u0Vals = double(subs(IC,x,x0Vals));
xFun(x0,u0,t) = subs(rhs(xEqn),t0,tVals(1));
[T,X0] = meshgrid(tVals,x0Vals);
[~,U0] = meshgrid(tVals,u0Vals);
xVals = double(xFun(X0,U0,T));
uMinLim = min(U0,[],"all")-0.1*range(U0,"all");
uMaxLim = uMinLim+1.2*range(U0,"all");

% While there is no shock at all
if ~opts.HasShock
    s = plot(xVals(:,1),U0(:,1),SeriesIndex=1,LineWidth=2);
    ylim([uMinLim uMaxLim])
    xlim(opts.XBounds)
    AddLabels(s)
    drawnow
    for k = 2:numel(X0(:,1))
        s.XData = xVals(:,k);
        drawnow
    end    
else
    tShockIdx = find(tVals>=tShockVals(1),1);
    idx = find(x0Vals==yStar);
    if isempty(idx)
        idx = find(x0Vals>yStar,1,"last");
    end
    % When there is a shock that starts later than t0
    % Plot the normal solutions up through the time of the shock
    % Finish by setting up the shock jump point
    if tShockIdx>1
        solMinus = plot(X0(1:idx,1),U0(1:idx,1),SeriesIndex=1,LineWidth=2);
        AddLabels(solMinus)
        ylim([uMinLim uMaxLim])
        xlim(opts.XBounds)
        hold on
        solPlus = plot(X0(idx:end,1),U0(idx:end,1),SeriesIndex=1,LineWidth=2);
        hold off
        drawnow
        for k = 2:tShockIdx-1
            solMinus.XData = xVals(1:idx,k);
            solPlus.XData = xVals(idx:end,k);
            drawnow
        end
        solMinus.XData = [xVals(1:idx,tShockIdx);xStar];
        solMinus.YData = [U0(1:idx,tShockIdx);uMinus(1)];
        solPlus.XData = [xStar; xVals(idx:end,tShockIdx)];
        solPlus.YData = [uPlus(1); U0(idx:end,tShockIdx)];
        hold on
        solShock = plot([xStar xStar],[uPlus(1) uMinus(1)],SeriesIndex=2,LineWidth=2);
        hold off
        subtitle("Shock!")
        drawnow
    else
        solMinus = plot([X0(1:idx-1,1);xShockVals(1)],[U0(1:idx-1,1);uMinus(1)],SeriesIndex=1,LineWidth=2);
        AddLabels(solMinus)
        ylim([uMinLim uMaxLim])
        xlim(opts.XBounds)
        subtitle("Shock!")
        hold on
        solShock = plot([xShockVals(1) xShockVals(1)],[uPlus(1) uMinus(1)],SeriesIndex=2,LineWidth=2);
        solPlus = plot([xShockVals(1);X0(idx+1:end,1)],[uPlus(1);U0(idx+1:end,1)],SeriesIndex=1,LineWidth=2);
        hold off
    end
end

if opts.HasShock
    for k = 2:numel(uPlus)
        tIdx = find(tVals<=tShockVals(k),1,"last");
        ChangeOfSign = find(diff(xVals(:,tIdx))<0,1,"first");
        xIdx = find(xVals(:,tIdx)>=xShockVals(k),1,"first")-1;
        if ~isempty(ChangeOfSign)
            xIdx = min(xIdx,ChangeOfSign);
        end
        xpIdx = find(xVals(:,tIdx)<=xShockVals(k),1,"last")+1;
        uFun(x,u0) = subs(uSol,t,tVals(tIdx));
        uVals = uFun(xVals(:,tIdx)-1e-6,U0(:,tIdx));
        solPlus.XData = [xShockVals(k);xVals(xpIdx:end,tIdx)];
        solPlus.YData = [uPlus(k);uVals(xpIdx:end)];
        solMinus.XData = [xVals(1:xIdx,tIdx);xShockVals(k)];
        solMinus.YData = [uVals(1:xIdx);uMinus(k)];
        solShock.XData = [xShockVals(k) xShockVals(k)];
        solShock.YData = [uPlus(k) uMinus(k)];
        drawnow
    end
end

end

function AddLabels(p)
p.Parent.Title.String = "Plot the Solution";
p.Parent.XLabel.String = "Position (x)";
p.Parent.YLabel.String = "Speed (u)";
end