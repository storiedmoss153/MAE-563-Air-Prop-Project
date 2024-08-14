program mach_testing
    use universal_module
    use auxiliary_module
    use module_6
    use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64
    implicit none

    real(dp), allocatable :: linspace_array(:), all_output_array(:,:)
    character(len=50) :: filename
    integer :: i, n, casenum, unit
    real(dp) :: initial_parameters(8)
    real(dp) :: z, M1, eta_d, M2, qf, Tt3_max, eta_n, Area_e

    n = 1000
    allocate(linspace_array(n), all_output_array(n,4))

    casenum = 7
    write(filename, '(A, I0, A)') './data_files/input_variables_case',casenum,'.csv'
    call read_initial_parameters(filename,initial_parameters)

    ! Initialize variables to be used in calculations
    z  = 27400
    M1 = 5
    eta_d = initial_parameters(3)
    M2 = initial_parameters(4)
    qf = initial_parameters(5)
    Tt3_max = initial_parameters(6)
    eta_n = initial_parameters(7)
    Area_e = initial_parameters(8)

    filename = './mach_test/mach_test_plot.csv'
    open (newunit=unit, file=filename, status='replace', action='write')
    call linspace(0._dp,5._dp,linspace_array)
    do i = 1,size(linspace_array)
        all_output_array = export_all_outputs(z,M1,eta_d,linspace_array(i),qf,Tt3_max,eta_n,Area_e)
        write(unit, '(F20.10, ",", F20.10, ",", F20.10, ",", F20.10, ",", F20.10, ",", F20.10, ",", F20.10)') &
              linspace_array(i), all_output_array(3,2), all_output_array(4,1), &
              all_output_array(5,1), all_output_array(3,1), all_output_array(2,4), &
              all_output_array(4,3)
    end do
    close(unit)

    call execute_command_line('gnuplot ./mach_test/mach_test_plot.gp')

end program mach_testing