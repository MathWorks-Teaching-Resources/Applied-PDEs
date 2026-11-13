%  Pre-run script for ImplementExplicitSolver.m
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----
 
open = @(str)MyEdit(str);


% <matlab:ShareFeedback Share your feedback>

function MyEdit(str)
assert(exist(str,"file"))
disp("Edit the file " + str)
end