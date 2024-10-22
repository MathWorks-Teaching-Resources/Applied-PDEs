function u = CNu0Soln(u0,alpha,beta,tEnd,dx,gamma,L,t0)
% Solve the 1D heat equation u_t = gamma*u_{xx} on a rod of length L
%   using the Crank-Nicolson method
%   u(t,0) = alpha(t)
%   u(t,L) = beta(t)
%   u(t0,x) = u0
%   The desired spatial resolution is dx
%   Output is u = u(tEnd,x_m), a vector of values on the mesh points

% Define dt with reference to both error and stability concerns
% Optimal dt for stability
dtOpt = dx;
% Forcing an integer numbers of dt steps that terminate at tEnd
dt = tEnd/ceil((tEnd-t0)/dtOpt);

% % testing %%%%%%%%%%
% dt = 0.005;
 
% Set up the helper values for defining the required matrices
numRows = L/dx-1;
mu = gamma*dt/(dx^2);
baseDiag = ones(1,numRows);

% Define modA for the explicit updating rule 
% modA-I = (A-I)/2, where I is the identity matrix
modA = gallery('tridiag',0.5*mu*baseDiag(1:end-1),(1-mu)*baseDiag,0.5*mu*baseDiag(1:end-1));

% Define modB for the implicit updating rule 
% modB-I = (B-I)/2, where I is the identity matrix
modB = gallery('tridiag',-0.5*mu*baseDiag(1:end-1),(1+mu)*baseDiag,-0.5*mu*baseDiag(1:end-1));

% Initialize bAvg = b^(j)+b^(j+1) as a vector of zeros
bAvg = zeros(numRows,1);

% Define a spatial mesh vector
xVals = linspace(0,L,round(L/dx)+1);

% Initialize the output to the interior points of u0 
u = u0(2:end-1);

% To visualize the outputs
p = plot(xVals,u0,"LineWidth",4);
ax = p.Parent;

% Set the y limits to reasonable fixed values
minAlpha = min(alpha(0:dt:tEnd));
maxAlpha = max(alpha(0:dt:tEnd));
minBeta = min(beta(0:dt:tEnd));
maxBeta = max(beta(0:dt:tEnd));
yLower = min([ax.YLim(1),minAlpha,minBeta]);
yUpper = max([ax.YLim(2),maxAlpha,maxBeta]);
scale = (yUpper-yLower)*0.05;
ax.YLim = [yLower-scale yUpper+scale];

title("Solving $\frac{\partial u}{\partial t} = \gamma \frac{\partial^2 u}{\partial x^2}$","Interpreter","latex")
subtitle("$t=0$","Interpreter","latex")
xlabel("$x$","Interpreter","latex")
ylabel("$u$","Interpreter","latex")

% Compute new values for halfB*u^(j+1)-b^(j+1) = halfA*u^(j)+b^(j)
% Loop over timesteps to reach tEnd
for j = 0:(tEnd/dt - 1)
    bAvg(1) = mu*(alpha(j*dt)+alpha((j+1)*dt))/2;
    bAvg(end) = mu*(beta(j*dt)+beta((j+1)*dt))/2;
    u = modB\(modA*u+bAvg);   
    % To visualize the outputs
    hold on
    delete(ax.Children(1:end-1));
    plot(xVals,[alpha((j+1)*dt);u;beta((j+1)*dt)],LineWidth=4,SeriesIndex="none")
    subtitle("$t = $"+dt*(j+1))
    drawnow
    pause(0.1)     
    hold off
    % End visualization code
end

end
