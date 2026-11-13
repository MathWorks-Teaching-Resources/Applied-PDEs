%[text] %[text:anchor:T_3FE4E436] # Battery Thermal Modeling
%[text] [⇦ Main Menu](file:MainMenu.m)
%[text] The heat equation is a commonly used partial differential equation (PDE) that describes how the distribution of heat evolves in a given region, with given boundary conditions and an initial distribution of heat. In engineering, the heat equation is crucial for understanding and controlling thermal processes of all types. One such process is the lithium-ion battery. Such batteries are integral to many modern technologies, from smartphones and toys to power tools and electric vehicles. Managing the heat produced during the charging and discharging of these batteries is vital for safety, efficiency, and longevity. This script explores how the heat equation can be applied to model thermal behavior in a simple battery.
%%
%[text:tableOfContents]{"heading":"Table of Contents"}
%[text] **Before you get started**
%[text] This live script is intended to be used with the code visible and output inline. On the **View** tab of the MATLAB Toolstrip, in the **View** section, select **Output Inline**. Alternately, select **Output Inline** using the icon ![live script output inline icon](text:image:21b9) at the top right of the Live Editor pane.
%[text] ![Lightbulb mark](text:image:9601) Interacting with this live script will build some familiarity with MATLAB as concepts and commands are introduced together. If you need more instruction, consider taking [MATLAB Onramp](https://matlabacademy.mathworks.com/details/matlab-onramp/gettingstarted), a free 2-hour online tutorial that teaches the essentials of MATLAB.
%[text] ![Warning symbol](text:image:563b)   For an optimal experience, follow the instructions and steps in the given sequence. Proceed to a new section only after completing the preceding one. Some sections depend on variables created in prior sections, and they will generate errors if they run out of order.
%%
%[text] %[text:anchor:H_245F9203] ## The Heat Equation
%[text] When modeling the thermal behavior of cylindrical batteries, it can be beneficial to use cylindrical coordinates $(r,\\theta,z)${"altText":"(r,θ,z)"} that align with the geometry of the battery. The heat equation in cylindrical coordinates, assuming rotational symmetry around the $z${"altText":"z"}-axis and including a source term for heat generation, is given by:
%[text]{"align":"center"} %[text:anchor:M_8f53] $\\frac{\\partial T}{\\partial t} = \\frac{k}{\\rho c\_p}\\left( \\frac{\\partial^2 T}{\\partial r^2} + \\frac{1}{r} \\frac{\\partial T}{\\partial r} + \\frac{\\partial^2 T}{\\partial z^2} \\right) + \\frac{Q}{\\rho c\_p}}${"altText":"(∂ T)\/(∂ t) = (k)\/(ρ c\_p)( (∂^2 T)\/(∂ r^2) + (1)\/(r) (∂ T)\/(∂ r) + (∂^2 T)\/(∂ z^2) ) + (Q)\/(ρ c\_p)"}.
%[text] This equation accounts for radial ($r${"altText":"r"}) and axial ($z${"altText":"z"}) heat conduction within the battery, where $T=T(r,\\theta,z,t)${"altText":"T=T(r,θ,z,t)"} represents the temperature distribution as a function of radial position $r${"altText":"r"}, angular position $\\theta${"altText":"θ"}, axial position $z${"altText":"z"}, and time $t${"altText":"t"}.
%[text] - $Q = Q(r,\\theta,z,t)${"altText":"Q = Q(r,θ,z,t)"} is the heat generation rate per unit volume,
%[text] - $\\rho${"altText":"ρ"} is the density of the battery material,
%[text] - $c\_p${"altText":"c\_p"} is the specific heat capacity of the material,
%[text] - $k${"altText":"k"} is the thermal conductivity. \
%[text] %[text:anchor:H_D8792DE0] ### Boundary and Initial Conditions
%[text] To solve the heat equation, we must specify boundary conditions (e.g., the temperature at the surfaces of the battery) and initial conditions (the temperature distribution at $t=0${"altText":"t=0"}) for a battery of length $L${"altText":"L"} and radius $R${"altText":"R"}.
%[text] 
%[text] %[text:anchor:H_97EAAC4E] #### Example Boundary Conditions
%[text] - Constant temperature at the ends: $T(r,\\theta,0,t) = T\_0${"altText":"T(r,θ,0,t) = T\_0"} and $T(r,\\theta,L,t) = T\_L${"altText":"T(r,θ,L,t) = T\_L"}.
%[text] - Insulated ends (no heat flux): $\\frac{\\partial T}{\\partial z}(r,\\theta,0,t) = 0${"altText":"(∂ T)\/(∂ z)(r,θ,0,t) = 0"} and $\\frac{\\partial T}{\\partial z}(r,\\theta,L,t) = 0${"altText":"(∂ T)\/(∂ z)(r,θ,L,t) = 0"}.
%[text] - Insulated edges (no heat flux): $\\frac{\\partial T}{\\partial r}(R,\\theta,z,t) = 0${"altText":"(∂ T)\/(∂ r)(R,θ,z,t) = 0"}. \
%[text] %[text:anchor:H_BADF316D] #### Example Initial Condition
%[text] - The initial temperature distribution in the battery, e.g., $T(r,\\theta,z,0) = T\_{\\text{initial}}${"altText":"T(r,θ,z,0) = T\_(initial)"}. \
%%
%[text] %[text:anchor:H_8338] ## Simplified Battery Model
%[text] Consider a simplified battery model where the heat generation rate $Q${"altText":"Q"} is constant throughout the battery and time. Let's assume a battery with thermal diffusivity $\\alpha = 0.1 \\, \\text{cm}^2/\\text{s}${"altText":"α = 0.1 cm^2\/s"}, length $L = 65 \\, \\text{mm}${"altText":"L = 65 mm"}, and a constant heat generation rate $Q = 1.5\\, \\text{W}${"altText":"Q = 10 W"}. The battery is insulated at both ends and initially, the temperature is uniform at $20^\\circ\\text{C}${"altText":"20^circC"}. The radius of the battery is $R=9\\, \\text{mm}${"altText":"0.5 cm"}, the weight is $45\\, \\text{g}${"altText":"45 g"}, and the thermal mass is $C\_p = 45\\, \\text{J/K}${"altText":"C\_p = 45 J\/K"}.
% Parameters
k = 0.6;            % Thermal diffusivity [W/K/m]
R = 9e-3;           % Radius [m]
L = 65e-3;          % Length of the battery [m]
Q = 1.5/(L*pi*R^2); % Heat generation rate per unit volume [W/m^3]
m = 45e-3;          % [kg]
rho = m/(L*pi*R^2); % Density [kg/m^3]
Mth = 45;           % Thermal mass [J/K]
cp = Mth / m;       % Thermal mass density [J/K/m]
T_initial = 20;     % Initial temperature [C]
t_final = 1200;     % Final time [s]
%[text] 
% Discretization
nr = 10;              % Radial step [-]
nz = 60;              % Axial step [-]
dt = 0.1;             % Time step [s]
r = linspace(0,R,nr); % Radial grid
dr = r(2)-r(1);
z = linspace(0,L,nz); % Axial grid
dz = z(2)-z(1);
t = 0:dt:t_final;     % Time grid
Nr = length(r);
Nz = length(z);
Nt = length(t);
%[text] 
% Initial condition
T = T_initial*ones(Nr,Nz,Nt);

