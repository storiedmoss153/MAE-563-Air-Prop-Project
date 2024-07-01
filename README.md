# AEE-563-Air-Prop-Project
Repository for AEE 563: Introduction to Aircraft Propulsion Theory and Applications Master's Project

## Scripts for running individual .f90 files

### Running module_validation.f90
```
gfortran ./modules/module_1.f90 ./modules/module_2.f90 ./modules/module_3.f90 ./modules/module_4.f90 ./modules/module_5.f90 ./modules/module_6.f90 ./modules/auxiliary_module.f90 ./modules/universal_module.f90 module_validation.f90 -o module_validation
./module_validation
```

### Running atmospheres_validation.f90
```
gfortran ./modules/module_1.f90 atmosphere_validation.f90 ./modules/universal_module.f90 -o atmosphere_validation
./atmosphere_validation
```

### Running TS_diagram_plotting.f90
```
gfortran ./modules/module_1.f90 ./modules/module_2.f90 ./modules/module_3.f90 ./modules/module_4.f90 ./modules/module_5.f90 ./modules/module_6.f90 ./modules/auxiliary_module.f90 ./modules/universal_module.f90 TS_diagram_plotting.f90 -o TS_plotting
./TS_plotting
```

### Running performance_parameters.f90
```
gfortran ./modules/module_1.f90 ./modules/module_2.f90 ./modules/module_3.f90 ./modules/module_4.f90 ./modules/module_5.f90 ./modules/module_6.f90 ./modules/auxiliary_module.f90 ./modules/universal_module.f90 performance_parameters.f90 -o performance_parameters
./performance_parameters
```

### Running propulsion_system_design.f90
```
gfortran ./modules/module_1.f90 ./modules/module_2.f90 ./modules/module_3.f90 ./modules/module_4.f90 ./modules/module_5.f90 ./modules/module_6.f90 ./modules/auxiliary_module.f90 ./modules/universal_module.f90 propulsion_system_design.f90 -o propulsion_system_design
./propulsion_system_design
```
