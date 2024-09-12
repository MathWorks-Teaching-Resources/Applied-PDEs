function [xReg1,xReg2,tShockVals,idxStar,yPlus,yMinus,t0Idx] = ShadeShockRegion(ax,tStar,xStar,xEqn,f,uSol,opts)
%#text
% This function requires an axis, `ax`, that already has a characteristic 
% plot drawn. This function will annotate that characteristic plot by 
% identifying the boundaries of the shock region and shading it. The return 
% values are the coordinates of `xPlus` and `xMinus` and the corresponding 
% `tVals`.

arguments
    ax
    tStar (1,1) double
    xStar (1,1) double
    xEqn sym
    f sym
    uSol sym
    opts.x0Star (1,1) double = xStar
    opts.t0 (1,1) double = 0
end

% Filter for only the characteristic curves
h = findobj(ax,"Type","Line");

% Set up the time vector for the shock region by using a representative
% characteristic curve. They all have the same time vector.
[~,idxStar] = find(h(1).XData>tStar,1);
[~,tMaxIdx] = max(h(1).XData);
tShockVals = [tStar h(1).XData(idxStar:tMaxIdx)];
t0Idx = find(h(1).XData == opts.t0);

% Initialize the index value to track the location of the shock among all
% the characteristic curves.
idx = 1;

% Check assumptions: the first curve should be at the top of the plot
if h(idx).YData(t0Idx) <= opts.x0Star
    error("The plot is in an unexpected order.")
end

% Cycle through characteristic curves to find the sets that are above and
% below the beginning of the shock
while h(idx).YData(t0Idx) > opts.x0Star
    idx = idx+1;
end

% Check for a discontinuity
syms x0 t u0
u0Plus = double(uSol(opts.x0Star+1e-6,opts.t0,f(opts.x0Star+1e-6)));
u0Minus = double(uSol(opts.x0Star-1e-6,opts.t0,f(opts.x0Star-1e-6)));

HasDiscontinuity = abs(u0Plus-u0Minus)>1e-3;

% Adjust indices to account for the beginning of the shock being equal to
% one of the characteristic curves
if h(idx).YData(t0Idx)==opts.x0Star
    if HasDiscontinuity
        idxMinus = idx+1;
        idxPlus = idx-1;
    else
        idxMinus = idx;
        idxPlus = idx;
    end
elseif h(idx).YData(t0Idx)<opts.x0Star
    idxPlus = idx-1;
    idxMinus = idx;
else
    disp("Why are you here?")
end

% Define sets of characteristic curves that originate 'above' and 'below'
% the shock. 
yPlus = zeros(idxPlus+1,numel(h(1).YData));
yMinus = zeros(numel(h)-idxMinus+2,numel(h(1).YData));

% Ensure that, if there is a discontinuity at the shock point, both curves
% are included in their relevant sets. 
if HasDiscontinuity
    yPlus(end,:) = xStar + u0Plus*(h(1).XData-tStar);
    yMinus(1,:) = xStar + u0Minus*(h(1).XData-tStar);
else
    yStartShock = h(idxMinus).YData;
    yPlus(end,:) = yStartShock;
    yMinus(1,:) = yStartShock;
end

% Include all the other lines in the 'above' and 'below' sets
for k = 1:idxPlus
yPlus(k,:) = h(k).YData;
end
for k = 2:numel(h)-idxMinus+2
yMinus(k,:) = h(idxMinus+k-2).YData;
end


% else
% xPlus(t) = subs(xEqn,[x0 u0],[xStar u0Plus]);
% xMinus(t) = subs(xEqn,[x0 u0],[xStar u0Minus]);
% yPlus(end,:) = double(xPlus(h(1).XData)-tStar);
% yMinus(end,:) = double(xMinus(h(1).XData)-tStar);
% end

xReg1 = zeros(size(tShockVals));
xReg2 = xReg1;
xReg1(1) = xStar;
xReg2(1) = xStar;

% Define the boundaries of the shock region by the maximum/minimum,
% respectively, of the values of all curves that have crossed the shock
% line by a given point in time. The shock must travel somewhere within
% these boundaries.
for idx = 2:numel(xReg1)
    xReg1(idx) = max(yMinus(yMinus(:,idxStar+idx-3)<=xReg1(idx-1),idxStar+idx-2));
    xReg2(idx) = min(yPlus(yPlus(:,idxStar+idx-3)>=xReg2(idx-1),idxStar+idx-2));
 %   xReg1(idx) = max(yMinus(:,idxStar+idx-2));
 %   xReg2(idx) = min(yPlus(:,idxStar+idx-2));
end
% Draw the region
fill([tShockVals, fliplr(tShockVals)],[xReg1, fliplr(xReg2)],[.5 .5 .5])

idxStar = idxStar-1;
end