% Heat Equation Solver
for kTime = 1:Nt-1
    for iRadial = 2:Nr-1
        for jLength = 2:Nz-1
            Laplacian = (T(iRadial+1,jLength,kTime) - 2*T(iRadial,jLength,kTime) + ...
                T(iRadial-1,jLength,kTime))/dr^2 + (1/r(iRadial))*(T(iRadial+1,jLength,kTime) ...
                - T(iRadial-1,jLength,kTime))/(2*dr) + (T(iRadial,jLength+1,kTime) ...
                - 2*T(iRadial,jLength,kTime) + T(iRadial,jLength-1,kTime))/dz^2;
            T(iRadial,jLength,kTime+1) = T(iRadial,jLength,kTime) + dt*(k/(rho*cp)*Laplacian ...
                + Q/(rho*cp));
        end
    end
    % Boundary conditions: 
    T(1,:,kTime+1) = T(2,:,kTime+1);        % Radial symmetry at r=0
    % T(Nr,:,kTime+1) = T(Nr-1,:,kTime+1);  % Insulated at r=R
    % T(:,1,kTime+1) = T(:,2,kTime+1);      % Insulated at z=0
    % T(:,1,kTime+1) = 20+0.01*dt*(kTime-1) % Fixed temperature 20+0.01t at z=0
    % T(:,Nz,kTime+1) = T(:,Nz-1,kTime+1);  % Insulated or constant temperature at z=L
end

% Visualize the results
p = mesh(z,r,T(:,:,1));
xlabel('Length (cm)')
ylabel('Radial Position (cm)')
zlabel('Temperature (°C)')
colorbar
zlim([min(T,[],"all") max(T,[],"all")+1])
clim([min(T,[],"all") max(T,[],"all")])
title('Temperature Distribution in the Battery Over Time')
% Plotting
for tVal = -500:100:Nt
    if tVal <= 0
        p.ZData = T(:,:,1);
    else
        p.ZData = T(:,:,tVal);
    end
    drawnow
end
%%
%[text] ![](text:image:869e) **Exercise 1.** 
%[text] %[text:anchor:H_C958E923] a. In this example, which finite difference approximation is used for $\\frac{\\partial^2 T}{\\partial r^2}${"altText":"(∂^2 T)\/(∂ r^2)"}?
aOrder = "second order"; d2Tdr2 = "centered difference"; %[control:dropdown:2b66]{"position":[10,24]} %[control:dropdown:5880]{"position":[35,56]}
  %[control:button:1170]{"position":[1,2]}
CheckEx1(aOrder,d2Tdr2,"a")
%%
%[text] b. In this example, which finite difference approximation is used for $\\frac{\\partial T}{\\partial r}${"altText":"(∂ T)\/(∂ r)"}?
bOrder = "first order"; dTdr = "forward difference"; %[control:dropdown:499a]{"position":[10,23]} %[control:dropdown:79d0]{"position":[32,52]}
  %[control:button:1726]{"position":[1,2]}
CheckEx1(bOrder,dTdr,"b")
%%
%[text] c. In this example, which finite difference approximation is used for $\\frac{\\partial^2 T}{\\partial z^2}${"altText":"(∂^2 T)\/(∂ z^2)"}?
cOrder = "second order"; d2Tdz2 = "centered difference"; %[control:dropdown:11d5]{"position":[10,24]} %[control:dropdown:7799]{"position":[35,56]}
  %[control:button:336d]{"position":[1,2]}
