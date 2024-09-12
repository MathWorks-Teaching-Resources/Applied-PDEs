function PlotSolnWithShock(uSol,tVals,x0Vals,IC,xEqn,xShockVals,tShockVals,yStar,opts)
arguments
    uSol sym
    tVals (1,:) double
    x0Vals (1,:) double
    IC sym
    xEqn sym
    xShockVals (1,:) double = nan
    tShockVals (1,:) double = nan
    yStar (1,1) double = xShockVals(1)
    opts.HasShock logical = false
    opts.XBounds (1,2) double = [min(x0Vals,[],"all") max(x0Vals,[],"all")];
    opts.SecondShock (1,:) double = nan;
    opts.SecondYStar (1,1) double = nan;
end

if opts.HasShock
    HasSecondShock = numel(opts.SecondShock)>1;
    tStar = tShockVals(1);
    % Ensure that shocks come in order from least x-value to greatest
    if HasSecondShock
        if opts.SecondYStar < yStar
            xShockVals2 = xShockVals;
            xShockVals = opts.SecondShock;
        else
            xShockVals2 = opts.SecondShock;
        end
    end



    % Guarantee that the shock point is in tVals and x0Vals
    if nnz(tStar==tVals)==0
        tVals = unique([tStar tVals]);
    end
    if HasSecondShock
        x0Vals = sort([yStar opts.SecondYStar x0Vals]);
    else
        x0Vals = sort([yStar x0Vals]);
    end


    % Ensure that the xShock points correspond to tVals points
    tShock = tVals(tVals>=tStar);
    xShock = interp1(tShockVals,xShockVals,tShock);
    xStar = xShock(1);
    if HasSecondShock
        xShock2 = interp1(tShockVals,xShockVals2,tShock);
        xStar2 = xShock2(1);
    end


end

syms x x0 t0 u0 t
u0Vals = double(subs(IC,x,x0Vals));
xFun(x0,u0,t) = subs(rhs(xEqn),t0,tVals(1));
[T,X0] = meshgrid(tVals,x0Vals);
[~,U0] = meshgrid(tVals,u0Vals);
xVals = double(xFun(X0,U0,T));
uMinLim = min(U0,[],"all")-0.1*range(U0,"all");
uMaxLim = uMinLim+1.2*range(U0,"all");

if opts.HasShock
    xVals = StopAtShock(xVals,tVals,tShock,xShock);
    xPlusIdx = x0Vals>=yStar;
    xMinusIdx = x0Vals<=yStar;
    % [xPlusIdx,xMinusIdx] = EnsureOverlap(xPlusIdx,xMinusIdx,x0Vals,yStar);
end

if HasSecondShock
    xVals = StopAtShock(xVals,tVals,tShock,xShock2);
    xPlusIdx2 = x0Vals>=opts.SecondYStar;
    xMinusIdx2 = x0Vals<=opts.SecondYStar;
    % [xPlusIdx2,xMinusIdx2] = EnsureOverlap(xPlusIdx2,xMinusIdx2,x0Vals,opts.SecondYStar);
end


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
    tShockIdx = find(tVals==tStar);

    % Plot the normal solutions up through the time of the shock
    % Finish by setting up the shock jump point(s)
    solMinus = plot(x0Vals(xMinusIdx),u0Vals(xMinusIdx),SeriesIndex=1,LineWidth=2);
    AddLabels(solMinus)
    ylim([uMinLim uMaxLim])
    xlim(opts.XBounds)
    if HasSecondShock
        hold on
        solBetween = plot(x0Vals(xPlusIdx & xMinusIdx2),u0Vals(xPlusIdx&xMinusIdx2),SeriesIndex=1,LineWidth=2);
        solPlus = plot(x0Vals(xPlusIdx2),u0Vals(xPlusIdx2),SeriesIndex=1,LineWidth=2);
        hold off
    else
        hold on
        solPlus = plot(x0Vals(xPlusIdx),u0Vals(xPlusIdx),SeriesIndex=1,LineWidth=2);
        hold off
    end
    drawnow
    for k = 2:tShockIdx-1
        solMinus.XData = xVals(xMinusIdx,k);
        if HasSecondShock
            solBetween.XData = xVals(xPlusIdx & xMinusIdx2,k);
            solPlus.XData = xVals(xPlusIdx2,k);
        else
            solPlus.XData = xVals(xPlusIdx,k);
        end
        drawnow

    end
    hold on
    if HasSecondShock
        solShock2 = plot([xStar2 xStar2],[solBetween.YData(end) solPlus.YData(1)],SeriesIndex=2,LineWidth=2);
        %solShock2 = plot([xStar2 xStar2],[solMinus.YData(end) solPlus.YData(1)],SeriesIndex=2,LineWidth=2);
        solShock = plot([xStar xStar],[solMinus.YData(end) solBetween.YData(1)],SeriesIndex=2,LineWidth=2);
        %solShock = plot([xStar xStar],[solMinus.YData(end) solPlus.YData(1)],SeriesIndex=2,LineWidth=2);
    else
        solShock = plot([xStar xStar],[solPlus.YData(1) solMinus.YData(end)],SeriesIndex=2,LineWidth=2);
    end
    hold off
    subtitle("Shock!")
    drawnow
end

