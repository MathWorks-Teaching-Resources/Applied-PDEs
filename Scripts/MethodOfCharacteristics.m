%[text] %[text:anchor:T_B454ACC4] # The Method of Characteristics
%[text] [⇦ Main Menu](file:MainMenu.m)
%[text] The transport equation is a simplified convection-diffusion equation with diffusivity 0, i.e., with pure convection or advection. It can describe the temporospatial changes in the concentration of some quantity where diffusion is minimal, such as tracking the path of a human caught in an avalanche, the movement of a chemical spill down a river, or a pressure wave moving through a solid. 
%[text] Solving partial differential equations is a challenge because so many possibilities must be explored. There are two fundamental approaches to solving PDEs: reduce the problem to something simpler, such as a system of ODEs, or numerically approximate the results. This script will apply the first method. The approach in this script is geometric and goes by various names, including the method of characteristics and the method of lines. 
%[text:tableOfContents]{"heading":"Table of Contents"} %[text:anchor:M_597CA885]
%[text] %[text:anchor:H_51183E7B] **Before you get started:**
%[text] This live script is intended to be used in Output Inline or Hide Code. On the **View** tab of the MATLAB Toolstrip, in the **View** section, select **Output Inline** or **Hide Code**. Alternately, select **Output Inline** (![live script output inline icon](text:image:1bf1)) or **Hide Code** (![live script code hidden icon](text:image:02ff)) using the icons at the top right of the Live Editor pane.
%[text] ![Lightbulb mark](text:image:7e11) Interacting with this live script will build some familiarity with MATLAB as concepts and commands are introduced together. If you need more instruction, consider taking [MATLAB Onramp](https://matlabacademy.mathworks.com/details/matlab-onramp/gettingstarted), a free 2-hour online tutorial that teaches the essentials of MATLAB. If you want to learn more about using symbolic mathematics, consider taking the self-paced online course [Symbolic Math Onramp](https://matlabacademy.mathworks.com/details/introduction-to-symbolic-math-with-matlab/symbolic).
%[text] ![Warning symbol](text:image:0418)   For an optimal experience, follow the instructions and steps in the given sequence. Proceed to a new section only after completing the preceding one. Some sections depend on variables created in prior sections, and they will generate errors if they run out of order.
%[text] The ![Try this icon](text:image:1517)  and  ![Exercise icon](text:image:447c) icons refer to two different types of interactive activities that you will find in this script. The ![Try this icon](text:image:754f)  usually indicates an interaction where you will explore the visualization of some concept introduced in this script. The ![Exercise icon](text:image:9a3f) interactions are designed to challenge your understanding of the concepts.
%%
%[text] %[text:anchor:H_FA1AC967] ## Method of Characteristics
%[text] Consider a general first-order PDE in two variables $t${"altText":"t"} and $x${"altText":"x"}:
%[text]{"align":"center"} %[text:anchor:M_C8296B97]  $a(t,x,u)\\frac{\\partial u}{\\partial t} + b(t,x,u)\\frac{\\partial u}{\\partial x} - c(t,x,u) = 0${"altText":"a(t,x,u)(∂ u)\/(∂ t) + b(t,x,u)(∂ u)\/(∂ x) - c(t,x,u) = 0"}.             $(\\star)${"altText":"(star)"}
%[text] The basic idea of the method of characteristics is to use a change of variables to convert a partial differential equation into a system of ordinary differential equations. When $c(t,x,u)=0${"altText":"c(t,x,u)=0"} this approach will identify curves where the solution $u(x,t)${"altText":"u(x,t)"} is constant. Considering the contour plot of the solution surface $(t,x,u)${"altText":"(t,x,u)"} By traveling on a contour line, we guarantee that the value of the equation parameterized along the contour has total derivative 0. Let's call our parameter value $s${"altText":"s"}. 
%[text]{"align":"center"} $\\frac{d}{d s}\\left\[u\\right\] = \\frac{du}{ds}\\frac{\\partial u}{\\partial u} = \\frac{dt}{ds}\\frac{\\partial u}{\\partial t}+\\frac{dx}{ds}\\frac{\\partial u}{\\partial x} ${"altText":"(d)\/(d s)\[u\] = (du)\/(ds)(∂ u)\/(∂ u) = (dt)\/(ds)(∂ u)\/(∂ t)+(dx)\/(ds)(∂ u)\/(∂ x)"}
%[text]{"align":"center"} $\\frac{dt}{ds}\\frac{\\partial u}{\\partial t}+\\frac{dx}{ds}\\frac{\\partial u}{\\partial x} - \\frac{du}{ds} = 0${"altText":"(dt)\/(ds)(∂ u)\/(∂ t)+(dx)\/(ds)(∂ u)\/(∂ x) - (du)\/(ds) = 0"}
%[text] By identifying 
%[text]{"align":"center"} $\\frac{dt}{ds} = a(t,x,u)${"altText":"(dt)\/(ds) = a(t,x,u)"},      $\\frac{dx}{ds} = b(t,x,u)${"altText":"(dx)\/(ds) = b(t,x,u)"},     and      $\\frac{du}{ds} = c(t,x,u)${"altText":"(du)\/(ds) = c(t,x,u)"},
%[text] we can attempt to determine the shapes of the contours of the function $u(t,x)${"altText":"u(t,x)"}. Then, by following a contour back to a known value at an initial or boundary position, we can attempt to establish the solutions for $u${"altText":"u"} over the remainder of the domain.
%[text] %[text:anchor:H_76178BCA] ### **Example: Constant Speed**
%[text] Let's begin with the simplest possible non-trivial transport equation with $a${"altText":"a"} and $b${"altText":"b"} constant and $c=0${"altText":"c=0"}. This is a model of a system where the velocity is constant and, because $c=0${"altText":"c=0"} there is no source or sink for the quantity we are tracking. This could model a pressure wave in a pipe filled with a uniform substance, a chemical plume moving along a canal with a smooth current, or cars traveling along a road at a constant speed limit. Without loss of generality, we can assume that $a(t,x,u)=1${"altText":"a(t,x,u)=1"}. As an illustration, let's set $b(t,x,u)=-4${"altText":"b(t,x,u)=-4"}:
%[text]{"align":"center"} $\\frac{\\partial u}{\\partial t} - 4 \\frac{\\partial u}{\\partial x} = 0${"altText":"(∂ u)\/(∂ t) - 4 (∂ u)\/(∂ x) = 0"}
%[text] We begin by declaring several symbolic variables and functions to express this differential equation.
syms t x u(x,t)
MyPDE = diff(u,t)-4*diff(u,x) == 0;
displayFormula("MyPDE")
  %[control:button:48e5]{"position":[1,2]}
%%
%[text] First, observe that 
%[text]{"align":"center"} $\\frac{du}{ds} = 0 \\Rightarrow u(s) = u(s=0) = u\_0.${"altText":"(du)\/(ds) = 0 implies u(s) = u(s=0) = u\_0."}
%[text] Also,
%[text]{"align":"center"} $\\frac{dt}{ds} = 1 \\Rightarrow \\int\_0^s \\frac{dt}{ds}\\; ds = \\int\_0^s 1\\; ds \\Rightarrow t-t\_0 = s.${"altText":"(dt)\/(ds) = 1 implies integral\_0^s (dt)\/(ds) ds = integral\_0^s 1 ds implies t-t\_0 = s."}
%[text] Finally,
%[text]{"align":"center"} $\\frac{dx}{ds} = \\frac{dx}{dt} = -4 \\Rightarrow x-x\_0 = -4(t-t\_0).${"altText":"(dx)\/(ds) = (dx)\/(dt) = -4 implies x-x\_0 = -4(t-t\_0)."}
%[text] To fully solve this differential equation, we need to know the initial condition 
%[text]{"align":"center"} $u(x,t\_0)=f(x)${"altText":"u(x,t\_0)=f(x)"}, 
%[text] for some differentiable function $f${"altText":"f"}. Now, note that $u(x\_0,t\_0) = f(x\_0)${"altText":"u(x\_0,t\_0) = f(x\_0)"}.  That means that our initial condition is the 
  %[control:button:50c9]{"position":[1,2]}
syms x0 t0 f(y)
xEqn = x == x0-4*(t-t0);
displayFormula("xEqn")
%[text] Without loss of generality, we can choose $t\_0=0${"altText":"t\_0=0"}.
xEqn = subs(xEqn,t0,0);
displayFormula("xEqn")
CharCurve = solve(xEqn,x0);
displayFormula("x0 == CharCurve")
%%
%[text] Plugging this value into our initial condition gives us a characteristic solution: 
  %[control:button:75eb]{"position":[1,2]}
CharSoln = simplify(u(x,t) == f(CharCurve))
%%
%[text] Observe that if we check the result we get when $t=0${"altText":"t=0"} we get back to:
  %[control:button:6c2c]{"position":[1,2]}
CheckingResult = subs(CharSoln,t,0);
displayFormula("CheckingResult")
%[text] This may not seem an important step, but as your characteristic curves become more complicated, this can be a handy check on your computations. If your solution doesn't satisfy your initial conditions, it clearly cannot be correct. 
%%
%[text] This result becomes more interesting if we consider some possible initial conditions for our system:
f(y) = exp(-y^2); %[control:dropdown:381e]{"position":[8,17]}
  %[control:button:1ee8]{"position":[1,2]}
u(x,t) = simplify(f(subs(CharCurve,t0,0)))
%%
%[text] We can plot the characteristic curves.
trange = 0:0.01:3;
xinit = -4:0.4:15;
xFun(t,x0) = rhs(xEqn);
[T,X] = meshgrid(trange,xinit);
xVals = double(xFun(T,X));
  %[control:button:1757]{"position":[1,2]}
plot(trange,xVals,SeriesIndex="none");
xlim([0 trange(end)])
ylim([-4 3])
xlabel("t")
ylabel("x")
title("Characteristic curves of $\frac{\partial u}{\partial t} -4\frac{\partial u}{\partial x}  = 0$",Interpreter="latex")
%[text] In this case, the result is repetitive and hard to focus on. You might consider changing the stepsize in `xinit`.
%%
%[text] We can trace the values of our solution through time and space:
xRange = [-4 3];
  %[control:button:97e3]{"position":[1,2]}
figure
fplot(f,xRange)
ax = gca;
uRange = ax.YLim;
title("Initial Data")
subtitle("$u(x,0) = " + latex(f(x)) + "$",Interpreter="latex")
xlabel("$x$",Interpreter="latex")
ylabel("$u$",Interpreter="latex")
%%
%[text] By combining the initial data and the characteristic curves, we can trace the values of our solution forward through time and space. In the following plot, the color represents the value of the solution at that point on the $(t,x)${"altText":"(t,x)"} plane. Each constant-value contour curve is the same color. 
figure
% Choose colors to track the values of the solution
NumColors = 8;
MyColors = turbo(NumColors);
  %[control:button:2060]{"position":[1,2]}
% Indicate where t0 is
s = scatter(zeros(size(xinit)),xinit,40,ChooseColor(double(u(xinit,0)),uRange(2),uRange(1),MyColors),"filled");
title("Characteristic curves colored by solution value")
xlabel("$t$",Interpreter="latex")
ylabel("$x$",Interpreter="latex")
colormap("turbo")
colorbar("Ticks",linspace(0,1,NumColors),"TickLabels",string(linspace(uRange(1),uRange(2),NumColors)))

% Limit the window size so that the impact of transport is visible
xlim([0 trange(end)])
ylim(xRange)

% To animate efficiently, initialize the necessary graphics objects
pt = gobjects(size(xinit));
hold on
ContourColors = s.CData;
for xIdx = 1:length(xinit)
    pt(xIdx) = plot(trange(1),xinit(xIdx),Color=ContourColors(xIdx,:));
end
for tIdx = 2:length(trange)
    for xIdx = 1:length(xinit)
        pt(xIdx).XData = trange(1:tIdx);
        pt(xIdx).YData = xVals(xIdx,1:tIdx);
    end
    drawnow
end
hold off
%%
%[text] Alternately, we can use these results to create an animated plot showing how the initial data evolves over time.
  %[control:button:3c7d]{"position":[1,2]}
PlotSolutionCurves([0 3],[-5 5],f,@(x,t)u(x,t))
%[text] ![](text:image:90d9) **Reflect.**
%[text] 1. Why is this called a transport equation?  \
%%
%[text] ![](text:image:13d4) **Exercise 1.** Write down the solutions to the following PDEs.
%[text] a) $\\frac{\\partial \\phi}{\\partial t} + 3\\frac{\\partial \\phi}{\\partial x} = 0${"altText":"(∂ φ)\/(∂ t) + 3(∂ φ)\/(∂ x) = 0"} with $\\phi(x,0) = e^{-x^2+x}${"altText":"φ(x,0) = e^(-x^2+x)"}
syms x t
phi(x,t) =  exp(-x^2+x); %[control:editfield:4426]{"position":[12,24]}
CheckEx1(@(x,t)phi(x,t),"a",1,3,@(x)exp(-x^2+x))
%[text] b)  $\\frac{\\partial V}{\\partial t} - \\frac{5}{2}\\frac{\\partial V}{\\partial x} = 0${"altText":"(∂ V)\/(∂ t) - (5)\/(2)(∂ V)\/(∂ x) = 0"} with $V(x,0) = \\frac{\\sin(x)}{x^2+1}${"altText":"V(x,0) = (sin(x))\/(x^2+1)"}
syms x t
V(x,t) =  exp(-x^2+x); %[control:editfield:1b0e]{"position":[10,22]}
CheckEx1(@(x,t)V(x,t),"b",1,-5/2,@(x)sin(x)/(x^2+1))
%[text] c)  $2\\frac{\\partial q}{\\partial t} + \\frac{\\partial q}{\\partial x} = 0${"altText":"2(∂ q)\/(∂ t) + (∂ q)\/(∂ x) = 0"} with $q(x,0) = \\frac{\\pi^2}{4}-\\left(\\mathrm{ atan}(x)\\right)^2${"altText":"q(x,0) = (π^2)\/(4)-( atan(x))^2"}
syms x t
q(x,t) =  exp(-x^2+x); %[control:editfield:5980]{"position":[10,22]}
CheckEx1(@(x,t)q(x,t),"c",2,1,@(x)pi^2/4-(atan(x))^2)
  %[control:button:18b4]{"position":[1,2]}
