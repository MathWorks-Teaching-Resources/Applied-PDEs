%[text] %[text:anchor:T_88488DE6] # Diffusion
%[text] [⇦ Main Menu](file:MainMenu.m)
%[text] Diffusion is a process that describes how particles move from an area of high concentration to an area of low concentration. It's a fundamental concept in physics, chemistry, and biology, and it's described mathematically by partial differential equations (PDEs). This module uses numerical methods to solve and visualize the diffusion equation, a type of PDE that models the distribution of a substance within a space over time.
%[text:tableOfContents]{"heading":"Table of Contents"}
%[text] %[text:anchor:M_H_719894D2] **Before you get started:**
%[text] This live script is intended to be used in Output Inline. On the **View** tab of the MATLAB Toolstrip, in the **View** section, select **Output Inline**. Alternately, select **Output Inline** (![live script output inline icon](text:image:90e1)) using the icons at the top right of the Live Editor pane.
%[text] %[text:anchor:H_2c47] ## The Diffusion Equation
%[text] The diffusion equation, in its simplest form with one spatial dimension ($x${"altText":"x"}) and a constant diffusion coefficient ($D${"altText":"D"}), is given by:
%[text]{"align":"center"} ${\\frac{\\partial u}{\\partial t} = D \\frac{\\partial^2 u}{\\partial x^2}}${"altText":"((∂ u)\/(∂ t) = D (∂^2 u)\/(∂ x^2))"}
%[text] Where:
%[text] - $u(x,t)${"altText":"u(x,t)"} is the concentration of the diffusing substance at position $x${"altText":"x"} and time $t${"altText":"t"}.
%[text] - $D${"altText":"D"} is the diffusion coefficient, which represents the rate of diffusion. \
%[text] %[text:anchor:M_H_A02880A1] **Boundary and Initial Conditions**
%[text] We need to specify boundary conditions (BCs) and an initial condition (IC) to solve the diffusion equation. For example, we'll consider:
%[text] - **Boundary Conditions**: The substance concentration is zero at both ends of the domain throughout the simulation, $u(0,t) = u(L,t) = 0${"altText":"u(0,t) = u(L,t) = 0"}, where $L${"altText":"L"} is the length of the domain.
%[text] - **Initial Condition**: The substance is initially concentrated in the middle of the domain, described by $u(x,0) = \\exp(-10(x-L/2)^2)${"altText":"u(x,0) = exp(-10(x-L\/2)^2)"}. \
%[text] %[text:anchor:H_A9963846] ## Solve and Visualize the Diffusion Process
%[text] The code below is presented as an example. [Later](internal:M_H_8C9B0CA6), you will be asked to modify the conditions and re-run the code.
%[text] %[text:anchor:H_38EF7AEC] ### Step 1: Define Parameters and Initial Conditions
% Parameters
D = 0.01; % Diffusion coefficient %[control:editfield:07f4]{"position":[5,9]}
L = 10; % Length of the domain
Nx = 100; % Number of spatial steps
T = 1; % Total amount of time %[control:editfield:4162]{"position":[5,6]}
Nt = 200; % Number of time steps
dx = L/Nx; % Spatial step size
dt = T/Nt; % Time step size
x = linspace(0, L, Nx); % Spatial grid
t = linspace(0, T, Nt); % Temporal grid

% Initial condition
u0 = exp(-10*(x-L/2).^2); %[control:editfield:072c]{"position":[6,25]}

% Boundary conditions
BC0 = 0; % at x = 0 %[control:editfield:4131]{"position":[7,8]}
BCL = 0; % at x = L %[control:editfield:9468]{"position":[7,8]}
%[text] %[text:anchor:H_70EEDB43] ### Step 2: Solve the Diffusion Equation
%[text] We'll use the [finite difference method](file:./FiniteDifference.m) for this purpose.
% Initialize the solution matrix
u = zeros(Nx, Nt);

u(:,1) = u0;
% Apply boundary conditions
u(1,:) = BC0;
u(end,:) = BCL;

% Finite difference method
for n = 1:Nt-1
    for i = 2:Nx-1
        u(i,n+1) = u(i,n) + D*dt/dx^2*(u(i+1,n) - 2*u(i,n) + u(i-1,n));
    end
