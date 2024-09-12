function [uMin,uMax] = FindUBounds(opts)
arguments
    opts.xMinVal = -3
    opts.xMaxVal = 3
    opts.NumPoints = 100
    opts.uVals = 1
    opts.f
end

try
    SecondDer = double(der(opts.f,2));
catch
    SecondDer = 1;
end

if SecondDer==0
    uVals = double([opts.f(opts.xMinVal) opts.f(opts.xMaxVal)]);
    uMin = min(uVals);
    uMax = max(uVals);
elseif isscalar(opts.uVals)
    uVals = double(opts.f(linspace(opts.xMinVal,opts.xMaxVal,opts.NumPoints)));
    [uMin,uMax] = bounds(uVals,"all");
else
    [uMin,uMax] = bounds(opts.uVals,"all");
end
end

