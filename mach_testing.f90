program mach_testing
    use universal_module
    use auxiliary_module
    use module_6
    use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64
    implicit none

    real(dp), allocatable :: linspace_array(:), all_output_array(:,:)
    character(len=500) :: filename
    character(:), allocatable :: str, str2
    integer :: i, n, casenum, unit
    real(dp) :: initial_parameters(8)
    real(dp) :: z, M1, eta_d, M2, qf, Tt3_max, eta_n, Area_e

    ! n = (2.5-0.1)/0.1
    n = 1000
    allocate(linspace_array(n), all_output_array(n,4))

    casenum = 7
    write(filename, '(A, I0, A)') './data_files/input_variables_case',casenum,'.csv'
    call read_initial_parameters(filename,initial_parameters)

    ! Initialize variables to be used in calculations
    ! z  = initial_parameters(1)
    z = 4300
    ! M1 = initial_parameters(2)
    M1 = 2.4
    eta_d = initial_parameters(3)
    M2 = initial_parameters(4)
    qf = initial_parameters(5)
    Tt3_max = initial_parameters(6)
    eta_n = initial_parameters(7)
    Area_e = initial_parameters(8)

    filename = './mach_test/mach_test_plot.csv'
    open (newunit=unit, file=filename, status='replace', action='write')
    call linspace(0.8_dp,5._dp,linspace_array)
    str = repeat(trim(', ",", F20.10'), 34)
    str2 = '(F20.10'//str//')'
    do i = 1,size(linspace_array)
        all_output_array = export_all_outputs(z,linspace_array(i),eta_d,M2,qf,Tt3_max,eta_n,Area_e)
        write(unit, str2) &
              linspace_array(i), &
              all_output_array(3,2), all_output_array(4,1), all_output_array(5,1), &
              all_output_array(1,1), all_output_array(2,2), all_output_array(3,4), all_output_array(4,5), all_output_array(5,5), &
              all_output_array(1,4), all_output_array(2,3), all_output_array(3,6), all_output_array(4,2), all_output_array(5,2), &
              all_output_array(4,9), all_output_array(6,2), all_output_array(6,1), &
              all_output_array(6,4)/1000, all_output_array(6,5)/1000, all_output_array(6,6)/1000, &
              all_output_array(6,3), all_output_array(6,10), all_output_array(6,11), all_output_array(6,12), &
              all_output_array(1,7), all_output_array(2,7), all_output_array(4,8), all_output_array(5,8), all_output_array(6,7), &
              all_output_array(3,3), &
              all_output_array(1,3), all_output_array(3,1), &
              all_output_array(1,2), all_output_array(2,4), all_output_array(4,3)
    end do
    close(unit)

    call execute_command_line('gnuplot ./mach_test/mach_test_plot.gp')

end program mach_testing