%%
%[text] %[text:anchor:H_F6951A6F] ## Linear Transport Equation: Convection
%[text] Recall that a first-order linear wave equation, $\\frac{\\partial u}{\\partial t} + v \\frac{\\partial u}{\\partial x} = 0${"altText":"(∂ u)\/(∂ t) + v (∂ u)\/(∂ x) = 0"}, with constant $v${"altText":"v"} and initial condition $u(t\_0,x) = f(x)${"altText":"u(t\_0,x) = f(x)"} has solutions of the form $u(t,x) = f(x-v(t-t\_0))${"altText":"u(t,x) = f(x-v(t-t\_0))"}. This is called the *uniform transport equation* because the waveform given by the initial condition over all of space is uniformly transported at speed $v${"altText":"v"}.
%[text] ![](text:image:8c00) **Try**.  When does the method of characteristics solve the problem? Why does it fail? Note that the labels `aCoeff`, `bCoeff`, and `cCoeff` are related to the formulation in [Equation $(\\star)${"altText":"(star)"}](internal:M_C8296B97). In the example $\\frac{\\partial u}{\\partial t} + v \\frac{\\partial u}{\\partial x} = 0${"altText":"(∂ u)\/(∂ t) + v (∂ u)\/(∂ x) = 0"} we have `aCoeff=1`, `bCoeff=v`, and `cCoeff=0`.
%[text] - What happens if `bCoeff` is a positive constant? Or a negative constant?
%[text] - What happens if `bCoeff` is a function of $t${"altText":"t"}?
%[text] - What happens if `bCoeff` is a function of $x${"altText":"x"}?
%[text] - What happens if `bCoeff` is a function of $x${"altText":"x"} and $t${"altText":"t"}?
%[text] - What happens if you change the values of `aCoeff` or `cCoeff` or both? \
clear f s pt t x % Uninitialize the symbolic variables from the preceding section
syms t x c
aCoeff =  1; %[control:editfield:351b]{"position":[10,12]}
bCoeff = 1-c*t^2; %[control:editfield:658a]{"position":[10,17]}
cCoeff = 0; %[control:editfield:7607]{"position":[10,11]}
f(x) = piecewise(x<-1,0,(x>=-1) & (x<=0),1+x, (x>0) & (x<=1), 1-x, 0); %[control:dropdown:2b60]{"position":[8,70]}
t0 = 0;
  %[control:button:64ce]{"position":[1,2]}
[~,xEqn1,CharSoln1] = SolveCharacteristicEquation(t,x,f,aCoeff,bCoeff,cCoeff,t0,false);
%%
cValue = 3; %[control:slider:8d31]{"position":[10,11]}
  %[control:button:281f]{"position":[1,2]}
PlotCharacteristicCurves(t0,subs(xEqn1,c,cValue),-10:.2:10,f,xRange=[-2 3],...
    tRange=[-2 3],u=subs(CharSoln1,c,cValue),ShowColorbar=true)
%%
  %[control:button:278c]{"position":[1,2]}
