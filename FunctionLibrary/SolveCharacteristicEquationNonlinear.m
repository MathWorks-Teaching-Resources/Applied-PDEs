function [tEqn,xEqn2,uSol] = SolveCharacteristicEquationNonlinear(f,a,c,b,t0,opts)
arguments
    f
    a
    c
    b
    t0
    opts.ShowConditions = false
    opts.PrintSoln = true
end
%#text
% $a(t)\\frac{\\partial u}{\\partial t} \+ c(u)\\frac{\\partial 
% u}{\\partial x} \- b(t,x,u) = 0$.             $(\\star)$
%
% $u(x,t\_0) = f(x)$

% Create functions for each coefficient a, c, b
if class(c)=="sym"
    syms t x u T(s) X(s) u0
    B = subs(c,[t x u],[T X u0]);
else
    B = c;
end

if class(a)=="sym"
    syms t x u T(s) X(s) u0
    A = subs(a,[t x u],[T X u0]);
else
    A = a;

end

if class(b)=="sym"
    syms t x u T(s) X(s) U(s)
    C = subs(b,[t x u],[T X U]);
else
    C = b;
end

syms u(x,t) uSol(x,t,u0) T(s) X(s) U(s) s t x x0 u0 F(x)

% % Name the initial condition function
F(x) = f;

% Time is a real variable
assume(t,"real")

% Solve the ODE for t as a function of the parameter s. If this is not
% solvable, give up on this method for now.
dtds = diff(T,s)==A;
tEqn = t == dsolve(dtds,T(0)==t0);
sEqn = solve(tEqn,s);

% Solve the ODE for u as a function of the characteristic variable x0 along
% characteristic curves parametrized by s.
duds = diff(U,s) == -subs(C,T,rhs(tEqn));
UEqn = u == dsolve(duds,U(0)==u0);
UEqn2 = subs(UEqn,s,sEqn);

% Solve the ODE for x as a function of s.
dxds = diff(X,s)==subs(B,T,rhs(tEqn));
xEqn = x == dsolve(dxds,X(0)==x0);
xEqn2 = subs(xEqn,s,sEqn);
CharCurve = solve(xEqn2,x0,"ReturnConditions",true);
U0 = F(CharCurve.x0);
%CharSoln(x,t,u0) = simplify(subs(F(subs(CharCurve.x0,t0,0))+subs(rhs(UEqn)-u0,[T X],[rhs(tEqn) rhs(xEqn3)]),s,sEqn));

CharSoln =  subs(UEqn2,u0,U0);
uSol(x,t,u0) = rhs(CharSoln);

if opts.PrintSoln
    ExplainSolution(f,a,b,c,t0,dtds,tEqn,sEqn,duds,UEqn,UEqn2,dxds,xEqn2,CharCurve,CharSoln)
end
if opts.ShowConditions
    displayFormula("CharCurve.conditions")
end
end