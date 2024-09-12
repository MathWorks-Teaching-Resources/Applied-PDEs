function MyColor = ChooseColor(u0,uMax,uMin,cmap)
[r,~] = size(cmap);
uMaxLocal = max([u0(:);uMax]);
uMinLocal = min([u0(:);uMin]);
if r > 1
    stepsize = (uMaxLocal-uMinLocal)/r;
    idx = floor((u0-uMinLocal)/stepsize)+1;
    MyColor = cmap(min(idx,r),:);
else
    MyColor = cmap;
end
end