PlotSolutionCurves([0 7],[-15 3],f,subs(CharSoln1,c,cValue))
%%
%[text] %[text:anchor:H_0FEC8625] ## Nonlinear Transport Equation
%[text] Consider a simple nonlinear, homogeneous partial differential wave equation:
%[text]{"align":"center"} $\\frac{\\partial u}{\\partial t} + u\\frac{\\partial u}{\\partial x} = 0${"altText":"(∂ u)\/(∂ t) + u(∂ u)\/(∂ x) = 0"}.
%[text] In the nonlinear example, however, the transport speed is not uniform but depends on the wave function itself in both space and time. The characteristic curve method does allow an approach to solving this equation, although it may be complicated to express the solution analytically. Remember that we assume the curves we are solving for are contour lines of the solution, so the value $u(X(s),T(s))=u(x\_0,t\_0)=u\_0${"altText":"u(X(s),T(s))=u(x\_0,t\_0)=u\_0"} along each curve. 
clear t x u
syms t x u 
a = 1;
b = u;
c = 0;
jumppoint = 0;
speed = 1.3;
f(x) = piecewise(x<-1,0,(x>=-1) & (x<=0),1+x, (x>0) & (x<=1), 1-x, 0); %[control:dropdown:1d96]{"position":[8,70]}
t0 = 0;
  %[control:button:953a]{"position":[1,2]}
[~,xEqn2,CharSoln2] = SolveCharacteristicEquation(t,x,f,a,b,c,t0,false);
%%
  %[control:button:81fe]{"position":[1,2]}
PlotCharacteristicCurves(t0,xEqn2,-10:.2:10,f,xRange=[-7 7],tRange=[-1 3],u=CharSoln2,ShowColorbar=true)
%%
  %[control:button:3a2a]{"position":[1,2]}
PlotSolutionCurves([0 10],[-30 20],f,CharSoln2,xLimRange=[-10 15],DependsOnU0=true,xStar=jumppoint)
%%
%[text] %[text:anchor:H_83FF8DFD] ## **Pathological Example**
%[text] Consider the simple first-order, linear, homogeneous 1-D partial differential equation
%[text]{"align":"center"} $\\frac{\\partial u}{\\partial t} + t(x^2+1)\\frac{\\partial u}{\\partial x}  = 0${"altText":"(∂ u)\/(∂ t) + t(x^2+1)(∂ u)\/(∂ x) = 0"}.
syms u(x,t) T(s) X(s) s t x x0 t0 f(y)
assume([t t0],"real")
assumeAlso(atan(x),"real")
%[text] First, observe that 
%[text]{"align":"center"} $\\frac{du}{ds} = 0 \\Rightarrow u(s) = u(s=0) = u\_0.${"altText":"(du)\/(ds) = 0 implies u(s) = u(s=0) = u\_0."}
%[text] We can also say that $t(s=0) = t\_0${"altText":"t(s=0) = t\_0"} and $x(s=0) = x\_0${"altText":"x(s=0) = x\_0"}. To fully solve this differential equation, we need to know the initial condition 
%[text]{"align":"center"} $u(x,t\_0)=f(x)${"altText":"u(x,t\_0)=f(x)"}, 
%[text] for some differentiable function $f${"altText":"f"}. Now, note that $u(x\_0,t\_0) = f(x\_0)${"altText":"u(x\_0,t\_0) = f(x\_0)"}.  We shall use $t=T(s)${"altText":"t=T(s)"} and $x=X(s)${"altText":"x=X(s)"} so the computer can track the parameterized version and the original variable.
  %[control:button:0f58]{"position":[1,2]}
dtds = diff(T,s)==1;
tEqn = t == dsolve(dtds,T(0)==t0);
displayFormula("tEqn")
dxds = diff(X,s)==T*(X^2+1);
xEqn = x == dsolve(dxds,X(0)==x0);
displayFormula("xEqn")
%[text] Substituting in the known formula for $t${"altText":"t"}, this becomes: 
xEqn2 = subs(xEqn,T,rhs(tEqn));
xEqn3 = subs(xEqn2,s,t-t0);
displayFormula("xEqn3")
CharCurve = solve(xEqn3,x0,"ReturnConditions",true);
displayFormula("x0 == CharCurve.x0")
displayFormula("CharCurve.conditions") 
%[text] By paying attention to the assumption that $k${"altText":"k"} must be an integer, we can simplify this further:
syms k
assumeAlso(k,"integer")
CharSoln2 = simplify(u(x,t) == f(CharCurve.x0))
%[text] Observe that if we check the result we get when $t=t\_0${"altText":"t=t\_0"} we get back to:
CheckingResult = subs(CharSoln2,t,t0);
displayFormula("CheckingResult")
f(y) = exp(-y^2); %[control:dropdown:22c7]{"position":[8,17]}
u(x,t) = simplify(f(subs(CharCurve.x0,t0,0)))
%%
  %[control:button:18f0]{"position":[1,2]}
trange = 0:0.01:3;
tMaxVal = max(trange);
xinit = -10:0.2:3;
xMaxVal = max(xinit);
xMinVal = min(xinit);
xFun(t,x0) = rhs(subs(xEqn3,t0,0))
[T,X] = meshgrid(trange,xinit);
xVals = double(xFun(T,X));

xVals(xVals>5*abs(xMaxVal)) = NaN;
xVals(xVals<-5*abs(xMinVal)) = NaN;
plot(trange,xVals,SeriesIndex="none");
xlim([0 tMaxVal])
ylim([xMinVal xMaxVal])
xlabel("t")
ylabel("x")
title("Characteristic curves of $\frac{\partial u}{\partial t} + t(x^2+1)\frac{\partial u}{\partial x}  = 0$",Interpreter="latex")
%%
%[text] We can trace the values of our solution through time and space:
[uMin,uMax] = PlotInitialData(xMinVal,xMaxVal,800,f);
%%
fig = figure;
MyColors = turbo(8);
scatter(zeros(size(xinit)),xinit,40,ChooseColor(double(u(xinit,0)),uMax,uMin,MyColors),"filled")
xlim([0 tMaxVal])
ylim([xMinVal xMaxVal])
pt = gobjects(size(xinit));
hold on
ContourColors = fig.Children.Children(end).CData;
    for xIdx = 1:length(xinit)
        pt(xIdx) = plot(trange(1),xinit(xIdx),Color=ChooseColor(double(u(xinit(xIdx),0)),uMax,uMin,MyColors));
    end
    for tIdx = 2:length(trange)
        for xIdx = 1:length(xinit)
            if ~any(isnan(xVals(xIdx,1:tIdx)))
                pt(xIdx).XData = trange(1:tIdx);
                pt(xIdx).YData = xVals(xIdx,1:tIdx);
            end
        end
        drawnow
    end
hold off
%[text] Observe that even when we have perfect information about these PDEs at $t=0${"altText":"t=0"}, by a finite time, all of the initial information has diverged infinitely far away, and the values in the local spatial region are entirely unknown. 
%%
%[text] %[text:anchor:H_32C26CBB] ## Further Explorations
%[text] The following courseware module explores applying the method of characteristics to model traffic.
if false %[control:statebutton:75bc]{"position":[4,9]}
    edit("TrafficModel.m")
end
%%
%[text] The built-in tsunami model is an example in the MATLAB® documentation that presents using the Symbolic Math Toolbox™ to visualize the results of a PDE. 
if false %[control:statebutton:44d9]{"position":[4,9]}
openExample('symbolic/TsunamiExample')
end
%%
%[text] [⇦ Return to the main menu](file:MainMenu.m)
%%
%[text] ## Help us Improve
%[text] [Share your feedback](<matlab: ShareFeedback>) to help us improve this module.
%%
%[text] %[text:anchor:H_CCD996D7] ## Local Helper Functions
%[text] If you want to see the details of the code, select the **View** tab and switch to **Output Inline**. Alternately, select **Output inline** using the icon ![live script output inline icon](text:image:28c4) at the top right of the Live Editor pane.


function [tEqn,xEqn3,CharSoln] = SolveCharacteristicEquation(t,x,f,a,b,c,t0,ShowConditions)
%[text] `SolveCharacteristicEquation(t,x,f,a,b,c,t0,ShowConditions)` solves equations of the form
%[text] $a(t,x,u)\\frac{\\partial u}{\\partial t} + b(t,x,u)\\frac{\\partial u}{\\partial x} - c(t,x,u) = 0${"altText":"a(t,x,u)(∂ u)\/(∂ t) + b(t,x,u)(∂ u)\/(∂ x) - c(t,x,u) = 0"}.             $(\\star)${"altText":"(star)"}
%[text] $u(x,t\_0) = f(x)${"altText":"u(x,t\_0) = f(x)"}

