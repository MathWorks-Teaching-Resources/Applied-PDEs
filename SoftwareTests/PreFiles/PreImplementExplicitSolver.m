%  Pre-run script for ImplementExplicitSolver.mlx
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----
 
open = @(str)MyEdit(str);

function MyEdit(str)
assert(exist(str,"file"))
disp("Edit the file " + str)
end