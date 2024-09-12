function xVals = StopAtShock(xVals,tVals,tShock,xShock)
tShockIdx = find(tVals>=tShock(2),1);
xMinusIdx = xVals(:,tShockIdx)<=xShock(2);
xPlusIdx = xVals(:,tShockIdx)>=xShock(2);
tol = 1e-3;
for tIdx = tShockIdx:length(tVals)
    % When a characteristic curve crosses a shock it ends
    xVals((xVals(:,tIdx)>(xShock(tIdx-tShockIdx+2)-tol)&xMinusIdx),tIdx)=nan;
    xVals(xVals(:,tIdx)<(xShock(tIdx-tShockIdx+2)-tol)&xPlusIdx,tIdx)=nan;
    % Once the crossing has happened, the characteristic is gone
    xVals(isnan(xVals(:,tIdx-1))) = nan;
end
end