if class(b)=="sym"
    syms t x u T(s) X(s) u0
    B = subs(b,[t x u],[T X u0]);
else
    B = b;
end

if class(a)=="sym"
    syms t x u T(s) X(s) u0
    A = subs(a,[t x u],[T X u0]);
else
        A = a;
   
end

if class(c)=="sym"
    syms t x u T(s) X(s) u0
    C = subs(c,[t x u],[T X u0]);
else
        C = c;
end

syms u(x,t) uSol(x,t,u0) T(s) X(s) U(s) s t x x0 u0 F(x)
F(x) = f;
displayFormula("'The partial differential equation is:'")
displayFormula("a*diff(u,t)+b*diff(u,x)+c == 0")
displayFormula(["'with initial data: '" "u(x,t0)==F"])

displayFormula(["'By choosing '" "s" "' to represent the parametric variable, we can write: '" ...
    "U(s) == u(x,t)"  "', and '" "T(s) == t" "', and '" "X(s) == x" "'.'"])

assume([t t0],"real")
duds = diff(U,s) == -C;
UEqn = u == dsolve(duds,U(0)==u0);
displayFormula(["'By solving '" "duds" "' with '" "U(0)==u0" "' we see that: '" "UEqn" "'.'"])
dtds = diff(T,s)==A;
tEqn = t == dsolve(dtds,T(0)==t0);
displayFormula(["'By solving '" "dtds" "' with '" "T(0)==t0" "' we calculate that '" "tEqn" "','"])
dxds = diff(X,s)==B;
xEqn = x == dsolve(dxds,X(0)==x0);
% displayFormula("xEqn")
xEqn2 = subs(xEqn,T,rhs(tEqn));
xEqn3 = subs(xEqn2,s,t-t0);
displayFormula(["'and by solving '" "dxds" "' with '" "X(0)==x0" "' we calculate that '" "xEqn3" "'.'"])
CharCurve = solve(xEqn3,x0,"ReturnConditions",true);
displayFormula(["'Therefore, the characteristic value is '"  "x0 == CharCurve.x0"  "','"])
if ShowConditions
    displayFormula("CharCurve.conditions")
end
sEqn = solve(tEqn,s);
CharSoln(x,t,u0) = simplify(subs(F(subs(CharCurve.x0,t0,0))+subs(rhs(UEqn)-u0,[T X],[rhs(tEqn) rhs(xEqn3)]),s,sEqn));
displayFormula(["'and the solution is '" ; "u(x,t) == CharSoln" ])

end

function [uMin,uMax] = PlotInitialData(xMinVal,xMaxVal,n,f)
%[text] `PlotInitialData(xMinVal,xMaxVal,n,f)` plots the initial condition `f` over the domain from `(xMinVal,xMaxVal)` with `n` points.
x0Vals = linspace(xMinVal,xMaxVal,n);
U0Vals = double(f(x0Vals));
plot(x0Vals,U0Vals)
title("The initial data")
xlabel("$x$",Interpreter="latex")
ylabel("$u(x,t_0)$",Interpreter="latex")
[uMin,uMax] = bounds(U0Vals,"all");
end

function MyColor = ChooseColor(u0,uMax,uMin,cmap)
%[text] `ChooseColor` is a helper function for plotting the characteristic curves in color.
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

function PlotCharacteristicCurves(tinit,xEqn,xinit,f,opts)
%[text] `PlotCharacteristicCurves(tinit,xEqn,xinit,f,opts)` is a function that uses the solutions generated by `SolveCharacteristicEquation` to visualize the characteristic plot for the chosen PDE. The optional arguments are `tRange, xRange, u,` and `MyColors`.
arguments
    tinit (1,1) double 
    xEqn sym
    xinit (1,:) double
    f sym
    opts.tRange (1,2) double = [0 10]
    opts.xRange (1,2) double = [min(xinit) max(xinit)]
    opts.u = 1
    opts.MyColors = turbo(8)
    opts.ShowColorbar logical = false
end

if tinit <= opts.tRange(1)
    tVals = linspace(tinit,opts.tRange(2),100);
elseif tinit >= opts.tRange(2)
  tVals = linspace(tinit,opts.tRange(1),100);
else
    n1 = round(100*(opts.tRange(2)-tinit)/range(opts.tRange));
    tVals = [linspace(tinit,opts.tRange(2),n1) nan linspace(tinit,opts.tRange(1),100-n1)];
end

if class(opts.u)=="double" && opts.u == 1
    u0Vals = ones(size(xinit));
else
    u0Vals = double(opts.u(xinit,tinit,f(xinit)));
end
    [uMin,uMax] = bounds(u0Vals,"all");

syms x0 u0 t t0
xFun(x0,u0,t) = subs(rhs(xEqn),t0,tinit);
[T,X0] = meshgrid(tVals,xinit);
[~,U0] = meshgrid(tVals,u0Vals);

xVals = double(xFun(X0,U0,T));

if any(abs(xVals(:,1)-xinit(:))>1e-4)
warning("The initial values of xinit do not match the first column of x values.")
end

scatter(tinit*ones(size(xinit)),xinit,40,ChooseColor(u0Vals,uMax,uMin,opts.MyColors),"filled");
if opts.ShowColorbar
    colormap(opts.MyColors)
    [NumColors,~] = size(opts.MyColors);
    colorbar("Ticks",linspace(0,1,NumColors),"TickLabels",string(linspace(uMin,uMax,NumColors)))
end
xlabel("t")
ylabel("x")
title("Plot of the characteristic curves")
xlim(opts.tRange)
ylim(opts.xRange)
pt = gobjects(size(xinit));
hold on
for xIdx = 1:length(xinit)
    pt(xIdx) = plot(tVals(1),xinit(xIdx),Color=ChooseColor(u0Vals(xIdx),uMax,uMin,opts.MyColors));
end
for tIdx = 2:length(tVals)
    for xIdx = 1:length(xinit)
%        if ~any(isnan(xVals(xIdx,1:tIdx)))
            pt(xIdx).XData = tVals(1:tIdx);
            pt(xIdx).YData = xVals(xIdx,1:tIdx);
%        end
    end
    drawnow limitrate
end
hold off
end

function PlotSolutionCurves(tRange,xRange,f,u,opts)
%[text] `PlotSolutionCurves(tRange,xRange,f,u,opts)` plots the animated solution curves to visualize the results in both time and space. Optional arguments are `xLimRange`, `xStar`, and a `DependsOnU0` flag. 
arguments
    tRange 
    xRange 
    f 
    u 
    opts.xLimRange = xRange
    opts.DependsOnU0 = false
    opts.xStar = nan
end
figure
syms t x x0 u0
if opts.DependsOnU0 == true
    tStar = 0;
    if isnan(opts.xStar)
        xStar = 0;
    else
        xStar = opts.xStar;
    end
end
xInit = linspace(xRange(1),xRange(2),150);
tVals = linspace(tRange(1),tRange(2),200);
if opts.DependsOnU0
    xStarIdx = find(xInit>= xStar,1);
    xInit = [xInit(1:xStarIdx-1) nan nan xInit(xStarIdx:end)];
end
uInit = double(f(xInit));
% uF(x,t) = u(x,t,uInit);
% [X,T] = meshgrid(xInit,tVals);
try
    uFun(t) = u(xInit,t,uInit);
catch
    uFun(t) = u(xInit,t);
end

p = plot(xInit,uInit);
xlabel("x")
ylabel("u(x,t)")
title("Plot of the solution in space and time")
subtitle("$t = $" + tVals(1),Interpreter="latex")
ax = gca;
[yMin,yMax] = bounds(p.YData);
yRange = yMax-yMin;
ylim([yMin-0.5*yRange yMax+0.5*yRange])
xlim(opts.xLimRange)
for tStep = 2:length(tVals)
    if opts.DependsOnU0
        p.XData = xInit+uInit*tVals(tStep);
    else
        p.YData = double(uFun(tVals(tStep)));
    end
    ax.Subtitle.String = "$t = $" + tVals(tStep);
    drawnow
end
end

function CheckEx1(u,question,a,b,f)
%[text] a) $\\frac{\\partial \\phi}{\\partial t} + 3\\frac{\\partial \\phi}{\\partial x} = 0${"altText":"(∂ φ)\/(∂ t) + 3(∂ φ)\/(∂ x) = 0"} with $\\phi(x,0) = e^{-x^2+x}${"altText":"φ(x,0) = e^(-x^2+x)"}
%[text] b)  $\\frac{\\partial V}{\\partial t} - \\frac{5}{2}\\frac{\\partial V}{\\partial x} = 0${"altText":"(∂ V)\/(∂ t) - (5)\/(2)(∂ V)\/(∂ x) = 0"} with $V(x,0) = \\frac{\\sin(x)}{x^2+1}${"altText":"V(x,0) = (sin(x))\/(x^2+1)"}
%[text] c)  $2\\frac{\\partial q}{\\partial t} + \\frac{\\partial q}{\\partial x} = 0${"altText":"2(∂ q)\/(∂ t) + (∂ q)\/(∂ x) = 0"} with $q(x,0) = \\frac{\\pi^2}{4}-\\left(\\mathrm{ atan}(x)\\right)^2${"altText":"q(x,0) = (π^2)\/(4)-( atan(x))^2"}
arguments
    u % function handle
    question (1,1) string {mustBeMember(question,["a" "b" "c"])}
    a (1,1) double {mustBeNonzero}
    b (1,1) double
    f % function handle
