function ax = PlotCharacteristicCurves(tVals,x0Vals,IC,xEqn,xL,opts)
%#text
% This function takes vectors of `tVals` and `x0Vals` as well as the 
% initial condition function `IC` $=f(x,t\_0)$ and the `xEqn` function 
% $x(x\_0,t,u\_0)$.

arguments
    tVals (1,:) double
    x0Vals (1,:) double
    IC sym
    xEqn sym
    xL (1,2) double = [min(x0Vals) max(x0Vals)]
    opts.NumColors (1,1) {mustBeInteger,mustBePositive} = 8
    opts.animate logical = false
    opts.ShockTimes double = 0
    opts.ShockVals double = 0
    opts.yStar (1,1) double = nan
    opts.ShockTimes2 double = 0
    opts.ShockVals2 double = 0
    opts.yStar2 (1,1) double = nan
    opts.t0 (1,1) double = 0
    opts.DrawShock = false
end

t0Idx = find(tVals==opts.t0);
if opts.DrawShock && isnan(opts.yStar)
    opts.yStar = opts.ShockVals(1);
end

if opts.DrawShock
    NumShock = 1;
    if numel(opts.ShockTimes) ~= numel(opts.ShockVals)
        error("The shock times and shock values must agree.")
    elseif nnz(opts.ShockTimes) < 1
        error("There must be a nonzero vector of shock times.")
    elseif numel(opts.ShockVals2) == numel(opts.ShockTimes2) && numel(opts.ShockVals2) > 1
        NumShock = 2;
    end
    tShock = [opts.ShockTimes(1) tVals(tVals>=opts.ShockTimes(1))];
    xShock = interp1(opts.ShockTimes,opts.ShockVals,tShock);
    if NumShock == 2
        tShock2 = [opts.ShockTimes2(1) tVals(tVals>=opts.ShockTimes2(1))];
        xShock2 = interp1(opts.ShockTimes2,opts.ShockVals2,tShock2);
    end
end

if opts.animate
    [ax,u0Vals,uMin,uMax,MyColors] = CreateBasePlot(x0Vals,tVals,opts.NumColors,xL,IC);

    xVals = CalculateMeshValues(rhs(xEqn),tVals,x0Vals,u0Vals);

    pt = gobjects(size(x0Vals));

    if opts.DrawShock
        xVals = StopAtShock(xVals,tVals,tShock,xShock,opts.yStar,t0Idx);
        if NumShock == 2
            xVals = StopAtShock(xVals,tVals,tShock2,xShock2,opts.yStar2,t0Idx);
        end
    end

    hold on
    for xIdx = 1:length(x0Vals)
        pt(xIdx) = plot(tVals(1),x0Vals(xIdx),Color=ChooseColor(u0Vals(xIdx),uMax,uMin,MyColors));
    end
    for tIdx = 2:length(tVals)
        for xIdx = 1:length(x0Vals)
            pt(xIdx).XData = tVals(1:tIdx);
            pt(xIdx).YData = xVals(xIdx,1:tIdx);
        end
        drawnow
    end
    hold off
else
    if opts.DrawShock

        [ax,u0Vals,uMin,uMax,MyColors] = CreateBasePlot(x0Vals,tVals,opts.NumColors,xL,IC);

        xVals = CalculateMeshValues(rhs(xEqn),tVals,x0Vals,u0Vals);

        if opts.DrawShock
            xVals = StopAtShock(xVals,tVals,tShock,xShock,opts.yStar,t0Idx);
            if NumShock == 2
                xVals = StopAtShock(xVals,tVals,tShock2,xShock2,opts.yStar2,t0Idx);
            end
        end

        hold on
        for xi = 1:numel(x0Vals)
            plot(tVals,xVals(xi,:),Color=ChooseColor(u0Vals(xi),uMax,uMin,MyColors))
        end
        hold off
    else
        [ax,~,uMin,uMax,MyColors,ICfun] = CreateBasePlot(x0Vals,tVals,opts.NumColors,xL,IC);
        syms x0 u0 t
        hold(ax,"on")
        for xi = x0Vals
            CC1 = matlabFunction(rhs(xEqn),Vars=[x0 u0 t]);
            CC = @(t)CC1(xi,ICfun(xi),t);
            plot(ax,tVals,CC(tVals),Color=ChooseColor(ICfun(xi),uMax,uMin,MyColors))
        end
        hold(ax,"off")
    end
end
end

function xVals = StopAtShock(xVals,tVals,tShock,xShock,yStar,t0Idx)
tShockIdx = find(tVals>=tShock(1),1);
xMinusIdx = xVals(:,t0Idx)<=yStar;
xPlusIdx = xVals(:,t0Idx)>=yStar;
for tIdx = tShockIdx:length(tVals)
    xVals(xVals(:,tIdx)>xShock(tIdx-tShockIdx+1)&xMinusIdx,tIdx)=nan;
    xVals(xVals(:,tIdx)<xShock(tIdx-tShockIdx+1)&xPlusIdx,tIdx)=nan;
end
% Check that all curves end permanently
for xIdx = 1:length(xVals(:,1))
    idxStop = find(isnan(xVals(xIdx,tShockIdx:end)),1,"first");
    if ~isempty(idxStop)
        xVals(xIdx,tShockIdx+idxStop:end) = nan;
    end
end
end

function [ax,u0Vals,uMin,uMax,MyColors,ICfun] = CreateBasePlot(x0Vals,tVals,NumColors,xL,IC)
    syms x
   MyColors = turbo(NumColors);
    [uMin,uMax] = FindUBounds(xMinVal=xL(1),xMaxVal=xL(2),f=IC);
    try
        ICfun = matlabFunction(IC);
    catch ME
        % matlabFunction doesn't handle piecewise
        ICfun = @(x)double(IC(x));
    end
    u0Vals = ICfun(x0Vals);
    
    s = scatter(tVals(1)*ones(size(x0Vals)),x0Vals,40,ChooseColor(u0Vals,uMax,uMin,MyColors),"filled");
    ax = s.Parent;
    xlabel("t")
    ylabel("x")
    title("Plot of the characteristic curves")
    xlim([min(tVals) max(tVals)])
    ylim(xL)

end

function xVals = CalculateMeshValues(xEqn,tVals,x0Vals,u0Vals)
    syms x0 u0 t
    xFun = matlabFunction(xEqn,Vars=[x0,u0,t]); 
    [T,X0] = meshgrid(tVals,x0Vals);
    [~,U0] = meshgrid(tVals,u0Vals);
    xVals = xFun(X0,U0,T);
end