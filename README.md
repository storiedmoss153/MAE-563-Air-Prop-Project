# AEE-563-Air-Prop-Project
Repository for AEE 563: Introduction to Aircraft Propulsion Theory and Applications Master's Project.

This project is being used as a learning tool for FORTRAN programming over the summer. It also incorporates gnuplotting for plotting plots. The main goal of this project is to develop an analysis tool for parametric studies of non-ideal ramjet propulsion performance which will then be used to examine how ramjet performance varies across a range of key parameters.

## Scripts for running individual .f90 files

### Atmosphere Validation File
This file calculates the Temperature \[K\] and Pressure \[kPa\] from the Isentropic model of the atmosphere and plots them against the data in the [ICAO Standard Atmosphere Data](atmosphere_validation_files/ICAO_Standard_Atmosphere_English_units.csv).

#### Running module_validation.f90
```
gfortran ./modules/module_1.f90 ./modules/module_2.f90 ./modules/module_3.f90 ./modules/module_4.f90 ./modules/module_5.f90 ./modules/module_6.f90 ./modules/auxiliary_module.f90 ./modules/universal_module.f90 module_validation.f90 -o module_validation
./module_validation
```

#### Running atmospheres_validation.f90
```
gfortran ./modules/module_1.f90 atmosphere_validation.f90 ./modules/universal_module.f90 -o atmosphere_validation
./atmosphere_validation
```

#### Running TS_diagram_plotting.f90
```
gfortran ./modules/module_1.f90 ./modules/module_2.f90 ./modules/module_3.f90 ./modules/module_4.f90 ./modules/module_5.f90 ./modules/module_6.f90 ./modules/auxiliary_module.f90 ./modules/universal_module.f90 TS_diagram_plotting.f90 -o TS_plotting
./TS_plotting
```

#### Running performance_parameters.f90
```
gfortran ./modules/module_1.f90 ./modules/module_2.f90 ./modules/module_3.f90 ./modules/module_4.f90 ./modules/module_5.f90 ./modules/module_6.f90 ./modules/auxiliary_module.f90 ./modules/universal_module.f90 performance_parameters.f90 -o performance_parameters
./performance_parameters
```

#### Running propulsion_system_design.f90
```
gfortran ./modules/module_1.f90 ./modules/module_2.f90 ./modules/module_3.f90 ./modules/module_4.f90 ./modules/module_5.f90 ./modules/module_6.f90 ./modules/auxiliary_module.f90 ./modules/universal_module.f90 propulsion_system_design.f90 -o propulsion_system_design
./propulsion_system_design
```
