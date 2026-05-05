%  Pre-run script for MethodOfCharacteristicsSoln.mlx
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----
 
edit = @(str)MyEdit(str);

function MyEdit(str)
assert(exist(str,"file"))
disp("Edit the file " + str)
end