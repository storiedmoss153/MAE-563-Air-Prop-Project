program performance_parameters
    use universal_module
    use auxiliary_module
    use module_6
    use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64
    implicit none

    real(dp), allocatable :: linspace_array(:), all_output_array(:,:)
    real(dp), allocatable :: part_e_data(:,:)
    character(len=50) :: filename
    integer :: i, j, n, max_eta_o(1), min_TSFC(1)
    real(dp) :: initial_parameters(8)
    real(dp) :: z, M1, eta_d, M2, qf, Tt3_max, eta_n, Area_e

    n = 1000
    allocate(linspace_array(n), all_output_array(n,3))

    write(filename, '(A, I0, A)') './data_files/input_variables_case',7,'.csv'
    call read_initial_parameters(filename,initial_parameters)

    ! Initialize variables to be used in calculations
    z = initial_parameters(1)
    M1 = initial_parameters(2)
    eta_d = initial_parameters(3)
    M2 = initial_parameters(4)
    qf = initial_parameters(5)
    Tt3_max = initial_parameters(6)
    eta_n = initial_parameters(7)
    Area_e = initial_parameters(8)    

    ! Part c
    call linspace(0.8_dp,5.0_dp,linspace_array)
    do i = 1,size(linspace_array)
        all_output_array(i,:) = all_all_module(z,linspace_array(i),&
                                eta_d,M2,qf,Tt3_max,eta_n,Area_e)
    end do
    call write_4_arrays_to_file('./performance_parameter_files/&
                               &part_c_data.csv',linspace_array,&
                                all_output_array(:,1),&
                                all_output_array(:,2),all_output_array(:,3))
    call execute_command_line('gnuplot ./performance_parameter_files/&
                             &part_c_plot.gp')

    ! Part d
    call linspace(2000._dp,30000._dp,linspace_array)
    do i = 1,size(linspace_array)
        all_output_array(i,:) = all_all_module(linspace_array(i),M1,&
                                eta_d,M2,qf,Tt3_max,eta_n,Area_e)
    end do
    call write_4_arrays_to_file('./performance_parameter_files/&
                               &part_d_data.csv',linspace_array,&
                                all_output_array(:,1), &
                                all_output_array(:,2),all_output_array(:,3))
    call execute_command_line('gnuplot ./performance_parameter_files/&
                             &part_d_plot.gp')
    deallocate(linspace_array, all_output_array)

    ! Part e
    n = int((5 - 0.1) / 0.001 + 1)
    allocate(linspace_array(n), all_output_array(n,3))
    call linspace(0.1_dp,5._dp,linspace_array)
    n = int((20000 - 2000) / 500 + 1)
    allocate(part_e_data(n,3))
    do i = 1,n
        z = 2000 + 500 * (i - 1)
        do j = 1,size(linspace_array)
            all_output_array(j,:) = all_all_module(z,linspace_array(j),&
                                    eta_d,M2,qf,Tt3_max,eta_n,Area_e)
        end do
        max_eta_o = MAXLOC(all_output_array(:,1))
        min_TSFC = MINLOC(all_output_array(:,3))
        part_e_data(i,:) = [z,linspace_array(max_eta_o),&
                            linspace_array(min_TSFC)]
    end do
    call write_3_arrays_to_file('./performance_parameter_files/&
                               &part_e_data_range_1_5.csv', &
                                part_e_data(:,1),part_e_data(:,2),&
                                part_e_data(:,3))
    call linspace(0.1_dp,10._dp,linspace_array)
    do i = 1,n
        z = 2000 + 500 * (i - 1)
        do j = 1,size(linspace_array)
            all_output_array(j,:) = all_all_module(z,linspace_array(j),&
                                    eta_d,M2,qf,Tt3_max,eta_n,Area_e)
        end do
        max_eta_o = MAXLOC(all_output_array(:,1))
        min_TSFC = MINLOC(all_output_array(:,3))
        part_e_data(i,:) = [z,linspace_array(max_eta_o),&
                            linspace_array(min_TSFC)]
    end do
    call write_3_arrays_to_file('./performance_parameter_files/&
                               &part_e_data_range_1_10.csv', &
                                part_e_data(:,1),part_e_data(:,2),&
                                part_e_data(:,3))
    call execute_command_line('gnuplot ./performance_parameter_files/&
                             &part_e_plot.gp')
    deallocate(linspace_array, all_output_array, part_e_data)

    ! Part f
    z = 4300
    M1 = 2.4
    n = int((1 - 0.5) / 0.05 + 1)
    allocate(linspace_array(n), all_output_array(n,3))
    call linspace(0.5_dp,1.0_dp,linspace_array)
    do i = 1,size(linspace_array)
        all_output_array(i,:) = all_all_module(z,M1,linspace_array(i),&
                                M2,qf,Tt3_max,eta_d,Area_e)
    end do
    call write_4_arrays_to_file('./performance_parameter_files/&
                               &part_f_data.csv',linspace_array,&
                                all_output_array(:,1), &
                                all_output_array(:,2),all_output_array(:,3))
    call execute_command_line('gnuplot ./performance_parameter_files/&
                             &part_f_plot.gp')
    
    ! Part g
    call linspace(0.5_dp,1.0_dp,linspace_array)
    do i = 1,size(linspace_array)
        all_output_array(i,:) = all_all_module(z,M1,eta_d,M2,qf,Tt3_max, &
                                               linspace_array(i),Area_e)
    end do
    call write_4_arrays_to_file('./performance_parameter_files/&
                               &part_g_data.csv',linspace_array,&
                                all_output_array(:,1), &
                                all_output_array(:,2),all_output_array(:,3))
    call execute_command_line('gnuplot ./performance_parameter_files/&
                             &part_g_plot.gp')
    deallocate(linspace_array, all_output_array)

    ! Part h
    n = int((2.5 - 0.1) / 0.1 + 1)
    allocate(linspace_array(n), all_output_array(n,3))
    call linspace(0.1_dp,2.5_dp,linspace_array)
    do i = 1,size(linspace_array)
        all_output_array(i,:) = all_all_module(z,M1,eta_d,&
                                linspace_array(i),qf,Tt3_max,eta_d,Area_e)
    end do
    call write_4_arrays_to_file('./performance_parameter_files/&
                               &part_h_data.csv',linspace_array,&
                                all_output_array(:,1), &
                                all_output_array(:,2),all_output_array(:,3))
    call execute_command_line('gnuplot ./performance_parameter_files/&
                             &part_h_plot.gp')
    deallocate(linspace_array, all_output_array)
end program performance_parameters