if opts.HasShock
    StartIdx = 1;
    yStarIdx = find(x0Vals==yStar);
    if HasSecondShock
        yStarIdx2 = find(x0Vals==opts.SecondYStar);
        xMid = xVals(yStarIdx:yStarIdx2,:);
    end
    for k = tShockIdx:numel(tVals)
        mIdx = find(isnan(xVals(xMinusIdx,k)),1,"first");
        if HasSecondShock
            m2Idx = find(~isnan(xMid(:,k)),1,"last");
            p2Idx = find(~isnan(xMid(:,k)),1,"first");
            if p2Idx==1
                m2Idx = yStarIdx2-yStarIdx+1;
                p2Idx = 1;
            end
        end
        pIdx = yStarIdx+find(isnan(xVals(xPlusIdx,k)),1,"last");
        if isempty(mIdx)
            mIdx = numel(xVals(xMinusIdx,k));
            solMinus.XData = [xVals(xMinusIdx,k);xShock(k-tShockIdx+1)];
            if solMinus.XData(end-1)==solMinus.XData(end)
                solMinus.XData = xVals(StartIdx:mIdx,k);
            else
                solMinus.YData = [u0Vals(StartIdx:mIdx-1) u0Vals(mIdx-1)];
            end
        else
            xLocal = xMinusIdx;
            xLocal(mIdx:end) = 0;
            solMinus.XData = [xVals(xLocal,k);xShock(k-tShockIdx+1)];
            solMinus.YData = u0Vals(StartIdx:mIdx);
        end
        if HasSecondShock
            solBetween.XData = [xShock(k-tShockIdx+1);xMid(p2Idx:m2Idx,k);xShock2(k-tShockIdx+1)];
            if p2Idx == 1
                solBetween.YData = [u0Vals(yStarIdx) u0Vals(yStarIdx:yStarIdx2) u0Vals(yStarIdx2)];
            else
                solBetween.YData = u0Vals(p2Idx-1:m2Idx+1);
            end
            if isempty(pIdx)
                solPlus.XData = [xShock2(k-tShockIdx+1);xVals(yStarIdx2:end,k)];
                solPlus.YData = [u0Vals(yStarIdx2) u0Vals(yStarIdx2:end)];
            else
                solPlus.XData = [xShock2(k-tShockIdx+1);xVals(pIdx:end,k)];
                solPlus.YData = u0Vals(pIdx-1:end);
            end

            solShock.XData = [xShock(k-tShockIdx+1) xShock(k-tShockIdx+1)];
                 solShock.YData = [solMinus.YData(end) solBetween.YData(1)];
            %solShock.YData = [solMinus.YData(end) solPlus.YData(1)];
            solShock2.XData = [xShock2(k-tShockIdx+1) xShock2(k-tShockIdx+1)];
                 solShock2.YData = [solBetween.YData(end) solPlus.YData(1)];
            %solShock2.YData = [solMinus.YData(end) solPlus.YData(1)];

        else
            if isempty(pIdx)
                solPlus.XData = [xShock(k-tShockIdx+1);xVals(xPlusIdx,k)];
                if solPlus.XData(1)==solPlus.XData(2)
                    solPlus.XData = solPlus.XData(2:end);
                else
                    solPlus.YData = u0Vals(yStarIdx:yStarIdx+numel(solPlus.XData));
                end
            else
                xLocal = xPlusIdx;
                xLocal(yStarIdx:pIdx) = 0;
                solPlus.XData = [xShock(k-tShockIdx+1);xVals(xLocal,k)];
                if solPlus.XData(1) == solPlus.XData(2)
                    solPlus.XData = solPlus.XData(1:end-1);
                    solPlus.YData = u0Vals(xLocal);
                else
                    solPlus.YData = [u0Vals(pIdx+1) u0Vals(xLocal)];
                end
            end

            solShock.XData = [xShock(k-tShockIdx+1) xShock(k-tShockIdx+1)];
            solShock.YData = [solPlus.YData(1) solMinus.YData(end)];
        end
        drawnow
    end
end

end

function AddLabels(p)
p.Parent.Title.String = "Plot the Solution";
p.Parent.XLabel.String = "Position (x)";
p.Parent.YLabel.String = "Speed (u)";
end

function xVals = StopAtShock(xVals,tVals,tShock,xShock)
ShockIdx = find(tVals>=tShock(1),1);
MinusIdx = xVals(:,ShockIdx)<=xShock(1);
PlusIdx = xVals(:,ShockIdx)>=xShock(1);
tol = 1e-3;
for tIdx = ShockIdx:length(tVals)
    % When a characteristic curve crosses a shock it ends
    xVals((xVals(:,tIdx)>(xShock(tIdx-ShockIdx+1)-tol)&MinusIdx),tIdx)=nan;
    xVals(xVals(:,tIdx)<(xShock(tIdx-ShockIdx+1)+tol)&PlusIdx,tIdx)=nan;
end
% % Check that all curves end permanently
% for xIdx = 1:length(xVals(:,1))
%     idxStop = find(isnan(xVals(xIdx,:)),1,"first");
%     if ~isempty(idxStop)
%         xVals(xIdx,idxStop:end) = nan;
%     end
% end
end

function [PlusIdx,MinusIdx] = EnsureOverlap(PlusIdx,MinusIdx,ShockVec,xStar)
if nnz(MinusIdx+PlusIdx==2) ~= 1
    % Check which index is missing the overlap at the shock
    idx = find(MinusIdx == 1,1,"last");
    if abs(ShockVec(idx)-xStar) < abs(ShockVec(idx+1)-xStar)
        MinusIdx(idx+1)=1;
    else
        PlusIdx(idx)=1;
    end
end
end