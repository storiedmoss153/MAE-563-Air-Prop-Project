# AEE-563-Air-Prop-Project
Repository for MAE 563: Introduction to Aircraft Propulsion Theory and Applications Master's Project.

This project is being used as a learning tool for FORTRAN programming over the summer. It also incorporates gnuplotting for plotting plots. The main goal of this project is to develop an analysis tool for parametric studies of non-ideal ramjet propulsion performance which will then be used to examine how ramjet performance varies across a range of key parameters.

## Scripts for running individual .f90 files

### Module Validation File
This file is used to validate the modules against the given test cases. The initial case parameters are in [data files](data_files).

#### Running module_validation.f90
```
gfortran ./modules/universal_module.f90 ./modules/module_1.f90 ./modules/module_2.f90 ./modules/module_3.f90 ./modules/module_4.f90 ./modules/module_5.f90 ./modules/module_6.f90 ./modules/auxiliary_module.f90 module_validation.f90 -o module_validation.out
./module_validation.out
```

### Atmosphere Validation File
This file calculates the Temperature \[K\] and Pressure \[kPa\] from the Isentropic model of the atmosphere and plots them against the data in the [ICAO Standard Atmosphere Data](atmosphere_validation_files/ICAO_Standard_Atmosphere_English_units.csv).

#### Running atmospheres_validation.f90
```
gfortran ./modules/universal_module.f90 ./modules/module_1.f90 atmosphere_validation.f90 -o atmosphere_validation.out
./atmosphere_validation.out
```
### T-vs-s Diagrams Files
This file takes in one of the [initial case parameter files](data_files) and calculates and plots the corresponding T-vs-s diagram where straight lines connect States 1-2 and 3-4 while constant pressure curves connect States 2-3 and 4-1.

#### Running TS_diagram_plotting.f90
```
gfortran ./modules/universal_module.f90 ./modules/module_1.f90 ./modules/module_2.f90 ./modules/module_3.f90 ./modules/module_4.f90 ./modules/module_5.f90 ./modules/module_6.f90 ./modules/auxiliary_module.f90 TS_diagram_plotting.f90 -o TS_plotting.out
./TS_plotting.out
```

### Performance Parameters File
This file calculates and plots the various performance parameters for parts c-h of the project. The file reads one of the [input case files](data_files) for the initial case parameters.

#### Running performance_parameters.f90
```
gfortran ./modules/universal_module.f90 ./modules/module_1.f90 ./modules/module_2.f90 ./modules/module_3.f90 ./modules/module_4.f90 ./modules/module_5.f90 ./modules/module_6.f90 ./modules/auxiliary_module.f90 performance_parameters.f90 -o performance_parameters.out
./performance_parameters.out
```

### Propulsion System Design
This code completes part I of the project which is the design of the propulsion system by finding two designs, one that optimizes the total thrust and one that optimizes the overall efficiency. This file uses the [case 7 input file](data_files/input_variables_case7.csv) for the majority of the input parameters, with some alternative ones defined in the project manual.

#### Running propulsion_system_design.f90
```
gfortran ./modules/universal_module.f90 ./modules/module_1.f90 ./modules/module_2.f90 ./modules/module_3.f90 ./modules/module_4.f90 ./modules/module_5.f90 ./modules/module_6.f90 ./modules/auxiliary_module.f90 propulsion_system_design.f90 -o propulsion_system_design.out
./propulsion_system_design.out
```
### Mach Testing
This code plots additional state properties for the propulsion system design to aid in conclusions drawn from the design. The plots created are M2 vs (M3,Me,M4), vs (p2,p3,pe), and vs (Tt3,Tte,Tt4).

## Running mach_testing.f90
```
gfortran ./modules/universal_module.f90 ./modules/module_1.f90 ./modules/module_2.f90 ./modules/module_3.f90 ./modules/module_4.f90 ./modules/module_5.f90 ./modules/module_6.f90 ./modules/auxiliary_module.f90 mach_testing.f90 -o mach_testing.out
./mach_testing.out
```