end
syms x t

speed = b/a;
x0(x,t) = x-speed*t;
uSoln(x,t) = f(x0(x,t));

if isAlways(u(x,t)==f(x),"Unknown","false")
    disp("This is the initial condition, not the solution to the PDE. Please try the problem.")
elseif isAlways(u(x,t)==uSoln(x,t),"Unknown","false")
    disp("Part " + question + " is correct.")
else
    disp("Part " + question + " is incorrect. Please try again.")
end

end

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"hidecode","rightPanelPercent":40}
%---
%[text:image:1bf1]
%   data: {"align":"middle","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAjElEQVR42mP4\/\/8\/AwgnJiYapKamfgfS\/ynBUDMMYOYywBggiYcPH\/6nFIDMAJmFYQHIdmoBqFm4LZjrYPd\/gpoyGIPYVLeA5j6gmwUlJaVAxUlgDGKPBhFODaQG1QgIoqKtr\/6r99wlCYP0EG0BSMOWe\/9JwiA9oxaMWkBHC2ieD2iSk+lR6dOk2QIAjF+EgB\/BqfoAAAAASUVORK5CYII=","width":24}
%---
%[text:image:02ff]
%   data: {"align":"middle","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAArElEQVR42mP4\/\/8\/AwgnJiYapKamfgfS\/ynBUDMMYOYywBggiYcPH\/6nFIDMAJmFYQHIdmoBqFm4LZjrYPd\/gpoyGIPYVLeA5j4gbEASHJNlwZYtW\/93dHTixDCDQTRMDKRn8FhATBDNmTOH\/CAiBI4cOQI2HETTLBW9fv2a\/FRUtPXVf\/WeuyRhkB6iLQBp2HLvP0kYpGfUglELhpMFNM9oNKlw6FHp06TZAgAoeVix9Bg9oQAAAABJRU5ErkJggg==","width":24}
%---
%[text:image:7e11]
%   data: {"align":"baseline","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAsCAYAAAAXb\/p7AAADlklEQVR42u1YS0hUYRQejR4UvR+SvaCyWiS2DIoCKWjVYzG2SsYWQ+a8HRwXFkOgqdGLSoSeqyBaJUGLCKGkNpGtgiyScnpYBpaU5au+E+eH03Wu93rvP2OEFw46955z\/u8\/7\/\/3eDQ+4XD4Eui65199AK4d1DEJcBLgfw0wGo2ujkQi1yoqKlY5AFgDqnWw5lpaMxaLrbBkDgaDm7HIEKjTCcjxPqFQqABrdYEGsHaRXaESCAyCXpNFMwwuReDw\/77xusurQGJna0ysPR2K94CnGdQKesnUyu92J5PJaelk4c51Chzcu9dp0O9nkO3yvd\/vnwqlEbzvAf2yoB5sIkwyBt0doJ+0Qbdu2AXyC8UrOVuNQH5Q3IJegfrTfH8ikwC\/A9hjsdaYCQQCG6D4vVj0DShB7+HKXMGaQ\/EFADEGrPhJdn1GAhoZvRDKX4jFTvt8vhlWchSD4D0OGiE5AH9eXl4+PxNF+IoCB8sccyBfreQB8qJWcAC0CYqHeYE2cqEDNTmQvcc6hlC+CnXWq\/PCtTtdeGGr0HNWFz7aeTcr\/eT1eqe41PVWJYxd62zkovwXqQ6Cv8vErm9r8MZNEctLVf9Ph4GwecSOjPSQu8V28e6chmRrFPq28btHJhhSBKDIBH0B726HEDilAWCtsGCx6MmjMNgaHqBkiygPl3UmHE1OrjOEiqoqsqDHGizYxrqGAXCOriL9jJUOoq3lO9UDQItpQGD3PtXZRapFHB51oSchwiWsDWA8Hl8Cpb2svA+WWO4AXJ7Q0Z1IJObq7sUBN\/UQLr0hrHfANSCaQihrobiBf+dC+QOxSNk4MrdEyN1VvRy6T+DdVbOp2wpcCyutN8yDahjtVZ3A4sS2ALwflYxhaK1n0C22QfL8dkuNRYZBlKxxRLj6gg3XNgj+w8beLOriHcv50gocJ8wsfP\/ASgfMDlRs8XzwfGPeThMr2QcpEqFprJmPSoSwSvMYfCcFX6nFlNPEfAGrUuC1GkhxQpspTnTfKysrFxl5qqqqZouy0mU81ZmApB6cp2vKlrFVk+Z7TGRuPOsXRZSNfGYmEO\/ofoXmOiKKS3Ga6wPYeRNxk9Vo49BONAIL1mUdIBa9bxPgn+zMOkAqIXDdQbp1sKAy6uWeyWd0Cyuk5LDh3pTtez\/NSVJqNwbh5kNZB8htkTrP1zHA9dM1nZ07nExmc50ZQGA7M+GxyLden9MA\/OLm\/KKe34xPoKAD7jPkAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:0418]
%   data: {"align":"baseline","height":23,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADoAAAA6CAYAAADhu0ooAAAEp0lEQVR42t2a208TQRTG67OJxvv9fiGoD6LGgPiCGo1G\/wljTKDl1pL00RuKIKCIIiKg6ItB8IJ38K4Panz13RcfSBBBQQHRek4ys\/kYpu1uu2132+Sku6eb6X7zmzlz5ux6PEn6lJaWbi0uLu4mGyLrJWvMz8+f4UmnjxA5QhZS7HNZWdnUdNE5hQR9EsLGioqKWuj7kRRbUlJSmS40D4Co4yD+rfAPEdW5rhdKQj4KQQM4J0n0DhjCVW4XuR9oHlV\/J98rSZVsnmuF0nz8oNIsLCxcFQwGp4vf86AjzrhV5D4dTTq+Tr8d0VD95fP5Frpx2L4XAgYlTQpMq+n8DxKm4+0wV6tdJZIo7YWbPwbi26QfqdL5S+H\/7SqqdMPvJE2iOFPOTUEzpM5bpEodUOMWkXs06yb7r6qZEc5dOn\/hKqqQCESiOYkqic4Ff62jRZKg3XCzJ0B8q0akjupzSZU6aZGTl5Q34kZ\/BgKB2ezzer3LOMcNJ5SpSvJIlY7POTWn3QUBpRzEt0QQqYvMzxxNlW7staRJQ3gO0Bw1IdSYz9Qx28Bf57QhuxNu7iSIbzYhclKEpvZ6HElVR5OOl5qkGZEqdcB5p9DMC0OzyYJIXaTuFr4R6rzFTkj3jK1WHDRDarSmdnPAX59qkbkQaU+B\/7IqglM7+g4qVqu5rhzaeeoIqpC2RaVJN52pGfYbdFRlW0iVrr2QcppkFSC+MUxUNSt0AlU6f5JSqpCuGcUtv9+\/JExZ05JQpErf2eC\/mOxIi4v6aRDfEGGdtCJUjeCPhW+Uk5BkCu2xQjNGoQZVWl+30Pk\/4W9I1tzM0RWfeVhFyXysCp0QyaHoPUZtLU\/G3OxWadIfL+Dilt1CMZrTtZuB6qVE7zezdUVnDv0mctlYhKpUHyaFKoR6SzTjEYr\/pVBtTDhNLDZz0m1ydxKrUHWdfiCp+ny+FYmgKUP8sHx8YJamDUK1VDnVtHs5wSFTDeLrLOw34xGqrtf3E0IVgoBRiiwoKJhvlqZNQjEubIKOb7Jr3TQaxeIyF6+sbMFsEKqu2\/ZShQZVmsPJFhqOKrVzxTaaWFTW7SNNCD3IlUI08h2KYXOO63eXpErtrYwnCHWpNDniWqVpsxlUacnLAhDNsa6bWTqaolIQSrFVwei6FxdVGlZ3baY5SNav2KCdVLlYblXkRqB5FnqvOlYKNgWjUJjsTEIZpzbXWIm0d9QCMlfneI\/oFKFKhoZgWs0GIP7zv+qDHu7BeOZVAoSqWZqEM+73+9eaodlpN80ECjXiBwLih87Rnoith4vrgGZlvJEyQUJVqrdNUaULOmRp0U6a8uUMssNo\/BDYBqHDnKlppt21qDTxwQ7vGhywbkbrxBrN1Bsny9DRbFcLxV6vdxad\/3C6UJyryvRrU7OgdfBjPYivcIHIkCYX79BSpZObLqYZkSq\/kicjaqZ04oMcrpS7SGRIzeJIy60JVDk6SZpcbRdDeRr5v2hyU6fbV\/l8VVlXm5lcX0wJsTveYpMVw14PzMOGNBQqE4h+3M8x5hti3UwH64S52y6D0YALA49Z6+P3hCXiDLH2fEsjgd+ZKr9wyRr\/A+UKAPezYlA8AAAAAElFTkSuQmCC","width":23}
%---
%[text:image:1517]
%   data: {"align":"baseline","height":26,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAApCAYAAAAiT5m3AAADOElEQVR42r1XSWgUQRSNGndR3Ii7V\/EmCCp4DaIe1Oh4EMHBwMjsq47Eg+OOJ0VIICAeFAIeXEADHgyoqChE1ASNhISAxH0jg5gxq+\/FX1A009PTM93T8OiuX7\/q1f+\/+tevqqoCTyKRWBmNRo8Cj4GPwF++I5HII7zT8Xh8eZWTTzgcnh6Lxc5j8kFgHMgCT4G7wBPgl8j\/YBGnfT7f1LJJg8HgQrGQE3diAXVciK5DIsi3o7+devh+4Pf755dMmslkpmGih0LaiHa1hf5k6J0T\/TYrfdMHKz8pFjTr1kFWD9ltvJ8Bt\/Dt1d0rYeG4Y7ZJMbAG+A300HLKuHkw2SuxKAe8lQ3Gdjv6llLP4\/FMQfs1MMBQ2SUOyaoPihur0X4BDGEDHVGLYbwhawCG6QG6W6yu43jo+uwSt3IyWLlA2vt09+F7CwlDodAaaZ+Q\/j3inZn0GENil\/gd0Ke1rwEjgUBgDqzYIe4lBiBbkkqlZov7r2hjXtLldom\/0LVa+x7QK9+NGjHduUvkfcAdbUwb0G+XuNtg8WV6QeLXbCDeKzo9QJM2phPosEt8ExijG9nG5NuKJK6VTTeXrofudbvEh2TS49r\/eakQMeQXNV2v9Nfbzc9c8U\/GWv2LKkmYEat+r9c7Q+L9nZvOdhLBhOF86c+MWJ5JkLVIX6jUdM1Jbsgk3NU1RRBPHCzQ2crxZR0U3CBC8saKGO3NCNNGx85kpk4QPLfaXJr8jGPkKs4FfqesJv9kcP1OvFeXa70Z8Ygmz1KWTCYX4fuDqlAQhnUVIWafQfesXjjgF5zlCrGWSBQuyOm1nuEARqGTqRgxKxejrm1iYL+URKPFEktJrGSDpRJ3aYlGYRhFwjK8T+lyle+1yrUsYjMM5ZG9l0tBzk3iYvGfWE6XVWYniyvEci1RgjEpZwP6Itwi7jfppHy31Mz3HSeGNZvw8aOAUs5h0olUqqqPFVIhjlcI34wXsMMuWWhEb76ibwPw1U1ibmCzwm+tdil3HEyfhcrdBhetbrW6pHe5RNxiVeTXukTcVEyevupCjA9YEqfT6XlyGXOKuINnQ1GnEy9y6uJeBuFn3qXxxyzmnP8Amz0wy7TM4YgAAAAASUVORK5CYII=","width":19}
%---
%[text:image:447c]
%   data: {"align":"baseline","height":20,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADUAAAAxCAYAAAB6d+FmAAAC0ElEQVR42u2aO4gTURSGs6Lugo1WW2ghgiyCr1VWbRSR9YEgKoKohcQmEDAviYhBIaVbbKEWYi22YidoobUItoqwjSui6wt119Wsj+\/onXAcJslMZpI7AxP4Sbh37pnz3TP3zJ2TyWQS9imVStvRK1G5XL5ZqVRWZpL8MUCf0G+lz+hYIoGIyDYPIEc\/i8ViLmkRGkMfWwA5WkD7EwHEutmCs+87ADl6zfHLm4MLhcIqGs7RcV0WoA1xCa3vIkL\/CTsX\/w7G2Bka5oIMjlo4M6GBmOTRABHSeirh3S0LzSYQugHHgAPEJG+l7UOXtr6LgQeqYQZdRVf6Jc5frdfriyKIkOgHQToi1+0XpxGD+ywnhc348a5bICboqLMYmx02784hgRYAOqEzjHWoSIHiABU5kG2osECMP9lqC2IFiqS0qSdAtqAM0Ey3QOhUp81iX6F6DtRvKM6xsedA\/YQKCdQgyx0PcrKeQ4WNkE4K+LhGb6usQOHQOnnOCb31+WdrNW1TQC22BoW9Ddh9i6bRfNDdNkCH1c59LW0vpc8qFDYfo\/tkvMFqtbqM3xdkffgAmseXQ44dM3ba6bcGlc1mh9yzbaK3k\/Y37YAYc9Dl47A+xhoU0dlh7A579I3qRx6lbwAd8PAxHlA4V5BF3ea8Z11Ac62e52IDhb1bZuZL+lFdRWtQpflZzj3exlZsIvVc2b7jdW8xiWSWVL2ng4\/2ofL5\/Ars\/XJdXudN9wC\/R4Ce5PurFH58RN0+FLb2et130D1VVJlCu3zasw9FFC67dwboialUnZadQcBJsg+F09ewd9tkwLFcLrckZOTjkSgi3pmkUClUCpVCpVApVAqVQqVQ0UDp6s5IHKFMeaz5doufYuYz9bf\/XXmXQaqgcZH4I34pqBd+Qluz\/LpBUF3qCEUol3LgwyQAEbFHUrDxW6OTyk7NFEsaMYNpGL9qfoH+AOOEPfJuI6OmAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:754f]
%   data: {"align":"baseline","height":26,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAApCAYAAAAiT5m3AAADOElEQVR42r1XSWgUQRSNGndR3Ii7V\/EmCCp4DaIe1Oh4EMHBwMjsq47Eg+OOJ0VIICAeFAIeXEADHgyoqChE1ASNhISAxH0jg5gxq+\/FX1A009PTM93T8OiuX7\/q1f+\/+tevqqoCTyKRWBmNRo8Cj4GPwF++I5HII7zT8Xh8eZWTTzgcnh6Lxc5j8kFgHMgCT4G7wBPgl8j\/YBGnfT7f1LJJg8HgQrGQE3diAXVciK5DIsi3o7+devh+4Pf755dMmslkpmGih0LaiHa1hf5k6J0T\/TYrfdMHKz8pFjTr1kFWD9ltvJ8Bt\/Dt1d0rYeG4Y7ZJMbAG+A300HLKuHkw2SuxKAe8lQ3Gdjv6llLP4\/FMQfs1MMBQ2SUOyaoPihur0X4BDGEDHVGLYbwhawCG6QG6W6yu43jo+uwSt3IyWLlA2vt09+F7CwlDodAaaZ+Q\/j3inZn0GENil\/gd0Ke1rwEjgUBgDqzYIe4lBiBbkkqlZov7r2hjXtLldom\/0LVa+x7QK9+NGjHduUvkfcAdbUwb0G+XuNtg8WV6QeLXbCDeKzo9QJM2phPosEt8ExijG9nG5NuKJK6VTTeXrofudbvEh2TS49r\/eakQMeQXNV2v9Nfbzc9c8U\/GWv2LKkmYEat+r9c7Q+L9nZvOdhLBhOF86c+MWJ5JkLVIX6jUdM1Jbsgk3NU1RRBPHCzQ2crxZR0U3CBC8saKGO3NCNNGx85kpk4QPLfaXJr8jGPkKs4FfqesJv9kcP1OvFeXa70Z8Ygmz1KWTCYX4fuDqlAQhnUVIWafQfesXjjgF5zlCrGWSBQuyOm1nuEARqGTqRgxKxejrm1iYL+URKPFEktJrGSDpRJ3aYlGYRhFwjK8T+lyle+1yrUsYjMM5ZG9l0tBzk3iYvGfWE6XVWYniyvEci1RgjEpZwP6Itwi7jfppHy31Mz3HSeGNZvw8aOAUs5h0olUqqqPFVIhjlcI34wXsMMuWWhEb76ibwPw1U1ibmCzwm+tdil3HEyfhcrdBhetbrW6pHe5RNxiVeTXukTcVEyevupCjA9YEqfT6XlyGXOKuINnQ1GnEy9y6uJeBuFn3qXxxyzmnP8Amz0wy7TM4YgAAAAASUVORK5CYII=","width":19}
%---
%[text:image:9a3f]
%   data: {"align":"baseline","height":20,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADUAAAAxCAYAAAB6d+FmAAAC0ElEQVR42u2aO4gTURSGs6Lugo1WW2ghgiyCr1VWbRSR9YEgKoKohcQmEDAviYhBIaVbbKEWYi22YidoobUItoqwjSui6wt119Wsj+\/onXAcJslMZpI7AxP4Sbh37pnz3TP3zJ2TyWQS9imVStvRK1G5XL5ZqVRWZpL8MUCf0G+lz+hYIoGIyDYPIEc\/i8ViLmkRGkMfWwA5WkD7EwHEutmCs+87ADl6zfHLm4MLhcIqGs7RcV0WoA1xCa3vIkL\/CTsX\/w7G2Bka5oIMjlo4M6GBmOTRABHSeirh3S0LzSYQugHHgAPEJG+l7UOXtr6LgQeqYQZdRVf6Jc5frdfriyKIkOgHQToi1+0XpxGD+ywnhc348a5bICboqLMYmx02784hgRYAOqEzjHWoSIHiABU5kG2osECMP9lqC2IFiqS0qSdAtqAM0Ey3QOhUp81iX6F6DtRvKM6xsedA\/YQKCdQgyx0PcrKeQ4WNkE4K+LhGb6usQOHQOnnOCb31+WdrNW1TQC22BoW9Ddh9i6bRfNDdNkCH1c59LW0vpc8qFDYfo\/tkvMFqtbqM3xdkffgAmseXQ44dM3ba6bcGlc1mh9yzbaK3k\/Y37YAYc9Dl47A+xhoU0dlh7A579I3qRx6lbwAd8PAxHlA4V5BF3ea8Z11Ac62e52IDhb1bZuZL+lFdRWtQpflZzj3exlZsIvVc2b7jdW8xiWSWVL2ng4\/2ofL5\/Ars\/XJdXudN9wC\/R4Ce5PurFH58RN0+FLb2et130D1VVJlCu3zasw9FFC67dwboialUnZadQcBJsg+F09ewd9tkwLFcLrckZOTjkSgi3pmkUClUCpVCpVApVAqVQqVQ0UDp6s5IHKFMeaz5doufYuYz9bf\/XXmXQaqgcZH4I34pqBd+Qluz\/LpBUF3qCEUol3LgwyQAEbFHUrDxW6OTyk7NFEsaMYNpGL9qfoH+AOOEPfJuI6OmAAAAAElFTkSuQmCC","width":22}
%---
%[control:button:48e5]
%   data: {"label":"Display the PDE","run":"Section"}
%---
%[control:button:50c9]
%   data: {"label":"Compute the characteristic curves and simplify","run":"SectionAndStaleSectionsAbove"}
%---
%[control:button:75eb]
%   data: {"label":"Write down the solution","run":"SectionAndStaleSectionsAbove"}
%---
%[control:button:6c2c]
%   data: {"label":"Check the solution","run":"SectionAndStaleSectionsAbove"}
%---
%[control:dropdown:381e]
%   data: {"defaultValue":"exp(-y^2)","itemLabels":["exp(-y^2)","pi\/2-abs(y)","3*sin(6*y)+cos(2*y)"],"items":["exp(-y^2)","pi\/2-abs(y)","3*sin(6*y)+cos(2*y)"],"label":"Initial condition: f(y) = ","run":"SectionAndStaleSectionsAbove"}
%---
%[control:button:1ee8]
%   data: {"label":"Set an initial condition","run":"SectionAndStaleSectionsAbove"}
%---
%[control:button:1757]
%   data: {"label":"Plot the characteristic curves","run":"SectionAndStaleSectionsAbove"}
%---
%[control:button:97e3]
%   data: {"label":"Plot the initial condition","run":"SectionAndStaleSectionsAbove"}
%---
%[control:button:2060]
%   data: {"label":"Plot the solution along characteristic curves","run":"SectionAndStaleSectionsAbove"}
%---
%[control:button:3c7d]
%   data: {"label":"Animate the solution","run":"SectionAndStaleSectionsAbove"}
%---
%[text:image:90d9]
%   data: {"align":"bottom","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAsCAYAAAAXb\/p7AAADlklEQVR42u1YS0hUYRQejR4UvR+SvaCyWiS2DIoCKWjVYzG2SsYWQ+a8HRwXFkOgqdGLSoSeqyBaJUGLCKGkNpGtgiyScnpYBpaU5au+E+eH03Wu93rvP2OEFw46955z\/u8\/7\/\/3eDQ+4XD4Eui65199AK4d1DEJcBLgfw0wGo2ujkQi1yoqKlY5AFgDqnWw5lpaMxaLrbBkDgaDm7HIEKjTCcjxPqFQqABrdYEGsHaRXaESCAyCXpNFMwwuReDw\/77xusurQGJna0ysPR2K94CnGdQKesnUyu92J5PJaelk4c51Chzcu9dp0O9nkO3yvd\/vnwqlEbzvAf2yoB5sIkwyBt0doJ+0Qbdu2AXyC8UrOVuNQH5Q3IJegfrTfH8ikwC\/A9hjsdaYCQQCG6D4vVj0DShB7+HKXMGaQ\/EFADEGrPhJdn1GAhoZvRDKX4jFTvt8vhlWchSD4D0OGiE5AH9eXl4+PxNF+IoCB8sccyBfreQB8qJWcAC0CYqHeYE2cqEDNTmQvcc6hlC+CnXWq\/PCtTtdeGGr0HNWFz7aeTcr\/eT1eqe41PVWJYxd62zkovwXqQ6Cv8vErm9r8MZNEctLVf9Ph4GwecSOjPSQu8V28e6chmRrFPq28btHJhhSBKDIBH0B726HEDilAWCtsGCx6MmjMNgaHqBkiygPl3UmHE1OrjOEiqoqsqDHGizYxrqGAXCOriL9jJUOoq3lO9UDQItpQGD3PtXZRapFHB51oSchwiWsDWA8Hl8Cpb2svA+WWO4AXJ7Q0Z1IJObq7sUBN\/UQLr0hrHfANSCaQihrobiBf+dC+QOxSNk4MrdEyN1VvRy6T+DdVbOp2wpcCyutN8yDahjtVZ3A4sS2ALwflYxhaK1n0C22QfL8dkuNRYZBlKxxRLj6gg3XNgj+w8beLOriHcv50gocJ8wsfP\/ASgfMDlRs8XzwfGPeThMr2QcpEqFprJmPSoSwSvMYfCcFX6nFlNPEfAGrUuC1GkhxQpspTnTfKysrFxl5qqqqZouy0mU81ZmApB6cp2vKlrFVk+Z7TGRuPOsXRZSNfGYmEO\/ofoXmOiKKS3Ga6wPYeRNxk9Vo49BONAIL1mUdIBa9bxPgn+zMOkAqIXDdQbp1sKAy6uWeyWd0Cyuk5LDh3pTtez\/NSVJqNwbh5kNZB8htkTrP1zHA9dM1nZ07nExmc50ZQGA7M+GxyLden9MA\/OLm\/KKe34xPoKAD7jPkAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:13d4]
%   data: {"align":"baseline","height":20,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADUAAAAxCAYAAAB6d+FmAAAC0ElEQVR42u2aO4gTURSGs6Lugo1WW2ghgiyCr1VWbRSR9YEgKoKohcQmEDAviYhBIaVbbKEWYi22YidoobUItoqwjSui6wt119Wsj+\/onXAcJslMZpI7AxP4Sbh37pnz3TP3zJ2TyWQS9imVStvRK1G5XL5ZqVRWZpL8MUCf0G+lz+hYIoGIyDYPIEc\/i8ViLmkRGkMfWwA5WkD7EwHEutmCs+87ADl6zfHLm4MLhcIqGs7RcV0WoA1xCa3vIkL\/CTsX\/w7G2Bka5oIMjlo4M6GBmOTRABHSeirh3S0LzSYQugHHgAPEJG+l7UOXtr6LgQeqYQZdRVf6Jc5frdfriyKIkOgHQToi1+0XpxGD+ywnhc348a5bICboqLMYmx02784hgRYAOqEzjHWoSIHiABU5kG2osECMP9lqC2IFiqS0qSdAtqAM0Ey3QOhUp81iX6F6DtRvKM6xsedA\/YQKCdQgyx0PcrKeQ4WNkE4K+LhGb6usQOHQOnnOCb31+WdrNW1TQC22BoW9Ddh9i6bRfNDdNkCH1c59LW0vpc8qFDYfo\/tkvMFqtbqM3xdkffgAmseXQ44dM3ba6bcGlc1mh9yzbaK3k\/Y37YAYc9Dl47A+xhoU0dlh7A579I3qRx6lbwAd8PAxHlA4V5BF3ea8Z11Ac62e52IDhb1bZuZL+lFdRWtQpflZzj3exlZsIvVc2b7jdW8xiWSWVL2ng4\/2ofL5\/Ars\/XJdXudN9wC\/R4Ce5PurFH58RN0+FLb2et130D1VVJlCu3zasw9FFC67dwboialUnZadQcBJsg+F09ewd9tkwLFcLrckZOTjkSgi3pmkUClUCpVCpVApVAqVQqVQ0UDp6s5IHKFMeaz5doufYuYz9bf\/XXmXQaqgcZH4I34pqBd+Qluz\/LpBUF3qCEUol3LgwyQAEbFHUrDxW6OTyk7NFEsaMYNpGL9qfoH+AOOEPfJuI6OmAAAAAElFTkSuQmCC","width":22}
%---
%[control:editfield:4426]
%   data: {"defaultValue":" exp(-x^2+x)","label":"phi(x,t) = ","run":"Nothing","valueType":"MATLAB code"}
%---
%[control:editfield:1b0e]
%   data: {"defaultValue":" exp(-x^2+x)","label":"V(x,t) = ","run":"Nothing","valueType":"MATLAB code"}
%---
%[control:editfield:5980]
%   data: {"defaultValue":" exp(-x^2+x)","label":"q(x,t) = ","run":"Nothing","valueType":"MATLAB code"}
%---
%[control:button:18b4]
%   data: {"label":"Check Exercise 1 Solutions","run":"Section"}
%---
%[text:image:8c00]
%   data: {"align":"baseline","height":26,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAApCAYAAAAiT5m3AAADOElEQVR42r1XSWgUQRSNGndR3Ii7V\/EmCCp4DaIe1Oh4EMHBwMjsq47Eg+OOJ0VIICAeFAIeXEADHgyoqChE1ASNhISAxH0jg5gxq+\/FX1A009PTM93T8OiuX7\/q1f+\/+tevqqoCTyKRWBmNRo8Cj4GPwF++I5HII7zT8Xh8eZWTTzgcnh6Lxc5j8kFgHMgCT4G7wBPgl8j\/YBGnfT7f1LJJg8HgQrGQE3diAXVciK5DIsi3o7+devh+4Pf755dMmslkpmGih0LaiHa1hf5k6J0T\/TYrfdMHKz8pFjTr1kFWD9ltvJ8Bt\/Dt1d0rYeG4Y7ZJMbAG+A300HLKuHkw2SuxKAe8lQ3Gdjv6llLP4\/FMQfs1MMBQ2SUOyaoPihur0X4BDGEDHVGLYbwhawCG6QG6W6yu43jo+uwSt3IyWLlA2vt09+F7CwlDodAaaZ+Q\/j3inZn0GENil\/gd0Ke1rwEjgUBgDqzYIe4lBiBbkkqlZov7r2hjXtLldom\/0LVa+x7QK9+NGjHduUvkfcAdbUwb0G+XuNtg8WV6QeLXbCDeKzo9QJM2phPosEt8ExijG9nG5NuKJK6VTTeXrofudbvEh2TS49r\/eakQMeQXNV2v9Nfbzc9c8U\/GWv2LKkmYEat+r9c7Q+L9nZvOdhLBhOF86c+MWJ5JkLVIX6jUdM1Jbsgk3NU1RRBPHCzQ2crxZR0U3CBC8saKGO3NCNNGx85kpk4QPLfaXJr8jGPkKs4FfqesJv9kcP1OvFeXa70Z8Ygmz1KWTCYX4fuDqlAQhnUVIWafQfesXjjgF5zlCrGWSBQuyOm1nuEARqGTqRgxKxejrm1iYL+URKPFEktJrGSDpRJ3aYlGYRhFwjK8T+lyle+1yrUsYjMM5ZG9l0tBzk3iYvGfWE6XVWYniyvEci1RgjEpZwP6Itwi7jfppHy31Mz3HSeGNZvw8aOAUs5h0olUqqqPFVIhjlcI34wXsMMuWWhEb76ibwPw1U1ibmCzwm+tdil3HEyfhcrdBhetbrW6pHe5RNxiVeTXukTcVEyevupCjA9YEqfT6XlyGXOKuINnQ1GnEy9y6uJeBuFn3qXxxyzmnP8Amz0wy7TM4YgAAAAASUVORK5CYII=","width":19}
%---
%[control:editfield:351b]
%   data: {"defaultValue":" 1","label":"aCoeff = ","run":"Nothing","valueType":"MATLAB code"}
%---
%[control:editfield:658a]
%   data: {"defaultValue":"1-c*t^2","label":"bCoeff = ","run":"Nothing","valueType":"MATLAB code"}
%---
%[control:editfield:7607]
%   data: {"defaultValue":"0","label":"cCoeff = ","run":"Nothing","valueType":"MATLAB code"}
%---
%[control:dropdown:2b60]
%   data: {"defaultValue":"piecewise(x<-1,0,(x>=-1) & (x<=0),1+x, (x>0) & (x<=1), 1-x, 0)","itemLabels":["triangle wave","gaussian","decaying sinusoidal","linear function"],"items":["piecewise(x<-1,0,(x>=-1) & (x<=0),1+x, (x>0) & (x<=1), 1-x, 0)","exp(-x^2)","exp(-x^2)*cos(2*x)","x"],"label":"Initial condition is a ","run":"Nothing"}
%---
%[control:button:64ce]
%   data: {"label":"Compute characteristic curve solution","run":"Section"}
%---
%[control:slider:8d31]
%   data: {"defaultValue":3,"label":"c = ","max":6,"min":-3,"run":"Nothing","runOn":"ValueChanged","step":0.2}
%---
%[control:button:281f]
%   data: {"label":"Plot characteristic curves","run":"Section"}
%---
%[control:button:278c]
%   data: {"label":"Animate solution","run":"Section"}
%---
%[control:dropdown:1d96]
%   data: {"defaultValue":"piecewise(x<-1,0,(x>=-1) & (x<=0),1+x, (x>0) & (x<=1), 1-x, 0)","itemLabels":["triangle wave","gaussian","decaying sinusoidal","sinusoidal","step up","step down"],"items":["piecewise(x<-1,0,(x>=-1) & (x<=0),1+x, (x>0) & (x<=1), 1-x, 0)","exp(-x^2)","exp(-x^2)*cos(2*x)","sin(x)","piecewise(x<jumppoint,0,abs(speed))","piecewise(x<jumppoint,abs(speed),0)"],"label":"Initial condition is a ","run":"Section"}
%---
%[control:button:953a]
%   data: {"label":"Compute characteristic curve solution","run":"Section"}
%---
%[control:button:81fe]
%   data: {"label":"Plot characteristic curves","run":"Section"}
%---
%[control:button:3a2a]
%   data: {"label":"Animate solution","run":"Section"}
%---
%[control:button:0f58]
%   data: {"label":"Solve this problem","run":"Section"}
%---
%[control:dropdown:22c7]
%   data: {"defaultValue":"exp(-y^2)","itemLabels":["exp(-y^2)","pi\/2-abs(y)","3*sin(6*y)+cos(2*y)"],"items":["exp(-y^2)","pi\/2-abs(y)","3*sin(6*y)+cos(2*y)"],"label":"Initial condition: f(y) = ","run":"AllSections"}
%---
%[control:button:18f0]
%   data: {"label":"Plot the Solution","run":"SectionToEnd"}
%---
%[control:statebutton:75bc]
%   data: {"defaultValue":false,"label":"Open traffic model","run":"Section"}
%---
%[control:statebutton:44d9]
%   data: {"defaultValue":false,"label":"Open tsunami model","run":"Section"}
%---
%[text:image:28c4]
%   data: {"align":"middle","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAjElEQVR42mP4\/\/8\/AwgnJiYapKamfgfS\/ynBUDMMYOYywBggiYcPH\/6nFIDMAJmFYQHIdmoBqFm4LZjrYPd\/gpoyGIPYVLeA5j6gmwUlJaVAxUlgDGKPBhFODaQG1QgIoqKtr\/6r99wlCYP0EG0BSMOWe\/9JwiA9oxaMWkBHC2ieD2iSk+lR6dOk2QIAjF+EgB\/BqfoAAAAASUVORK5CYII=","width":24}
%---
