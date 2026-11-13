# <span style="color:rgb(213,80,0)">Applied Partial Differential Equations</span>

MATLAB R2025a or newer is required for the current plain-text live scripts. For MATLAB R2024b or older, use the [legacy MLX release](https://github.com/MathWorks-Teaching-Resources/Applied-PDEs/releases/tag/mlx).

Learn how to classify PDEs,and apply and visualize characteristic and finite difference solution methods.

<a id="H_053613DF"></a>


[![View on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/172650-applied-partial-differential-equations) [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=README.m)

[![MATLAB Versions Tested](https://img.shields.io/endpoint?url=https://mathworks-teaching-resources.github.io/Applied-PDEs/TestedWith.json)](https://mathworks-teaching-resources.github.io/Applied-PDEs)

**Curriculum Module**

_Created with R2024a. Current version requires R2025a or newer._  
For MATLAB R2024b or older, use the [legacy MLX release](https://github.com/MathWorks-Teaching-Resources/Applied-PDEs/releases/tag/mlx).


# Information

This curriculum module contains interactive [MATLAB® live scripts](https://www.mathworks.com/products/matlab/live-editor.html) that teach various topics suitable for a first class in partial differential equations.

<a id="H_F00D98E4"></a>

## Background

You can use these live scripts as demonstrations in lectures, class activities, or interactive assignments outside class. This module covers classification of second\-order PDEs, solving first order wave equations analytically, solving second order wave equations numerically, systems of partial differential equations, and implementing both explicit and implicit finite difference methods. It also includes examples of shocks and rarefaction waves in traffic, diffusion of carbon through iron, a chemical morphogenesis model, a thermal model of a battery, and an approach to modeling an ultrasound.

The instructions inside the live scripts will guide you through the exercises and activities. Get started with each live script by running it one section at a time. To stop running the script or a section midway (for example, when an animation is in progress), use the <img src="Images/EndIcon.png" width="19" alt="EndIcon.png"> Stop button in the **RUN** section of the **Live Editor** tab in the MATLAB Toolstrip.

## Contact Us

Contact the [MathWorks Educator Content Development Team](mailto:onlineteaching@mathworks.com) if you would like to request assistance, provide feedback, or if you have a question.

<a id="H_30BC7141"></a>

## Prerequisites

This module assumes fluent knowledge of single\-variable calculus. If you would like to brush up on these topics, you could review with the calculus courseware:

- [Calculus: Integrals ](https://www.mathworks.com/matlabcentral/fileexchange/105740-calculus-integrals)is available on [<img src="Images/OpenInFX.png" width="91" alt="OpenInFX.png">](https://www.mathworks.com/matlabcentral/fileexchange/105740-calculus-integrals) or [<img src="Images/OpenInMO.png" width="136" alt="OpenInMO.png">](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Calculus-Integrals&project=Integrals.prj&file=README.mlx) or [GitHub](https://github.com/MathWorks-Teaching-Resources/Calculus-Integrals)
- [Calculus: Derivatives](https://www.mathworks.com/matlabcentral/fileexchange/99249-calculus-derivatives) is available on [<img src="Images/OpenInFX.png" width="91" alt="OpenInFX.png">](https://www.mathworks.com/matlabcentral/fileexchange/99249-calculus-derivatives) or [<img src="Images/OpenInMO.png" width="136" alt="OpenInMO.png">](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Calculus-Derivatives&project=Derivatives.prj&file=README.mlx) or [GitHub](https://github.com/MathWorks-Teaching-Resources/Calculus-Derivatives)

To review or expand your multivariable calculus knowledge:

- [Multivariable: Derivatives](https://www.mathworks.com/matlabcentral/fileexchange/184323-multivariable-derivatives) is available on [<img src="Images/OpenInFX.png" width="91" alt="OpenInFX.png">](https://www.mathworks.com/matlabcentral/fileexchange/184323-multivariable-derivatives) or [<img src="Images/OpenInMO.png" width="136" alt="OpenInMO.png">](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Multivariable-Derivatives&project=Derivatives.prj&file=README.m) or [GitHub](https://github.com/MathWorks-Teaching-Resources/Multivariable-Derivatives)
- [Multivariable: Integrals](https://www.mathworks.com/matlabcentral/fileexchange/181588-multivariable-integrals) is available on [<img src="Images/OpenInFX.png" width="91" alt="OpenInFX.png">](https://www.mathworks.com/matlabcentral/fileexchange/181588-multivariable-integrals) or [<img src="Images/OpenInMO.png" width="136" alt="OpenInMO.png">](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Multivariable-Integrals&project=Integrals.prj&file=README.mlx) or [GitHub](https://github.com/MathWorks-Teaching-Resources/Multivariable-Integrals)

<a id="H_330E72C3"></a>

## Getting Started

### Accessing the Module

### **On MATLAB Online:**

Use the [<img src="Images/OpenInMO.png" width="136" alt="OpenInMO.png">](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=README.m) link to download the module. You will be prompted to log in or create a MathWorks account. The project will be loaded, and you will see an app with several navigation options to get you started.

### **On Desktop:**

Download or clone this repository. Open MATLAB, navigate to the folder containing these scripts and double\-click [AppliedPDEs.prj](<matlab: openProject("AppliedPDEs.prj")>). It will add the appropriate files to your MATLAB path and open an app that asks you where you would like to start. 

Ensure you have all the required products ([listed below](#H_E850B4FF)) installed. If you need to include a product, add it using the Add\-On Explorer. To install an add\-on, go to the **Home** tab and select  <img src="Images/AddOnsIcon.png" width="16" alt="AddOnsIcon.png"> **Add-Ons** > **Get Add-Ons**. 

<a id="H_E850B4FF"></a>

## Products

MATLAB is used throughout. Tools from the Symbolic Math Toolbox™ are also frequently used. The function `range` from the Statistics and Machine Learning Toolbox™ is used in `Diffusion.m` and the Partial Differential Equation Toolbox™ is used in `ReactionDiffusion.m`, in an extension example.

# Scripts
<a id="H_DB6EB26B"></a>

## [Classification.m](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=Scripts/Classification.m) 
||||
| :-- | :-- | :-- |
| <img src="Images/Classification.png" width="171" alt="Classification.png"> <br>  | **In this script, students will...** <br> $\bullet$ Review the terminology of classifying differential equations including homogeneity, order, and linearity. <br> $\bullet$ Classify second\-order PDEs as elliptic, parabolic, or hyperbolic. <br>  | **Academic disciplines** <br> $\bullet$ Mathematics <br>   |

<a id="H_BC8955C0"></a>

## [MethodOfCharacteristics.m](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=Scripts/MethodOfCharacteristics.m) 
||||
| :-- | :-- | :-- |
| <img src="Images/CharactericsticCurve.png" width="171" alt="CharactericsticCurve.png"> <br>  | **In this script, students will...** <br> $\bullet$ Solve a transport equation using the method of characteristic lines. <br> $\bullet$ Investigate applying the method of characteristics to first\-order 1\-D PDEs with nonconstant coefficients. <br>  | **Academic disciplines** <br> $\bullet$ Mathematics <br>   |

<a id="H_C7ED4582"></a>

## [TrafficModel.m](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=Scripts/TrafficModel.m) 
||||
| :-- | :-- | :-- |
| <img src="Images/CharacteristicCurveWithShock.png" width="171" alt="CharacteristicCurveWithShock.png"> <br>  | **In this script, students will...** <br> $\bullet$ Calculate a simple traffic model involving a nonlinear transport equation. <br> $\bullet$ Identify and resolve rarefaction regions in a characteristic plot. <br> $\bullet$ Identify and resolve shocks in a characteristic plot. <br>  | **Academic disciplines** <br> $\bullet$ Mathematics <br>   |

<a id="H_D89790CD"></a>

## [FiniteDifference.m](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=Scripts/FiniteDifference.m) 
||||
| :-- | :-- | :-- |
| <img src="Images/Discretizing.png" width="171" alt="Discretizing.png"> <br>  | **In this script, students will...** <br> $\bullet$ Implement an explicit method. <br> $\bullet$ Implement an implicit method <br> $\bullet$ Implement a Crank\-Nicolson solver <br>  | **Academic disciplines** <br> $\bullet$ Mathematics <br>   |

<a id="H_4A0D87AA"></a>

## [Diffusion.m](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=Scripts/Diffusion.m) 
||||
| :-- | :-- | :-- |
| <img src="Images/Diffusion.gif" width="171" alt="Diffusion.gif"> <br>  | **In this script, students will...** <br> $\bullet$ Explore the basic theory of diffusion and the diffusion equation. <br> $\bullet$ Implement a finite difference solution for the diffusion equation. <br> $\bullet$ Visualize the results of diffusion simulations. <br>  | **Academic disciplines** <br> $\bullet$ Mathematics <br> $\bullet$ Materials science <br> $\bullet$ Chemical engineering <br>   |

<a id="H_19125913"></a>

## [ReactionDiffusion.m](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=Scripts/ReactionDiffusion.m) 
||||
| :-- | :-- | :-- |
| <img src="Images/ReactionDiffusion.gif" width="171" alt="ReactionDiffusion.gif"> <br>  | **In this script, students will...** <br> $\bullet$ Explore diffusion equation. <br> $\bullet$ Implement a finite difference solution for the diffusion equation. <br> $\bullet$ Visualize the results of diffusion simulations. <br>  | **Academic disciplines** <br> $\bullet$ Mathematics <br> $\bullet$ Chemical engineering <br>   |

<a id="H_35e9"></a>

## [Ultrasound.m](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=Scripts/Ultrasound.m) 
||||
| :-: | :-- | :-- |
| <img src="Images/UltrasoundZoom.png" width="154" alt="UltrasoundZoom.png"> <br> Credit: [Terry J. DuBose](https://en.wikipedia.org/w/index.php?curid=19500021) <br>  | **In this script, students will...** <br> $\bullet$ Identify the necessary initial and boundary value knowledge required to numerically approximate a second\-order wave equation. <br> $\bullet$ Explore the basic theory of solving differential equations with boundary conditions. <br> $\bullet$ Identify challenges involved in numerically solving a simple\-looking PDE. <br>  | **Academic disciplines** <br> $\bullet$ Mathematics <br> $\bullet$ Medical technology <br> $\bullet$ Acoustics <br>   |

<a id="H_24b6"></a>

## [BatteryThermalModel.m](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=Scripts/BatteryThermalModel.m) 
||||
| :-- | :-- | :-- |
| <img src="Images/Battery.gif" width="171" alt="Battery.gif"> <br>  | **In this script, students will...** <br> $\bullet$ Explore the basic theory of the heat equation. <br> $\bullet$ Use cylindrical coordinates to model a battery cell. <br> $\bullet$ Implement a variety of initial conditions and visualize the results. <br>  | **Academic disciplines** <br> $\bullet$ Mathematics <br> $\bullet$ Electrical engineering <br> $\bullet$ Chemical engineering <br>   |

<a id="H_F61733D7"></a>

# License

The license for this module is available in [LICENSE.md](https://github.com/MathWorks-Teaching-Resources/Applied-PDEs/blob/release/LICENSE.md).

<a id="H_3DE08377"></a>

# Related Courseware Modules

| **Courseware Module** <br>  | **Sample Content** <br>  | **Available on:** <br>   |
| :-- | :-- | :-- |
| [Numerical Methods with Applications](https://www.mathworks.com/matlabcentral/fileexchange/111490-numerical-methods-with-applications) <br>  | <img src="Images/NumMethodsIcon.png" width="171" alt="NumMethodsIcon.png"> <br>  | [<img src="Images/OpenInFX.png" width="91" alt="OpenInFX.png">](https://www.mathworks.com/matlabcentral/fileexchange/111490-numerical-methods-with-applications) <br> [<img src="Images/OpenInMO.png" width="136" alt="OpenInMO.png">](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Numerical-Methods-with-Applications&project=NumericalMethods.prj)  <br> [GitHub](https://github.com/MathWorks-Teaching-Resources/Numerical-Methods-with-Applications)  <br>   |
| [Fourier Analysis](https://www.mathworks.com/matlabcentral/fileexchange/106725-fourier-analysis)  <br>  | <img src="Images/FourierAnalysisIcon.png" width="171" alt="FourierAnalysisIcon.png"> <br>  | <img src="Images/OpenInFX.png" width="91" alt="OpenInFX.png"> <br> [<img src="Images/OpenInMO.png" width="136" alt="OpenInMO.png">](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Fourier-Analysis&project=FourierAnalysis.prj) <br> [GitHub](https://github.com/MathWorks-Teaching-Resources/Fourier-Analysis) <br>   |

Or feel free to explore our other [modular courseware content](https://www.mathworks.com/matlabcentral/fileexchange/?q=author%3A%22MathWorks+Educator+Content+Development+Team%22&sort=relevancy).

# Educator Resources
- [Educator Page](https://www.mathworks.com/academia/educators.html)

<a id="H_0FA5DA18"></a>

# Contribute 

Looking for more? Found an issue? Have a suggestion? Please contact the [MathWorks Educator Content Development team](mailto:%20onlineteaching@mathworks.com). If you want to contribute directly to this project, you can find information about how to do so in the [CONTRIBUTING.md](https://github.com/MathWorks-Teaching-Resources/Applied-PDEs/blob/release/CONTRIBUTING.md)  page on GitHub.

# Help us Improve

[Share your feedback](<matlab: ShareFeedback>) to help us improve this module.

*©* Copyright 2025\-2026 The MathWorks, Inc
