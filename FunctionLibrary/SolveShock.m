function [xShock,uPlus,uMinus] = SolveShock(tShockVals,tShockIdx,xStar,yPlus,yMinus,IC,t0Idx,opts)
arguments
    tShockVals (1,:) double
    tShockIdx (1,1) double {mustBeInteger}
    xStar (1,1) double
    yPlus double
    yMinus double
    IC sym
    t0Idx (1,1) double = 1
    opts.T sym
    opts.X sym
end

dt = diff(tShockVals);

syms u
T(u) = opts.T;
X(u) = opts.X;

xShock = zeros(size(tShockVals));
uPlus = zeros(size(tShockVals));
uMinus = zeros(size(tShockVals));
xShock(1) = xStar;
try
ICFun = matlabFunction(IC);
catch ME
    ICFun = @(x)double(IC(x));
end

uPlus(1) = ICFun(yPlus(end,t0Idx));
uMinus(1) = ICFun(yMinus(1,t0Idx));

for k = 1:numel(xShock)-1
    % Locate the xPlus value of the characteristic curve hitting the shock
    % from the positive x direction
    LastAbove = find(yPlus(:,tShockIdx+k-1)>=xShock(k),1,"last");
    if ~isempty(LastAbove) && LastAbove < numel(yPlus(:,1))
        PlusTest = LastAbove+1;
        uPlus(k+1) = ICFun(yPlus(PlusTest,t0Idx));
    else
        uPlus(k+1) = uPlus(k);
    end
    %    PlusIdx = find(yPlus(:,tShockIdx+k-1)>xShock(k),1,"last")
    % Trace that characteristic curve back to the start to calculate the
    % value of u along that curve
    %    uPlus(k+1) = double(IC(yPlus(PlusIdx,t0Idx)));

    % Locate the xMinus value of the characteristic curve hitting the shock
    % from the negative x direction
    LastBelow = find(yMinus(:,tShockIdx+k-1)>=xShock(k),1,"last");
    if ~isempty(LastBelow) && LastBelow < numel(yPlus(:,1))
        MinusTest = LastBelow+1;
        uMinus(k+1) = ICFun(yMinus(MinusTest,t0Idx));
    else
        uMinus(k+1) = uMinus(k);
    end
    % Calculate the slope of the shock at that point and update the value
    % using a first order difference approximation
    if uPlus(k)==uMinus(k)
        xShock(k+1) = xShock(k)+uPlus(k)*dt(k);
    else
        dShockdt= double((X(uPlus(k))-X(uMinus(k)))/(T(uPlus(k))-T(uMinus(k))));
        xShock(k+1) = xShock(k)+dShockdt*dt(k);
    end
end

end