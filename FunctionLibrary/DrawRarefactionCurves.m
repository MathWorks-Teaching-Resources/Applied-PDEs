function DrawRarefactionCurves(ax,tStar,xStar,xReg1,xReg2,n,uMin,uMax)
syms t
slope1 = double(diff(xReg1,t));
slope2 = double(diff(xReg2,t));
allSlopes = linspace(slope1,slope2,n);
MyColors = turbo(n);
tBnds = ax.XLim;
tMax = tBnds(2);
for idx = 1:n
    plot(ax, [tStar tMax],[xStar xStar + allSlopes(idx)*(tMax-tStar)],Color=ChooseColor(allSlopes(idx),uMax,uMin,MyColors))
    drawnow
end
end