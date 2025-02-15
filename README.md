
# <span style="color:rgb(213,80,0)">Applied Partial Differential Equations</span>


[![View on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/172650-applied-partial-differential-equations) or [![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=README.mlx)

[![MATLAB Versions Tested](https://img.shields.io/endpoint?url=https%3A%2F%2Fraw.githubusercontent.com%2FMathWorks-Teaching-Resources%2FApplied-PDEs%2Frelease%2FImages%2FTestedWith.json)](https://MathWorks-Teaching-Resources.github.io/Applied-PDEs)

**Curriculum Module**

_Created with R2024a. Compatible with R2024a and later releases._
 Chemical engineering
# Information

This curriculum module contains interactive [MATLAB® live scripts](https://www.mathworks.com/products/matlab/live-editor.html) that teach various topics suitable for a first class in partial differential equations.


## Background

You can use these live scripts as demonstrations in lectures, class activities, or interactive assignments outside class. This module covers classification of second\-order PDEs, solving first order wave equations analytically, solving second order wave equations numerically, systems of partial differential equations, and implementing both explicit and implicit finite difference methods. It also includes examples of shocks and rarefaction waves in traffic, diffusion of carbon through iron, a chemical morphogenesis model, a thermal model of a battery, and an approach to modeling an ultrasound.


The instructions inside the live scripts will guide you through the exercises and activities. Get started with each live script by running it one section at a time. To stop running the script or a section midway (for example, when an animation is in progress), use the <img src="Images/EndIcon.png" width="19" alt="EndIcon.png"> Stop button in the **RUN** section of the **Live Editor** tab in the MATLAB Toolstrip.

## Contact Us

Contact the [MathWorks teaching resources team](mailto:onlineteaching@mathworks.com) if you would like to provide feedback or have a question.


## Prerequisites

This module assumes fluent knowledge of single\-variable calculus. If you would like to brush up on these topics, you could review with the calculus courseware:

-  [**Calculus: Integrals** ](https://www.mathworks.com/matlabcentral/fileexchange/105740-calculus-integrals)is available on [<img src="Images/OpenInFX.png" width="91" alt="OpenInFX.png">](https://www.mathworks.com/matlabcentral/fileexchange/105740-calculus-integrals) or [<img src="Images/OpenInMO.png" width="136" alt="OpenInMO.png">](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Calculus-Integrals&project=Integrals.prj&file=README.mlx) or [GitHub](https://github.com/MathWorks-Teaching-Resources/Calculus-Integrals) 
-  [**Calculus: Derivatives**](https://www.mathworks.com/matlabcentral/fileexchange/99249-calculus-derivatives) is available on [<img src="Images/OpenInFX.png" width="91" alt="OpenInFX.png">](https://www.mathworks.com/matlabcentral/fileexchange/99249-calculus-derivatives) or [<img src="Images/OpenInMO.png" width="136" alt="OpenInMO.png">](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Calculus-Derivatives&project=Derivatives.prj&file=README.mlx) or [GitHub](https://github.com/MathWorks-Teaching-Resources/Calculus-Derivatives)  

## Getting Started
### Accessing the Module
### **On MATLAB Online:**

Use the [<img src="Images/OpenInMO.png" width="136" alt="OpenInMO.png">](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=README.mlx) link to download the module. You will be prompted to log in or create a MathWorks account. The project will be loaded, and you will see an app with several navigation options to get you started.

### **On Desktop:**

Download or clone this repository. Open MATLAB, navigate to the folder containing these scripts and double\-click [AppliedPDEs.prj](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=README.mlx). It will add the appropriate files to your MATLAB path and open an app that asks you where you would like to start. 


Ensure you have all the required products (listed below) installed. If you need to include a product, add it using the Add\-On Explorer. To install an add\-on, go to the **Home** tab and select  <img src="Images/AddOnsIcon.png" width="16" alt="AddOnsIcon.png"> **Add-Ons** > **Get Add-Ons**. 


## Products

MATLAB is used throughout. Tools from the Symbolic Math Toolbox™ are also frequently used. The function <samp>range</samp> from the Statistics and Machine Learning Toolbox™ is used in <samp>Diffusion.mlx</samp> and the Partial Differential Equation Toolbox™ is used in <samp>ReactionDiffusion.mlx</samp>, in an extension example.

# Scripts
## [**Classification.mlx**](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=Scripts/Classification.mlx)  
|      |      |      |
| :-- | :-- | :-- |
| <img src="Images/Classification.png" width="171" alt="Classification.png"> <br>  | **In this script, students will...** <br> $\bullet$ Review the terminology of classifying differential equations including homogeneity, order, and linearity. <br> $\bullet$ Classify second\-order PDEs as elliptic, parabolic, or hyperbolic. <br>  | **Academic disciplines** <br> $\bullet$ Mathematics <br>   |
|      |      |       |

## [**MethodOfCharacteristics.mlx**](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=Scripts/MethodOfCharacteristics.mlx)  
|      |      |      |
| :-- | :-- | :-- |
| <img src="Images/CharactericsticCurve.png" width="171" alt="CharactericsticCurve.png"> <br>  | **In this script, students will...** <br> $\bullet$ Solve a transport equation using the method of characteristic lines. <br> $\bullet$ Investigate applying the method of characteristics to first\-order 1\-D PDEs with nonconstant coefficients. <br>  | **Academic disciplines** <br> $\bullet$ Mathematics <br>   |
|      |      |       |

## [**TrafficModelReal.mlx**](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=Scripts/TrafficModel.mlx)  
|      |      |      |
| :-- | :-- | :-- |
| <img src="Images/CharacteristicCurveWithShock.png" width="171" alt="CharacteristicCurveWithShock.png"> <br>  | **In this script, students will...** <br> $\bullet$ Calculate a simple traffic model involving a nonlinear transport equation. <br> $\bullet$ Identify and resolve rarefaction regions in a characteristic plot. <br> $\bullet$ Identify and resolve shocks in a characteristic plot. <br>  | **Academic disciplines** <br> $\bullet$ Mathematics <br>   |
|      |      |       |

## [**FiniteDifference.mlx**](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=Scripts/FiniteDifference.mlx)  
|      |      |      |
| :-- | :-- | :-- |
| <img src="Images/Discretizing.png" width="171" alt="Discretizing.png"> <br>  | **In this script, students will...** <br> $\bullet$ Implement an explicit method. <br> $\bullet$ Implement an implicit method <br> $\bullet$ Implement a Crank\-Nicolson solver <br>  | **Academic disciplines** <br> $\bullet$ Mathematics <br>   |
|      |      |       |

## [**Diffusion.mlx**](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=Scripts/Diffusion.mlx)  
|      |      |      |
| :-- | :-- | :-- |
| <img src="Images/Diffusion.gif" width="171" alt="Diffusion.gif"> <br>  | **In this script, students will...** <br> $\bullet$ Explore the basic theory of diffusion and the diffusion equation. <br> $\bullet$ Implement a finite difference solution for the diffusion equation. <br> $\bullet$ Visualize the results of diffusion simulations. <br>  | **Academic disciplines** <br> $\bullet$ Mathematics <br> $\bullet$ Materials science <br> $\bullet$ Chemical engineering <br>  |
|      |      |       |

## [**ReactionDiffusion.mlx**](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=Scripts/ReactionDiffusion.mlx) 
|      |      |      |
| :-- | :-- | :-- |
| <img src="Images/ReactionDiffusion.gif" width="171" alt="ReactionDiffusion.gif"> <br>  | **In this script, students will...** <br> $\bullet$ Explore diffusion equation. <br> $\bullet$ Implement a finite difference solution for the diffusion equation. <br> $\bullet$ Visualize the results of diffusion simulations. <br>  | **Academic disciplines** <br> $\bullet$ Mathematics <br> $\bullet$ Chemical engineering <br>   |
|      |      |       |

## [**Ultrasound.mlx**](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=Scripts/Ultrasound.mlx)  
|      |      |      |
| :-: | :-- | :-- |
| <img src="Images/UltrasoundZoom.png" width="154" alt="UltrasoundZoom.png"> <br> Credit: [Terry J. DuBose](https://en.wikipedia.org/w/index.php?curid=19500021) <br>  | **In this script, students will...** <br> $\bullet$ Identify the necessary initial and boundary value knowledge required to numerically approximate a second\-order wave equation. <br> $\bullet$ Explore the basic theory of solving differential equations with boundary conditions. <br> $\bullet$ Identify challenges involved in numerically solving a simple\-looking PDE. <br>  | **Academic disciplines** <br> $\bullet$ Mathematics <br> $\bullet$ Medical technology <br> $\bullet$ Acoustics <br>   |
|      |      |       |

## [**BatteryThermalModel.mlx**](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Applied-PDEs&project=AppliedPDEs.prj&file=Scripts/BatteryThermalModel.mlx)  
|      |      |      |
| :-- | :-- | :-- |
| <img src="Images/Battery.gif" width="171" alt="Battery.gif"> <br>  | **In this script, students will...** <br> $\bullet$ Explore the basic theory of the heat equation. <br> $\bullet$ Use cylindrical coordinates to model a battery cell. <br> $\bullet$ Implement a variety of initial conditions and visualize the results. <br>  | **Academic disciplines** <br> $\bullet$ Mathematics <br> $\bullet$ Electrical engineering <br> $\bullet$ Chemical engineering <br>  |
|      |      |       |

# License

The license for this module is available in [LICENSE.md](https://github.com/MathWorks-Teaching-Resources/AppliedPDEs/blob/release/LICENSE.md).

# Related Courseware Modules
|      |      |      |
| :-- | :-- | :-- |
| **Courseware Module** <br>  | **Sample Content** <br>  | **Available on:** <br>   |
| [**Numerical Methods with Applications**](https://www.mathworks.com/matlabcentral/fileexchange/111490-numerical-methods-with-applications) <br>  | <img src="Images/NumMethodsIcon.png" width="171" alt="NumMethodsIcon.png"> <br>  | [<img src="Images/OpenInFX.png" width="91" alt="OpenInFX.png">](https://www.mathworks.com/matlabcentral/fileexchange/111490-numerical-methods-with-applications) <br> [<img src="Images/OpenInMO.png" width="136" alt="OpenInMO.png">](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Numerical-Methods-with-Applications&project=NumericalMethods.prj)   <br> [GitHub](https://github.com/MathWorks-Teaching-Resources/Numerical-Methods-with-Applications)  <br>   |
| [**Fourier Analysis**](https://www.mathworks.com/matlabcentral/fileexchange/106725-fourier-analysis)  <br>  | <img src="Images/FourierAnalysisIcon.png" width="171" alt="FourierAnalysisIcon.png"> <br>  | <img src="Images/OpenInFX.png" width="91" alt="OpenInFX.png"> <br> [<img src="Images/OpenInMO.png" width="136" alt="OpenInMO.png">](https://matlab.mathworks.com/open/github/v1?repo=MathWorks-Teaching-Resources/Fourier-Analysis&project=FourierAnalysis.prj) <br> [GitHub](https://github.com/MathWorks-Teaching-Resources/Fourier-Analysis) <br>   |
|      |      |       |


Or feel free to explore our other [modular courseware content](https://www.mathworks.com/matlabcentral/fileexchange/?q=tag%3A%22courseware+module%22&sort=downloads_desc_30d).

# Educator Resources
-  [Educator Page](https://www.mathworks.com/academia/educators.html) 

# Contribute 

Looking for more? Found an issue? Have a suggestion? Please contact the [MathWorks teaching resources team](mailto:%20onlineteaching@mathworks.com). If you want to contribute directly to this project, you can find information about how to do so in the [CONTRIBUTING.md](https://github.com/MathWorks-Teaching-Resources/AppliedPDEs/blob/release/CONTRIBUTING.md)  page on GitHub.


*©* Copyright 2024 The MathWorks™, Inc