CheckEx1(cOrder,d2Tdz2,"c")
%%
%[text] ![](text:image:04dc) **Exercise 2.** 
%[text] a. What is the purpose of the code:
%[text] ```matlabCodeExample
%[text] for kTime = 1:Nt-1
%[text]     ...
%[text] end
%[text] ```
Ex2a = "t"; %[control:dropdown:3f23]{"position":[8,11]}
CheckEx2(Pa=Ex2a);
%[text] b.  Express the boundary condition 
%[text] ```matlabCodeExample
%[text] T(:,1,kTime+1) = 20+0.01*dt*(kTime-1)
%[text] ```
%[text] mathematically.
Ex2b = 3; %[control:dropdown:31f8]{"position":[8,9]}
CheckEx2(Pb=Ex2b);
%[text]{"align":"center"} $T(r,0,t) = 20+0.01t${"altText":"T(r,0,t) = 20+0.01t"}
%[text] c. Express the boundary condition $\\frac{\\partial T(R,z,t)}{\\partial r} = 6${"altText":"(∂ T(R,z,t))\/(∂ r) = 6"} as code using the abovementioned relevant values.
Ex2c = 4; %[control:dropdown:925f]{"position":[8,9]}
CheckEx2(Pc=Ex2c);
%%
%[text] ![](text:image:141b) **Exercise 3.**  Change the boundary conditions to simulate a scenario where the ends of the battery are kept at a constant temperature $(T(r,\\theta,0,t) =T(r,\\theta,L,t)= 20^\\circ\\text{C})${"altText":"(T(r,θ,0,t) =T(r,θ,L,t)= 20^circC)"} while the edges ($r=R${"altText":"r=R"}) remain insulated with $\\frac{\\partial T}{\\partial r} = 0${"altText":"(∂ T)\/(∂ r) = 0"}. Note that `kTime` is the time parameter, with $t=${"altText":"t="} (`kTime-1)*dt`, `Nr` is the maximal radial index, and `Nz` is the maximal length index. 


function T = ConstantBCs(T,kTime,Nz,Nr)
    % Boundary conditions: Insulated surfaces
    T(1,:,kTime+1) = T(2,:,kTime+1); % Radial symmetry at r=0
    T(Nr,:,kTime+1) =  T(Nr-1,:,kTime+1); % Insulated outer surface
    T(:,1,kTime+1) = 20; % Insulated or constant temperature at z=0
    T(:,Nz,kTime+1) = 20; % Insulated or constant temperature at z=L
end
T = SolveHeatEqn(T_initial,Nr,Nz,Nt,k,dt,dr,r,dz,rho,cp,z,Q,@ConstantBCs);
CheckEx3(T,T_initial)
%%
%[text] ![](text:image:0351) **Try**. 
%[text] %[text:anchor:M_745a] 1. Change the heat generation rate $Q${"altText":"Q"} to a different constant value and observe how it affects the temperature distribution. Try $Q = 5 \\; \\text{W}${"altText":"Q = 5 W"} and $Q = 7 \\, \\text{W}${"altText":"Q = 7 W"}.
%[text] 2. Modify the [`SolveHeatEqn`](internal:M_8e42) function so that you can simulate a scenario where the heat generation rate $Q${"altText":"Q"} depends on time, e.g., $Q(t) = \\frac{t}{100} \\, \\text{W}${"altText":"Q(t) = t\/100 W"}. Uncomment the [code below](internal:M_0f8d) and update the value of `Q` to plot the temperature distribution over time and discuss the results.
%[text] 3. Create and test other boundary conditions.  \
% Q = @(t) 1.5; %[text:anchor:M_0f8d]
% T = SolveHeatEqn(T_initial,Nr,Nz,Nt,k,dt,dr,r,dz,rho,cp,z,Q,@InsulatedBCs);
max(T,[],"all")
%%
%[text] %[text:anchor:H_E74A83F7] ## ![](text:image:7f15) **Reflect**. 
%[text] 1. How does increasing the heat generation rate $Q${"altText":"Q"} affect the overall temperature in the battery? What are the implications for battery design and safety?
%[text] 2. In the context of the heat equation, why is it important to consider both the material properties (like $k${"altText":"k"}, $\\rho${"altText":"ρ"}, and $c\_p${"altText":"c\_p"}) and the boundary conditions? How do they influence the temperature distribution?
%[text] 3. What is the impact of different boundary conditions (e.g., constant temperature vs. insulated) on the temperature distribution in the battery? How do these conditions mimic real-world scenarios, and what insights can they provide for battery management systems?
%[text] 4. What do you need to change to make a Cartesian model rather than a [cylindrical model](internal:M_8f53)? \
%%
%[text] In practice, engineers can use simulations based on the heat equation to:
%[text] - **Optimize Battery Design**: Identify materials with optimal thermal properties and design batteries that efficiently manage heat.
%[text] - **Develop Thermal Management Systems**: Design cooling systems (like air, liquid, or phase-change materials) that effectively dissipate heat during operation.
%[text] - **Enhance Safety**: Predict thermal runaway conditions and implement safety mechanisms to prevent overheating and potential hazards.
%[text] - **Improve Efficiency and Longevity**: Minimize detrimental thermal effects on battery efficiency and lifespan through smart charging strategies and thermal management. \
%[text] By integrating these insights into the design and operation of batteries, engineers can address one of the critical challenges in the widespread adoption of electric vehicles, renewable energy storage solutions, and portable electronics, contributing to a more sustainable and technologically advanced future.
%%
%[text] %[text:anchor:H_25F89626] ## Further Exploration
%[text] To begin exploring more realistic battery modeling, you could take the [Simscape Battery Onramp](https://matlabacademy.mathworks.com/details/simscape-battery-onramp/orsb). The documentation also includes more complex examples, like the [thermal analysis of a fast-charging battery](https://www.mathworks.com/help/simscape-battery/ug/battery-spatial-temperature-variation-during-fast-charge.html) which uses a [reduced-order model](https://www.mathworks.com/help/pde/ug/reduced-order-model-for-battery-thermal-behavior.html) for practicality.
%%
%[text] [⇦ Return to the main menu](file:MainMenu.m)
%%
%[text] ## Help us Improve
%[text] [Share your feedback](<matlab: ShareFeedback>) to help us improve this module.
%%
%[text] %[text:anchor:H_0AAABA39] ## Local Helper Functions
function CheckEx1(O,D,opt)
arguments
    O (1,1) string {mustBeMember(O,["unknown" "first order" "second order" "third order"])}
    D (1,1) string {mustBeMember(D,["unknown" "centered difference" "forward difference" "backward difference"])}
    opt (1,1) string {mustBeMember(opt,["a" "b" "c"])}
end
flag = 0;

if O == "unknown" && D == "unknown"
    disp("This is the default value. Please select and order and a method.")
elseif O == "unknown"
    disp("What is the order of this derivative?")
elseif D == "unknown"
    disp("Which method is applied to this derivative?")
end

if opt == "a" || opt == "c" 
    if O == "second order" && D == "centered difference"
        disp("This is correct.")
        flag = 1;
    elseif O ~= "second order" && D == "centered difference"
        disp("This is the correct method, but the incorrect order.")
    elseif O == "second order"
        disp("This is the correct order, but the incorrect method.")
    else
        disp("This is neither the correct order nor the correct method.")
    end
end

if opt == "b"
    if O == "first order" && D == "forward difference"
        disp("This is correct.")
        flag = 1;
    elseif O ~= "second order" && D == "forward difference"
        disp("This is the correct method, but the incorrect order.")
    elseif O == "second order"
        disp("This is the correct order, but the incorrect method.")
    else
        disp("This is neither the correct order nor the correct method.")
    end
end

end
%[text] 
function T = SolveHeatEqn(T_initial,Nr,Nz,Nt,k,dt,dr,r,dz,rho,cp,z,Q,BCFunHandle) %[text:anchor:M_8e42]
%[text] Return to [final Try](internal:M_745a).
% Initial condition
T = T_initial*ones(Nr,Nz,Nt);

% Heat Equation Solver
for kTime = 1:Nt-1
    for iRadial = 2:Nr-1
        for jLength = 2:Nz-1
            Laplacian = (T(iRadial+1,jLength,kTime) - 2*T(iRadial,jLength,kTime) + ...
                T(iRadial-1,jLength,kTime))/dr^2 + (1/r(iRadial))*(T(iRadial+1,jLength,kTime) ...
                - T(iRadial-1,jLength,kTime))/(2*dr) + (T(iRadial,jLength+1,kTime) ...
                - 2*T(iRadial,jLength,kTime) + T(iRadial,jLength-1,kTime))/dz^2;
            T(iRadial,jLength,kTime+1) = T(iRadial,jLength,kTime) + ...
                dt*(k/(rho*cp)*Laplacian + Q/(rho*cp));
        end
    end
    T = BCFunHandle(T,kTime,Nz,Nr);
end

p = mesh(z,r,T(:,:,1));
xlabel('Height (cm)')
ylabel('Radius (cm)')
zlabel('Temperature (°C)')
zlim([min(T,[],"all")-1 max(T,[],"all")]+1)
clim([min(T,[],"all") max(T,[],"all")])
title('Temperature Distribution in the Battery Over Time')

% Plotting
for tVal = -500:100:Nt
    if tVal <= 0
        p.ZData = T(:,:,1);
    else
        p.ZData = T(:,:,tVal);
    end
    drawnow
end
end

%[text] 
function CheckEx2(opts)
arguments
    opts.Pa (1,1) string {mustBeMember(opts.Pa,["unknown" "t" "r" "z"])} = "unknown"
    opts.Pb (1,1) double {mustBeMember(opts.Pb,0:6)} = 0
    opts.Pc (1,1) double {mustBeMember(opts.Pc,0:10)} = 0
end

if opts.Pa == "unknown" && opts.Pb == 0 && opts.Pc == 0 
    disp("This is a default value." + newline + ...
        "Please select non-default values to continue.")
    return
end

opts1 = ["temporal" "radial" "spatial"];
opts2 = ["T(0,z,t) == 20+0.01*t" "T(R,z,t) == 20+0.01*t" "T(r,0,t) == 20+0.01*t" ...
    "T(r,L,t) == 20+0.01*t" "dT/dt(r,0,t) == 20" "dT/dt(r,L,t) == 20"];
opts3 = ["T(Nr,:,kTime+1) = 6" "T(Nr,:,kTime+1) = -6"...
    "T(Nr,:,kTime+1) = 6*dr + T(Nr,:,kTime)" "T(Nr,:,kTime+1) = 6*dr + T(Nr-1,:,kTime+1)" ...
 "T(Nr,:,kTime+1) = -6*dr + T(Nr,:,kTime)" "T(Nr,:,kTime+1) = -6*dr + T(Nr-1,:,kTime+1)" ...
 "T(Nr,:,kTime+1) = -6 + T(Nr,:,kTime)" "T(Nr,:,kTime+1) = -6 + T(Nr-1,:,kTime+1)" ...
 "T(Nr,:,kTime+1) = 6 + T(Nr,:,kTime)" "T(Nr,:,kTime+1) = 6 + T(Nr-1,:,kTime+1)"];

if opts.Pa ~= "unknown"
    disp("Part a)" + newline + "You have selected a " + opts1(opts.Pa==["t" "r" "z"]) + " loop.")
    if opts.Pa == "t"
        disp("This is correct.")
        flags(1) = 1;
    else
        disp("This is incorrect.")
        flags(1) = 0;
    end
else
    flags(1) = -1;
end

if opts.Pb > 0 
    syms T(r,z,t) R L 
    disp("Part b)" + newline + "You have selected")
    displayFormula(opts2(opts.Pb))
    if opts.Pb ~= 3
        disp("This is incorrect.")
        flags(2) = 0;
    else
        disp("This is correct.")
        flags(2) = 1;
    end
else
    flags(2) = -1;
end

if opts.Pc > 0
    disp("Part c)" + newline + "You have selected")
    disp(opts3(opts.Pc))
    if opts.Pc ~= 4
        disp("This is incorrect.")
        flags(3) = 0;
    else
        disp("This is correct.")
        flags(3) = 1;
    end
else
    flags(3) = -1;
end
Parts = ["a";"b";"c"];
Parts = Parts(flags~= -1);
disp("Please resubmit Part " + Parts(logical(~flags)) + ").")
end
%[text] 
function CheckEx3(T,T_initial)
load("BTMSTEx3.mat","Tsoln")
flag = 0;

if all(T(end,:,end) == T_initial)
    disp("You have not yet updated the correct boundary condition.")
    flag = -1;
elseif all(T(end,:,end) == Tsoln)
    disp("You have correctly updated the boundary conditions.")
    flag = 1;
elseif sum(T_initial == T(end,:,end)) == 2
    disp("You may have correctly updated the boundary conditions." + newline + ...
        "Is T_initial = 20?")
else
    disp("These values are not the ones expected.")
end

if flag == 0
    disp("Please try again.")
end
end
%[text] 
function T = InsulatedBCs(T,kTime,Nz,Nr)
    % Boundary conditions: Insulated surfaces
    T(1,:,kTime+1) = T(2,:,kTime+1);     % Radial symmetry at r=0
    T(Nr,:,kTime+1) = T(Nr-1,:,kTime+1); % Insulated outer surface
    T(:,1,kTime+1) = T(:,2,kTime+1);     % Insulated at z=0
    T(:,Nz,kTime+1) = T(:,Nz-1,kTime+1); % Insulated at z=L
end

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline"}
%---
%[text:image:21b9]
%   data: {"align":"middle","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAjElEQVR42mP4\/\/8\/AwgnJiYapKamfgfS\/ynBUDMMYOYywBggiYcPH\/6nFIDMAJmFYQHIdmoBqFm4LZjrYPd\/gpoyGIPYVLeA5j6gmwUlJaVAxUlgDGKPBhFODaQG1QgIoqKtr\/6r99wlCYP0EG0BSMOWe\/9JwiA9oxaMWkBHC2ieD2iSk+lR6dOk2QIAjF+EgB\/BqfoAAAAASUVORK5CYII=","width":24}
%---
%[text:image:9601]
%   data: {"align":"baseline","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAsCAYAAAAXb\/p7AAADlklEQVR42u1YS0hUYRQejR4UvR+SvaCyWiS2DIoCKWjVYzG2SsYWQ+a8HRwXFkOgqdGLSoSeqyBaJUGLCKGkNpGtgiyScnpYBpaU5au+E+eH03Wu93rvP2OEFw46955z\/u8\/7\/\/3eDQ+4XD4Eui65199AK4d1DEJcBLgfw0wGo2ujkQi1yoqKlY5AFgDqnWw5lpaMxaLrbBkDgaDm7HIEKjTCcjxPqFQqABrdYEGsHaRXaESCAyCXpNFMwwuReDw\/77xusurQGJna0ysPR2K94CnGdQKesnUyu92J5PJaelk4c51Chzcu9dp0O9nkO3yvd\/vnwqlEbzvAf2yoB5sIkwyBt0doJ+0Qbdu2AXyC8UrOVuNQH5Q3IJegfrTfH8ikwC\/A9hjsdaYCQQCG6D4vVj0DShB7+HKXMGaQ\/EFADEGrPhJdn1GAhoZvRDKX4jFTvt8vhlWchSD4D0OGiE5AH9eXl4+PxNF+IoCB8sccyBfreQB8qJWcAC0CYqHeYE2cqEDNTmQvcc6hlC+CnXWq\/PCtTtdeGGr0HNWFz7aeTcr\/eT1eqe41PVWJYxd62zkovwXqQ6Cv8vErm9r8MZNEctLVf9Ph4GwecSOjPSQu8V28e6chmRrFPq28btHJhhSBKDIBH0B726HEDilAWCtsGCx6MmjMNgaHqBkiygPl3UmHE1OrjOEiqoqsqDHGizYxrqGAXCOriL9jJUOoq3lO9UDQItpQGD3PtXZRapFHB51oSchwiWsDWA8Hl8Cpb2svA+WWO4AXJ7Q0Z1IJObq7sUBN\/UQLr0hrHfANSCaQihrobiBf+dC+QOxSNk4MrdEyN1VvRy6T+DdVbOp2wpcCyutN8yDahjtVZ3A4sS2ALwflYxhaK1n0C22QfL8dkuNRYZBlKxxRLj6gg3XNgj+w8beLOriHcv50gocJ8wsfP\/ASgfMDlRs8XzwfGPeThMr2QcpEqFprJmPSoSwSvMYfCcFX6nFlNPEfAGrUuC1GkhxQpspTnTfKysrFxl5qqqqZouy0mU81ZmApB6cp2vKlrFVk+Z7TGRuPOsXRZSNfGYmEO\/ofoXmOiKKS3Ga6wPYeRNxk9Vo49BONAIL1mUdIBa9bxPgn+zMOkAqIXDdQbp1sKAy6uWeyWd0Cyuk5LDh3pTtez\/NSVJqNwbh5kNZB8htkTrP1zHA9dM1nZ07nExmc50ZQGA7M+GxyLden9MA\/OLm\/KKe34xPoKAD7jPkAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:563b]
%   data: {"align":"baseline","height":23,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADoAAAA6CAYAAADhu0ooAAAEp0lEQVR42t2a208TQRTG67OJxvv9fiGoD6LGgPiCGo1G\/wljTKDl1pL00RuKIKCIIiKg6ItB8IJ38K4Panz13RcfSBBBQQHRek4ys\/kYpu1uu2132+Sku6eb6X7zmzlz5ux6PEn6lJaWbi0uLu4mGyLrJWvMz8+f4UmnjxA5QhZS7HNZWdnUdNE5hQR9EsLGioqKWuj7kRRbUlJSmS40D4Co4yD+rfAPEdW5rhdKQj4KQQM4J0n0DhjCVW4XuR9oHlV\/J98rSZVsnmuF0nz8oNIsLCxcFQwGp4vf86AjzrhV5D4dTTq+Tr8d0VD95fP5Frpx2L4XAgYlTQpMq+n8DxKm4+0wV6tdJZIo7YWbPwbi26QfqdL5S+H\/7SqqdMPvJE2iOFPOTUEzpM5bpEodUOMWkXs06yb7r6qZEc5dOn\/hKqqQCESiOYkqic4Ff62jRZKg3XCzJ0B8q0akjupzSZU6aZGTl5Q34kZ\/BgKB2ezzer3LOMcNJ5SpSvJIlY7POTWn3QUBpRzEt0QQqYvMzxxNlW7staRJQ3gO0Bw1IdSYz9Qx28Bf57QhuxNu7iSIbzYhclKEpvZ6HElVR5OOl5qkGZEqdcB5p9DMC0OzyYJIXaTuFr4R6rzFTkj3jK1WHDRDarSmdnPAX59qkbkQaU+B\/7IqglM7+g4qVqu5rhzaeeoIqpC2RaVJN52pGfYbdFRlW0iVrr2QcppkFSC+MUxUNSt0AlU6f5JSqpCuGcUtv9+\/JExZ05JQpErf2eC\/mOxIi4v6aRDfEGGdtCJUjeCPhW+Uk5BkCu2xQjNGoQZVWl+30Pk\/4W9I1tzM0RWfeVhFyXysCp0QyaHoPUZtLU\/G3OxWadIfL+Dilt1CMZrTtZuB6qVE7zezdUVnDv0mctlYhKpUHyaFKoR6SzTjEYr\/pVBtTDhNLDZz0m1ydxKrUHWdfiCp+ny+FYmgKUP8sHx8YJamDUK1VDnVtHs5wSFTDeLrLOw34xGqrtf3E0IVgoBRiiwoKJhvlqZNQjEubIKOb7Jr3TQaxeIyF6+sbMFsEKqu2\/ZShQZVmsPJFhqOKrVzxTaaWFTW7SNNCD3IlUI08h2KYXOO63eXpErtrYwnCHWpNDniWqVpsxlUacnLAhDNsa6bWTqaolIQSrFVwei6FxdVGlZ3baY5SNav2KCdVLlYblXkRqB5FnqvOlYKNgWjUJjsTEIZpzbXWIm0d9QCMlfneI\/oFKFKhoZgWs0GIP7zv+qDHu7BeOZVAoSqWZqEM+73+9eaodlpN80ECjXiBwLih87Rnoith4vrgGZlvJEyQUJVqrdNUaULOmRp0U6a8uUMssNo\/BDYBqHDnKlppt21qDTxwQ7vGhywbkbrxBrN1Bsny9DRbFcLxV6vdxad\/3C6UJyryvRrU7OgdfBjPYivcIHIkCYX79BSpZObLqYZkSq\/kicjaqZ04oMcrpS7SGRIzeJIy60JVDk6SZpcbRdDeRr5v2hyU6fbV\/l8VVlXm5lcX0wJsTveYpMVw14PzMOGNBQqE4h+3M8x5hti3UwH64S52y6D0YALA49Z6+P3hCXiDLH2fEsjgd+ZKr9wyRr\/A+UKAPezYlA8AAAAAElFTkSuQmCC","width":23}
%---
%[text:image:869e]
%   data: {"align":"baseline","height":20,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADUAAAAxCAYAAAB6d+FmAAAC0ElEQVR42u2aO4gTURSGs6Lugo1WW2ghgiyCr1VWbRSR9YEgKoKohcQmEDAviYhBIaVbbKEWYi22YidoobUItoqwjSui6wt119Wsj+\/onXAcJslMZpI7AxP4Sbh37pnz3TP3zJ2TyWQS9imVStvRK1G5XL5ZqVRWZpL8MUCf0G+lz+hYIoGIyDYPIEc\/i8ViLmkRGkMfWwA5WkD7EwHEutmCs+87ADl6zfHLm4MLhcIqGs7RcV0WoA1xCa3vIkL\/CTsX\/w7G2Bka5oIMjlo4M6GBmOTRABHSeirh3S0LzSYQugHHgAPEJG+l7UOXtr6LgQeqYQZdRVf6Jc5frdfriyKIkOgHQToi1+0XpxGD+ywnhc348a5bICboqLMYmx02784hgRYAOqEzjHWoSIHiABU5kG2osECMP9lqC2IFiqS0qSdAtqAM0Ey3QOhUp81iX6F6DtRvKM6xsedA\/YQKCdQgyx0PcrKeQ4WNkE4K+LhGb6usQOHQOnnOCb31+WdrNW1TQC22BoW9Ddh9i6bRfNDdNkCH1c59LW0vpc8qFDYfo\/tkvMFqtbqM3xdkffgAmseXQ44dM3ba6bcGlc1mh9yzbaK3k\/Y37YAYc9Dl47A+xhoU0dlh7A579I3qRx6lbwAd8PAxHlA4V5BF3ea8Z11Ac62e52IDhb1bZuZL+lFdRWtQpflZzj3exlZsIvVc2b7jdW8xiWSWVL2ng4\/2ofL5\/Ars\/XJdXudN9wC\/R4Ce5PurFH58RN0+FLb2et130D1VVJlCu3zasw9FFC67dwboialUnZadQcBJsg+F09ewd9tkwLFcLrckZOTjkSgi3pmkUClUCpVCpVApVAqVQqVQ0UDp6s5IHKFMeaz5doufYuYz9bf\/XXmXQaqgcZH4I34pqBd+Qluz\/LpBUF3qCEUol3LgwyQAEbFHUrDxW6OTyk7NFEsaMYNpGL9qfoH+AOOEPfJuI6OmAAAAAElFTkSuQmCC","width":22}
%---
%[control:dropdown:2b66]
%   data: {"defaultValue":"\"unknown\"","itemLabels":["unknown","first order","second order","third order"],"items":["\"unknown\"","\"first order\"","\"second order\"","\"third order\""],"label":"The order is: ","run":"Nothing"}
%---
%[control:dropdown:5880]
%   data: {"defaultValue":"\"unknown\"","itemLabels":["unknown","central difference","forward difference","backward difference"],"items":["\"unknown\"","\"centered difference\"","\"forward difference\"","\"backward difference\""],"label":"Formula type: ","run":"Nothing"}
%---
%[control:button:1170]
%   data: {"label":"Check solution","run":"Section"}
%---
%[control:dropdown:499a]
%   data: {"defaultValue":"\"unknown\"","itemLabels":["unknown","first order","second order","third order"],"items":["\"unknown\"","\"first order\"","\"second order\"","\"third order\""],"label":"The order is: ","run":"Nothing"}
%---
%[control:dropdown:79d0]
%   data: {"defaultValue":"\"unknown\"","itemLabels":["unknown","central difference","forward difference","backward difference"],"items":["\"unknown\"","\"centered difference\"","\"forward difference\"","\"backward difference\""],"label":"Formula type: ","run":"Nothing"}
%---
%[control:button:1726]
%   data: {"label":"Check solution","run":"Section"}
%---
%[control:dropdown:11d5]
%   data: {"defaultValue":"\"unknown\"","itemLabels":["unknown","first order","second order","third order"],"items":["\"unknown\"","\"first order\"","\"second order\"","\"third order\""],"label":"The order is: ","run":"Nothing"}
%---
%[control:dropdown:7799]
%   data: {"defaultValue":"\"unknown\"","itemLabels":["unknown","central difference","forward difference","backward difference"],"items":["\"unknown\"","\"centered difference\"","\"forward difference\"","\"backward difference\""],"label":"Formula type: ","run":"Nothing"}
%---
%[control:button:336d]
%   data: {"label":"Check solution","run":"Section"}
%---
%[text:image:04dc]
%   data: {"align":"baseline","height":20,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADUAAAAxCAYAAAB6d+FmAAAC0ElEQVR42u2aO4gTURSGs6Lugo1WW2ghgiyCr1VWbRSR9YEgKoKohcQmEDAviYhBIaVbbKEWYi22YidoobUItoqwjSui6wt119Wsj+\/onXAcJslMZpI7AxP4Sbh37pnz3TP3zJ2TyWQS9imVStvRK1G5XL5ZqVRWZpL8MUCf0G+lz+hYIoGIyDYPIEc\/i8ViLmkRGkMfWwA5WkD7EwHEutmCs+87ADl6zfHLm4MLhcIqGs7RcV0WoA1xCa3vIkL\/CTsX\/w7G2Bka5oIMjlo4M6GBmOTRABHSeirh3S0LzSYQugHHgAPEJG+l7UOXtr6LgQeqYQZdRVf6Jc5frdfriyKIkOgHQToi1+0XpxGD+ywnhc348a5bICboqLMYmx02784hgRYAOqEzjHWoSIHiABU5kG2osECMP9lqC2IFiqS0qSdAtqAM0Ey3QOhUp81iX6F6DtRvKM6xsedA\/YQKCdQgyx0PcrKeQ4WNkE4K+LhGb6usQOHQOnnOCb31+WdrNW1TQC22BoW9Ddh9i6bRfNDdNkCH1c59LW0vpc8qFDYfo\/tkvMFqtbqM3xdkffgAmseXQ44dM3ba6bcGlc1mh9yzbaK3k\/Y37YAYc9Dl47A+xhoU0dlh7A579I3qRx6lbwAd8PAxHlA4V5BF3ea8Z11Ac62e52IDhb1bZuZL+lFdRWtQpflZzj3exlZsIvVc2b7jdW8xiWSWVL2ng4\/2ofL5\/Ars\/XJdXudN9wC\/R4Ce5PurFH58RN0+FLb2et130D1VVJlCu3zasw9FFC67dwboialUnZadQcBJsg+F09ewd9tkwLFcLrckZOTjkSgi3pmkUClUCpVCpVApVAqVQqVQ0UDp6s5IHKFMeaz5doufYuYz9bf\/XXmXQaqgcZH4I34pqBd+Qluz\/LpBUF3qCEUol3LgwyQAEbFHUrDxW6OTyk7NFEsaMYNpGL9qfoH+AOOEPfJuI6OmAAAAAElFTkSuQmCC","width":22}
%---
%[control:dropdown:3f23]
%   data: {"defaultValue":"\"unknown\"","itemLabels":["unknown","a temporal loop","a radial loop","a spatial loop"],"items":["\"unknown\"","\"t\"","\"r\"","\"z\""],"label":"This code is: ","run":"Section"}
%---
%[control:dropdown:31f8]
%   data: {"defaultValue":"0","itemLabels":["unknown","T(0,z,t) = 20+0.01t","T(R,z,t) = 20+0.01t","T(r,0,t) = 20+0.01t","T(r,L,t)  = 20+0.01t","dT\/dt(r,0,t) = 20","dT\/dt(r,L,t) = 20"],"items":["0","1","2","3","4","5","6"],"label":"The boundary condition is: ","run":"Section"}
%---
%[control:dropdown:925f]
%   data: {"defaultValue":"0","itemLabels":["default","T(Nr,:,kTime+1) = 6","T(Nr,:,kTime+1) = -6","T(Nr,:,kTime+1) = 6*dr + T(Nr,:,kTime)","T(Nr,:,kTime+1) = 6*dr + T(Nr-1,:,kTime+1)","T(Nr,:,kTime+1) = -6*dr + T(Nr,:,kTime)","T(Nr,:,kTime+1) = -6*dr + T(Nr-1,:,kTime+1)","T(Nr,:,kTime+1) = -6 + T(Nr,:,kTime)","T(Nr,:,kTime+1) = -6 + T(Nr-1,:,kTime+1)","T(Nr,:,kTime+1) = 6 + T(Nr,:,kTime)","T(Nr,:,kTime+1) = 6 + T(Nr-1,:,kTime+1)"],"items":["0","1","2","3","4","5","6","7","8","9","10"],"label":"The BC is: ","run":"Section"}
%---
%[text:image:141b]
%   data: {"align":"baseline","height":20,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADUAAAAxCAYAAAB6d+FmAAAC0ElEQVR42u2aO4gTURSGs6Lugo1WW2ghgiyCr1VWbRSR9YEgKoKohcQmEDAviYhBIaVbbKEWYi22YidoobUItoqwjSui6wt119Wsj+\/onXAcJslMZpI7AxP4Sbh37pnz3TP3zJ2TyWQS9imVStvRK1G5XL5ZqVRWZpL8MUCf0G+lz+hYIoGIyDYPIEc\/i8ViLmkRGkMfWwA5WkD7EwHEutmCs+87ADl6zfHLm4MLhcIqGs7RcV0WoA1xCa3vIkL\/CTsX\/w7G2Bka5oIMjlo4M6GBmOTRABHSeirh3S0LzSYQugHHgAPEJG+l7UOXtr6LgQeqYQZdRVf6Jc5frdfriyKIkOgHQToi1+0XpxGD+ywnhc348a5bICboqLMYmx02784hgRYAOqEzjHWoSIHiABU5kG2osECMP9lqC2IFiqS0qSdAtqAM0Ey3QOhUp81iX6F6DtRvKM6xsedA\/YQKCdQgyx0PcrKeQ4WNkE4K+LhGb6usQOHQOnnOCb31+WdrNW1TQC22BoW9Ddh9i6bRfNDdNkCH1c59LW0vpc8qFDYfo\/tkvMFqtbqM3xdkffgAmseXQ44dM3ba6bcGlc1mh9yzbaK3k\/Y37YAYc9Dl47A+xhoU0dlh7A579I3qRx6lbwAd8PAxHlA4V5BF3ea8Z11Ac62e52IDhb1bZuZL+lFdRWtQpflZzj3exlZsIvVc2b7jdW8xiWSWVL2ng4\/2ofL5\/Ars\/XJdXudN9wC\/R4Ce5PurFH58RN0+FLb2et130D1VVJlCu3zasw9FFC67dwboialUnZadQcBJsg+F09ewd9tkwLFcLrckZOTjkSgi3pmkUClUCpVCpVApVAqVQqVQ0UDp6s5IHKFMeaz5doufYuYz9bf\/XXmXQaqgcZH4I34pqBd+Qluz\/LpBUF3qCEUol3LgwyQAEbFHUrDxW6OTyk7NFEsaMYNpGL9qfoH+AOOEPfJuI6OmAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:0351]
%   data: {"align":"baseline","height":26,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAApCAYAAAAiT5m3AAADOElEQVR42r1XSWgUQRSNGndR3Ii7V\/EmCCp4DaIe1Oh4EMHBwMjsq47Eg+OOJ0VIICAeFAIeXEADHgyoqChE1ASNhISAxH0jg5gxq+\/FX1A009PTM93T8OiuX7\/q1f+\/+tevqqoCTyKRWBmNRo8Cj4GPwF++I5HII7zT8Xh8eZWTTzgcnh6Lxc5j8kFgHMgCT4G7wBPgl8j\/YBGnfT7f1LJJg8HgQrGQE3diAXVciK5DIsi3o7+devh+4Pf755dMmslkpmGih0LaiHa1hf5k6J0T\/TYrfdMHKz8pFjTr1kFWD9ltvJ8Bt\/Dt1d0rYeG4Y7ZJMbAG+A300HLKuHkw2SuxKAe8lQ3Gdjv6llLP4\/FMQfs1MMBQ2SUOyaoPihur0X4BDGEDHVGLYbwhawCG6QG6W6yu43jo+uwSt3IyWLlA2vt09+F7CwlDodAaaZ+Q\/j3inZn0GENil\/gd0Ke1rwEjgUBgDqzYIe4lBiBbkkqlZov7r2hjXtLldom\/0LVa+x7QK9+NGjHduUvkfcAdbUwb0G+XuNtg8WV6QeLXbCDeKzo9QJM2phPosEt8ExijG9nG5NuKJK6VTTeXrofudbvEh2TS49r\/eakQMeQXNV2v9Nfbzc9c8U\/GWv2LKkmYEat+r9c7Q+L9nZvOdhLBhOF86c+MWJ5JkLVIX6jUdM1Jbsgk3NU1RRBPHCzQ2crxZR0U3CBC8saKGO3NCNNGx85kpk4QPLfaXJr8jGPkKs4FfqesJv9kcP1OvFeXa70Z8Ygmz1KWTCYX4fuDqlAQhnUVIWafQfesXjjgF5zlCrGWSBQuyOm1nuEARqGTqRgxKxejrm1iYL+URKPFEktJrGSDpRJ3aYlGYRhFwjK8T+lyle+1yrUsYjMM5ZG9l0tBzk3iYvGfWE6XVWYniyvEci1RgjEpZwP6Itwi7jfppHy31Mz3HSeGNZvw8aOAUs5h0olUqqqPFVIhjlcI34wXsMMuWWhEb76ibwPw1U1ibmCzwm+tdil3HEyfhcrdBhetbrW6pHe5RNxiVeTXukTcVEyevupCjA9YEqfT6XlyGXOKuINnQ1GnEy9y6uJeBuFn3qXxxyzmnP8Amz0wy7TM4YgAAAAASUVORK5CYII=","width":19}
%---
%[text:image:7f15]
%   data: {"align":"bottom","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAsCAYAAAAXb\/p7AAADlklEQVR42u1YS0hUYRQejR4UvR+SvaCyWiS2DIoCKWjVYzG2SsYWQ+a8HRwXFkOgqdGLSoSeqyBaJUGLCKGkNpGtgiyScnpYBpaU5au+E+eH03Wu93rvP2OEFw46955z\/u8\/7\/\/3eDQ+4XD4Eui65199AK4d1DEJcBLgfw0wGo2ujkQi1yoqKlY5AFgDqnWw5lpaMxaLrbBkDgaDm7HIEKjTCcjxPqFQqABrdYEGsHaRXaESCAyCXpNFMwwuReDw\/77xusurQGJna0ysPR2K94CnGdQKesnUyu92J5PJaelk4c51Chzcu9dp0O9nkO3yvd\/vnwqlEbzvAf2yoB5sIkwyBt0doJ+0Qbdu2AXyC8UrOVuNQH5Q3IJegfrTfH8ikwC\/A9hjsdaYCQQCG6D4vVj0DShB7+HKXMGaQ\/EFADEGrPhJdn1GAhoZvRDKX4jFTvt8vhlWchSD4D0OGiE5AH9eXl4+PxNF+IoCB8sccyBfreQB8qJWcAC0CYqHeYE2cqEDNTmQvcc6hlC+CnXWq\/PCtTtdeGGr0HNWFz7aeTcr\/eT1eqe41PVWJYxd62zkovwXqQ6Cv8vErm9r8MZNEctLVf9Ph4GwecSOjPSQu8V28e6chmRrFPq28btHJhhSBKDIBH0B726HEDilAWCtsGCx6MmjMNgaHqBkiygPl3UmHE1OrjOEiqoqsqDHGizYxrqGAXCOriL9jJUOoq3lO9UDQItpQGD3PtXZRapFHB51oSchwiWsDWA8Hl8Cpb2svA+WWO4AXJ7Q0Z1IJObq7sUBN\/UQLr0hrHfANSCaQihrobiBf+dC+QOxSNk4MrdEyN1VvRy6T+DdVbOp2wpcCyutN8yDahjtVZ3A4sS2ALwflYxhaK1n0C22QfL8dkuNRYZBlKxxRLj6gg3XNgj+w8beLOriHcv50gocJ8wsfP\/ASgfMDlRs8XzwfGPeThMr2QcpEqFprJmPSoSwSvMYfCcFX6nFlNPEfAGrUuC1GkhxQpspTnTfKysrFxl5qqqqZouy0mU81ZmApB6cp2vKlrFVk+Z7TGRuPOsXRZSNfGYmEO\/ofoXmOiKKS3Ga6wPYeRNxk9Vo49BONAIL1mUdIBa9bxPgn+zMOkAqIXDdQbp1sKAy6uWeyWd0Cyuk5LDh3pTtez\/NSVJqNwbh5kNZB8htkTrP1zHA9dM1nZ07nExmc50ZQGA7M+GxyLden9MA\/OLm\/KKe34xPoKAD7jPkAAAAAElFTkSuQmCC","width":22}
%---