end
%%
%[text] %[text:anchor:H_7E955793] ### Step 3: Visualization
%[text] Plot the results of your solution over time. Check the box to plot a surface $(x,t,u)${"altText":"(x,t,u)"} and uncheck the box to plot an animation over time.
SeeIn3D = false; %[control:checkbox:2022]{"position":[11,16]}
if SeeIn3D
    mesh(t, x, u)
    xlabel("Time")
    ylabel("Position")
    zlabel("Concentration")
    title("Diffusion of a Substance Over Time")
    colormap("parula");  % Choose a different colormap to plot in different colors %[control:dropdown:0708]{"position":[14,22]}
    c=colorbar;
    c.Label.String = "Concentration";
else
    p = plot(x,u0);
    ylim([-0.1*range(u0) 1.1*range(u0)])
    xlabel("Position")
    ylabel("Concentration")
    title("Diffusion of a Substance Over Time")
    for tStep = 2:5:Nt  % Increase the step size to make the animation run faster %[control:dropdown:255f]{"position":[19,20]}
        p.YData = u(:,tStep);
        drawnow
    end
end
%[text] 
%[text] %[text:anchor:M_H_8C9B0CA6] ![](text:image:311e) **Try**. Change the[ initial conditions, boundary conditions, and other parameters](internal:H_38EF7AEC) of this problem and observe the results.
%[text] 1. **Change the Diffusion Coefficient**: Modify the diffusion coefficient $D${"altText":"D"} to see how it affects the rate of diffusion. Try values of $0.005${"altText":"0.005"}, $0.02${"altText":"0.02"}, $0.5${"altText":"0.5"}, and others. What do you observe?
%[text] 2. **Modify the Initial Condition**: Instead of a single peak, create an initial condition with two peaks. Observe how they diffuse over time. What if you start with a constant value? What about a sinusoidal value?
%[text] 3. **Modify the Boundary Conditions**: Rather than having the boundary conditions set at $u(0,t)=u(L,t)=0${"altText":"u(0,t)=u(L,t)=0"}, what happens if you set $u(0,t)=0${"altText":"u(0,t)=0"} and $u(L,t)=0.6${"altText":"u(L,t)=0.6"}? What about $u(0,t)=0.3${"altText":"u(0,t)=0.3"} and $u(L,t)=-0.1${"altText":"u(L,t)=-0.1"}? What happens if you set non-constant boundary conditions such as $u(0,t)=0${"altText":"u(0,t)=0"} and $u(L,t) = \\sin(2\\pi t)${"altText":"u(L,t) = sin(2π t)"}?
%[text] 4. **Change the Total Time**: What happens to your results if you decrease $T${"altText":"T"}? Or increase $T${"altText":"T"}? \
%[text] ![](text:image:4672) **Challenge Yourself**
%[text] **Implement a Two-dimensional Diffusion Model**: Extend the script to solve the diffusion equation in two dimensions. You'll need to modify the finite difference scheme accordingly.
%[text] 
%[text] %[text:anchor:H_88413FEC] #### ![](text:image:53bb) **Reflect**.
%[text] 1\. How does changing the diffusion coefficient affect the spread of the substance?
%[text] 2\. What happens to the concentration at the center of the domain over time? Why?
%[text] 3\. How do the boundary conditions affect the diffusion process?
%[text] 
%%
%[text] %[text:anchor:H_6CC5BD4C] ## Application of Diffusion: Carbon Atoms Diffusing within Iron Lattices
%[text] The hardening of steel through the diffusion of carbon is a critical process in manufacturing tools and structural components. The process involves heating the steel to a high temperature where the iron lattice structure allows for easier movement of carbon atoms. The steel is then quickly cooled or "quenched," trapping the carbon atoms in positions that result in a much harder and stronger material.
%[text] %[text:anchor:H_25A60B22] #### Steps in the Hardening Process
%[text] 1. **Heating**: The steel is heated to a temperature where the solubility of carbon in iron increases, allowing carbon atoms to move more freely.
%[text] 2. **Soaking**: The steel is held at this temperature to allow uniform diffusion of carbon throughout the material.
%[text] 3. **Quenching**: Rapid cooling "freezes" the carbon atoms in place, resulting in a distorted lattice structure that significantly increases hardness. \
%[text] We shall focus on the soaking step, where diffusion takes place. In the context of steel production and treatment, the diffusion of carbon atoms within iron lattices is primarily influenced by temperature and carbon concentration gradient. The process can be described by Fick's laws of diffusion, which govern the movement of atoms or molecules in response to concentration gradients.
%[text] 
%[text] The diffusion equation describes the diffusion of carbon atoms in iron:
%[text]{"align":"center"} ${\\frac{\\partial C}{\\partial t} = D \\frac{\\partial^2 C}{\\partial x^2}}${"altText":"((∂ C)\/(∂ t) = D (∂^2 C)\/(∂ x^2))"}
%[text] Where:
%[text] \* $C(x,t)${"altText":"C(x,t)"} is the concentration of carbon at position $x${"altText":"x"} and time $t${"altText":"t"}.
%[text] \* ${D = D\_0 \\exp\\left(-\\frac{Q}{RT}\\right)}${"altText":"(D = D\_0 exp(-(Q)\/(RT)))"} is the diffusion coefficient, following the [Arrhenius equation](https://en.wikipedia.org/wiki/Arrhenius_equation).
%[text] and assume that
%[text] \* $D\_0=4${"altText":"D\_0=4"} $\\frac{\\text{mm}^2}{s}${"altText":"(mm^2)\/(s)"}.is the pre-exponential factor.
%[text] \* $Q=140${"altText":"Q=140"}$\\frac{\\text{kJ}}{\\text{mol}}${"altText":"(kJ)\/(mol)"} is the activation energy for diffusion. 
%[text] \* $R=8.31446261815324${"altText":"R=8.31446261815324"}$\\frac{\\text{J}}{\\text{mol}\\cdot\\text{K}}${"altText":"(J)\/(molcdotK)"} is the universal gas constant.
%[text] \* $T${"altText":"T"} is the absolute temperature in Kelvin.
%[text] 
%[text] ![](text:image:3455) **Exercise 1**. By adjusting parameters such as temperature and soaking time, engineers can predict the distribution of carbon within the steel and thus tailor the mechanical properties of the final product. Model the diffusion over time with $C(x,0) = 0.2\\%${"altText":"C(x,0) = 0.2%"} and boundary conditions of $C(0,t)=C(L,t)=80\\%${"altText":"C(0,t)=C(L,t)=80%"} and $T=900K${"altText":"T=900K"}, $1000K${"altText":"1000K"}, $1100K${"altText":"1100K"}, and $1200K${"altText":"1200K"}. At what time $t\_{\\text{end}}${"altText":"t\_(end)"} should you quench the steel to achieve high-carbon steel with $C(L/2,t\_{\\text{end}}) = 0.6\\%${"altText":"C(L\/2,t\_(end)) = 0.6%"}. W
% Implement your solution here.
% You may want to start by copying the example implementation and
% redesigning it to match the new situation. What needs to change?



%%
%[text] Check your implementation by setting the values you found for any (or all) of the quench times below:
t_end900 = 0;  % time in seconds for the quench time at 900 K
t_end1000 = 0; % time in seconds for the quench time at 1000 K
t_end1100 = 0; % time in seconds for the quench time at 1100 K
t_end1200 = 0; % time in seconds for the quench time at 1200 K

CheckEx1(t_end900,t_end1000,t_end1100,t_end1200)
%%
%[text] %[text:anchor:H_AA929B63] ## Further Resources
%[text] Other applications of diffusion include predicting the [Cherry Blossom Front](https://en.wikipedia.org/wiki/Cherry_blossom_front) or [denoising images](https://www.mathworks.com/help/deeplearning/ug/generate-images-using-diffusion.html) as part of a machine-learning process. 
%[text] [⇦ Main Menu](file:MainMenu.m)
%%
%[text] ## Help us Improve
%[text] [Share your feedback](<matlab: ShareFeedback>) to help us improve this module.
%%
%[text] ## Local Helper Functions
function CheckEx1(t900,t1000,t1100,t1200)
arguments
    t900 (1,1) double {mustBeNonnegative} 
    t1000 (1,1) double {mustBeNonnegative} 
    t1100 (1,1) double {mustBeNonnegative} 
    t1200 (1,1) double {mustBeNonnegative} 
end
load CarbonSteel.mat
tsol900 = abs(t900-t_end900)/t_end900;
tsol1000 = abs(t1000 - t_end1000)/t_end1000;
tsol1100 = abs(t1100 - t_end1100)/t_end1100;
tsol1200 = abs(t1200 - t_end1200)/t_end1200;

idx = [tsol900 tsol1000 tsol1100 tsol1200]<.03;

if all(idx)
    disp("Good work! You have accurately estimated the diffusion.")
elseif any(idx==1)
    T = ["900";"1000";"1100";"1200"];
    idx = [tsol900 tsol1000 tsol1100 tsol1200]<.03;
    disp("You have correct values for " + T(~idx) + "K.")
    disp("You have incorrect values for " +T(idx) + "K.")
    disp("Please calculate the remaining values.")
else
    disp("You have not found the correct values for the quench times.")
    disp("Please check your implementation and the values you have set for t_end900, t_end1000, etc.")
end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline","rightPanelPercent":40}
%---
%[text:image:90e1]
%   data: {"align":"middle","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAjElEQVR42mP4\/\/8\/AwgnJiYapKamfgfS\/ynBUDMMYOYywBggiYcPH\/6nFIDMAJmFYQHIdmoBqFm4LZjrYPd\/gpoyGIPYVLeA5j6gmwUlJaVAxUlgDGKPBhFODaQG1QgIoqKtr\/6r99wlCYP0EG0BSMOWe\/9JwiA9oxaMWkBHC2ieD2iSk+lR6dOk2QIAjF+EgB\/BqfoAAAAASUVORK5CYII=","width":24}
%---
%[control:editfield:07f4]
%   data: {"defaultValue":0,"label":"D","run":"Section","valueType":"Double"}
%---
%[control:editfield:4162]
%   data: {"defaultValue":0,"label":"T","run":"Section","valueType":"Double"}
%---
%[control:editfield:072c]
%   data: {"defaultValue":"exp(-10*(x-L\/2).^2)","label":"u0","run":"Section","valueType":"MATLAB code"}
%---
%[control:editfield:4131]
%   data: {"defaultValue":"0","label":"BC0","run":"Section","valueType":"MATLAB code"}
%---
%[control:editfield:9468]
%   data: {"defaultValue":"0","label":"BCL","run":"Section","valueType":"MATLAB code"}
%---
%[control:checkbox:2022]
%   data: {"defaultValue":false,"label":"See the results in 3D? ","run":"Section"}
%---
%[control:dropdown:0708]
%   data: {"defaultValue":"\"parula\"","itemLabels":["\"jet\"","\"parula\"","\"turbo\"","\"hot\"","\"cool\"","\"copper\""],"items":["\"jet\"","\"parula\"","\"turbo\"","\"hot\"","\"cool\"","\"copper\""],"label":"Drop down","run":"Section"}
%---
%[control:dropdown:255f]
%   data: {"defaultValue":"5","itemLabels":["5","10","20","100"],"items":["5","10","20","100"],"label":"Drop down","run":"Section"}
%---
%[text:image:311e]
%   data: {"align":"baseline","height":26,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAApCAYAAAAiT5m3AAADOElEQVR42r1XSWgUQRSNGndR3Ii7V\/EmCCp4DaIe1Oh4EMHBwMjsq47Eg+OOJ0VIICAeFAIeXEADHgyoqChE1ASNhISAxH0jg5gxq+\/FX1A009PTM93T8OiuX7\/q1f+\/+tevqqoCTyKRWBmNRo8Cj4GPwF++I5HII7zT8Xh8eZWTTzgcnh6Lxc5j8kFgHMgCT4G7wBPgl8j\/YBGnfT7f1LJJg8HgQrGQE3diAXVciK5DIsi3o7+devh+4Pf755dMmslkpmGih0LaiHa1hf5k6J0T\/TYrfdMHKz8pFjTr1kFWD9ltvJ8Bt\/Dt1d0rYeG4Y7ZJMbAG+A300HLKuHkw2SuxKAe8lQ3Gdjv6llLP4\/FMQfs1MMBQ2SUOyaoPihur0X4BDGEDHVGLYbwhawCG6QG6W6yu43jo+uwSt3IyWLlA2vt09+F7CwlDodAaaZ+Q\/j3inZn0GENil\/gd0Ke1rwEjgUBgDqzYIe4lBiBbkkqlZov7r2hjXtLldom\/0LVa+x7QK9+NGjHduUvkfcAdbUwb0G+XuNtg8WV6QeLXbCDeKzo9QJM2phPosEt8ExijG9nG5NuKJK6VTTeXrofudbvEh2TS49r\/eakQMeQXNV2v9Nfbzc9c8U\/GWv2LKkmYEat+r9c7Q+L9nZvOdhLBhOF86c+MWJ5JkLVIX6jUdM1Jbsgk3NU1RRBPHCzQ2crxZR0U3CBC8saKGO3NCNNGx85kpk4QPLfaXJr8jGPkKs4FfqesJv9kcP1OvFeXa70Z8Ygmz1KWTCYX4fuDqlAQhnUVIWafQfesXjjgF5zlCrGWSBQuyOm1nuEARqGTqRgxKxejrm1iYL+URKPFEktJrGSDpRJ3aYlGYRhFwjK8T+lyle+1yrUsYjMM5ZG9l0tBzk3iYvGfWE6XVWYniyvEci1RgjEpZwP6Itwi7jfppHy31Mz3HSeGNZvw8aOAUs5h0olUqqqPFVIhjlcI34wXsMMuWWhEb76ibwPw1U1ibmCzwm+tdil3HEyfhcrdBhetbrW6pHe5RNxiVeTXukTcVEyevupCjA9YEqfT6XlyGXOKuINnQ1GnEy9y6uJeBuFn3qXxxyzmnP8Amz0wy7TM4YgAAAAASUVORK5CYII=","width":19}
%---
%[text:image:4672]
%   data: {"align":"baseline","height":20,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADUAAAAxCAYAAAB6d+FmAAAC0ElEQVR42u2aO4gTURSGs6Lugo1WW2ghgiyCr1VWbRSR9YEgKoKohcQmEDAviYhBIaVbbKEWYi22YidoobUItoqwjSui6wt119Wsj+\/onXAcJslMZpI7AxP4Sbh37pnz3TP3zJ2TyWQS9imVStvRK1G5XL5ZqVRWZpL8MUCf0G+lz+hYIoGIyDYPIEc\/i8ViLmkRGkMfWwA5WkD7EwHEutmCs+87ADl6zfHLm4MLhcIqGs7RcV0WoA1xCa3vIkL\/CTsX\/w7G2Bka5oIMjlo4M6GBmOTRABHSeirh3S0LzSYQugHHgAPEJG+l7UOXtr6LgQeqYQZdRVf6Jc5frdfriyKIkOgHQToi1+0XpxGD+ywnhc348a5bICboqLMYmx02784hgRYAOqEzjHWoSIHiABU5kG2osECMP9lqC2IFiqS0qSdAtqAM0Ey3QOhUp81iX6F6DtRvKM6xsedA\/YQKCdQgyx0PcrKeQ4WNkE4K+LhGb6usQOHQOnnOCb31+WdrNW1TQC22BoW9Ddh9i6bRfNDdNkCH1c59LW0vpc8qFDYfo\/tkvMFqtbqM3xdkffgAmseXQ44dM3ba6bcGlc1mh9yzbaK3k\/Y37YAYc9Dl47A+xhoU0dlh7A579I3qRx6lbwAd8PAxHlA4V5BF3ea8Z11Ac62e52IDhb1bZuZL+lFdRWtQpflZzj3exlZsIvVc2b7jdW8xiWSWVL2ng4\/2ofL5\/Ars\/XJdXudN9wC\/R4Ce5PurFH58RN0+FLb2et130D1VVJlCu3zasw9FFC67dwboialUnZadQcBJsg+F09ewd9tkwLFcLrckZOTjkSgi3pmkUClUCpVCpVApVAqVQqVQ0UDp6s5IHKFMeaz5doufYuYz9bf\/XXmXQaqgcZH4I34pqBd+Qluz\/LpBUF3qCEUol3LgwyQAEbFHUrDxW6OTyk7NFEsaMYNpGL9qfoH+AOOEPfJuI6OmAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:53bb]
%   data: {"align":"baseline","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAsCAYAAAAXb\/p7AAADlklEQVR42u1YS0hUYRQejR4UvR+SvaCyWiS2DIoCKWjVYzG2SsYWQ+a8HRwXFkOgqdGLSoSeqyBaJUGLCKGkNpGtgiyScnpYBpaU5au+E+eH03Wu93rvP2OEFw46955z\/u8\/7\/\/3eDQ+4XD4Eui65199AK4d1DEJcBLgfw0wGo2ujkQi1yoqKlY5AFgDqnWw5lpaMxaLrbBkDgaDm7HIEKjTCcjxPqFQqABrdYEGsHaRXaESCAyCXpNFMwwuReDw\/77xusurQGJna0ysPR2K94CnGdQKesnUyu92J5PJaelk4c51Chzcu9dp0O9nkO3yvd\/vnwqlEbzvAf2yoB5sIkwyBt0doJ+0Qbdu2AXyC8UrOVuNQH5Q3IJegfrTfH8ikwC\/A9hjsdaYCQQCG6D4vVj0DShB7+HKXMGaQ\/EFADEGrPhJdn1GAhoZvRDKX4jFTvt8vhlWchSD4D0OGiE5AH9eXl4+PxNF+IoCB8sccyBfreQB8qJWcAC0CYqHeYE2cqEDNTmQvcc6hlC+CnXWq\/PCtTtdeGGr0HNWFz7aeTcr\/eT1eqe41PVWJYxd62zkovwXqQ6Cv8vErm9r8MZNEctLVf9Ph4GwecSOjPSQu8V28e6chmRrFPq28btHJhhSBKDIBH0B726HEDilAWCtsGCx6MmjMNgaHqBkiygPl3UmHE1OrjOEiqoqsqDHGizYxrqGAXCOriL9jJUOoq3lO9UDQItpQGD3PtXZRapFHB51oSchwiWsDWA8Hl8Cpb2svA+WWO4AXJ7Q0Z1IJObq7sUBN\/UQLr0hrHfANSCaQihrobiBf+dC+QOxSNk4MrdEyN1VvRy6T+DdVbOp2wpcCyutN8yDahjtVZ3A4sS2ALwflYxhaK1n0C22QfL8dkuNRYZBlKxxRLj6gg3XNgj+w8beLOriHcv50gocJ8wsfP\/ASgfMDlRs8XzwfGPeThMr2QcpEqFprJmPSoSwSvMYfCcFX6nFlNPEfAGrUuC1GkhxQpspTnTfKysrFxl5qqqqZouy0mU81ZmApB6cp2vKlrFVk+Z7TGRuPOsXRZSNfGYmEO\/ofoXmOiKKS3Ga6wPYeRNxk9Vo49BONAIL1mUdIBa9bxPgn+zMOkAqIXDdQbp1sKAy6uWeyWd0Cyuk5LDh3pTtez\/NSVJqNwbh5kNZB8htkTrP1zHA9dM1nZ07nExmc50ZQGA7M+GxyLden9MA\/OLm\/KKe34xPoKAD7jPkAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:3455]
%   data: {"align":"baseline","height":20,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADUAAAAxCAYAAAB6d+FmAAAC0ElEQVR42u2aO4gTURSGs6Lugo1WW2ghgiyCr1VWbRSR9YEgKoKohcQmEDAviYhBIaVbbKEWYi22YidoobUItoqwjSui6wt119Wsj+\/onXAcJslMZpI7AxP4Sbh37pnz3TP3zJ2TyWQS9imVStvRK1G5XL5ZqVRWZpL8MUCf0G+lz+hYIoGIyDYPIEc\/i8ViLmkRGkMfWwA5WkD7EwHEutmCs+87ADl6zfHLm4MLhcIqGs7RcV0WoA1xCa3vIkL\/CTsX\/w7G2Bka5oIMjlo4M6GBmOTRABHSeirh3S0LzSYQugHHgAPEJG+l7UOXtr6LgQeqYQZdRVf6Jc5frdfriyKIkOgHQToi1+0XpxGD+ywnhc348a5bICboqLMYmx02784hgRYAOqEzjHWoSIHiABU5kG2osECMP9lqC2IFiqS0qSdAtqAM0Ey3QOhUp81iX6F6DtRvKM6xsedA\/YQKCdQgyx0PcrKeQ4WNkE4K+LhGb6usQOHQOnnOCb31+WdrNW1TQC22BoW9Ddh9i6bRfNDdNkCH1c59LW0vpc8qFDYfo\/tkvMFqtbqM3xdkffgAmseXQ44dM3ba6bcGlc1mh9yzbaK3k\/Y37YAYc9Dl47A+xhoU0dlh7A579I3qRx6lbwAd8PAxHlA4V5BF3ea8Z11Ac62e52IDhb1bZuZL+lFdRWtQpflZzj3exlZsIvVc2b7jdW8xiWSWVL2ng4\/2ofL5\/Ars\/XJdXudN9wC\/R4Ce5PurFH58RN0+FLb2et130D1VVJlCu3zasw9FFC67dwboialUnZadQcBJsg+F09ewd9tkwLFcLrckZOTjkSgi3pmkUClUCpVCpVApVAqVQqVQ0UDp6s5IHKFMeaz5doufYuYz9bf\/XXmXQaqgcZH4I34pqBd+Qluz\/LpBUF3qCEUol3LgwyQAEbFHUrDxW6OTyk7NFEsaMYNpGL9qfoH+AOOEPfJuI6OmAAAAAElFTkSuQmCC","width":22}
%---
