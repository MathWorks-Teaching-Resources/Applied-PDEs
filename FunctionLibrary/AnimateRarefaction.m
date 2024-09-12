function AnimateRarefaction(pt,spd)
p = plot([pt-1 pt nan nan pt pt+spd+1],[0 0 nan nan spd spd],LineWidth=3);
title("Solutions Corresponding to Characteristic Curves with Rarefaction")
subtitle("t=0")
hold on
a = fill([pt pt pt pt],[-0.5 -0.5 spd+0.5 spd+0.5],[1 0.7 0],EdgeColor="none",FaceAlpha=0.3);
hold off
legend(["" "Rarefaction region"],Location="north")
xlabel("x (position)")
ylabel("u (wave speed)")
xticks(pt)
xticklabels("jump point")
yticks([0 spd])
yticklabels([0 "speed"])
p.Parent.XLim = [pt-1 pt+spd+1];
p.Parent.YLim = [-0.5 spd+0.5];
for tstep = 1:100
    p.XData = [pt-1 pt nan nan pt+0.01*tstep*spd pt+spd+1+0.01*tstep*spd];
    a.Vertices(:,1) = [pt pt + 0.01*tstep*spd pt + 0.01*tstep*spd pt];
    p.Parent.Subtitle.String = "t = " + 0.01*tstep;
    drawnow
end
end