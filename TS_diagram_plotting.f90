program TS_diagram_plotting
    use universal_module
    use module_6
    use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64
    implicit none

    real(dp) :: delta_s12, delta_s13, delta_s1e, delta_s14
    real(dp) :: T1, T2, T3, Te, T4
    real(dp) :: ds, ds2, s, T, dT
    real(dp), allocatable :: dummy_array(:,:)
    character(len=50) :: filename
    integer :: num, i, unit, num_fin
    integer :: case_num = 7

    ! Allocating Data
    allocate(dummy_array(5,3))
    write(filename, '(A, I0, A)') './data_files/case',&
          case_num,'_static_temperature_data.csv'
    dummy_array = split_data(filename,0,3)
    T1 = dummy_array(1,3)
    T2 = dummy_array(2,3)
    T3 = dummy_array(3,3)
    Te = dummy_array(4,3)
    T4 = dummy_array(5,3)
    print *, T1, T2, T3, Te, T4
    deallocate(dummy_array)

    allocate(dummy_array(4,3))
    write(filename, '(A, I0, A)') './data_files/case',&
          case_num,'_entropy_change_data.csv'
    dummy_array = split_data(filename,0,3)
    delta_s12 = dummy_array(1,3)
    delta_s13 = dummy_array(2,3)
    delta_s1e = dummy_array(3,3)
    delta_s14 = dummy_array(4,3)
    print *, delta_s12, delta_s13, delta_s1e, delta_s14
    deallocate(dummy_array)

    num = 1000

    ! write state data from 1 to 2
    write(filename, '(A, I0, A)') './TS_plot_files/case',&
          case_num,'_TS_12_data.csv'
    open (newunit=unit, file=filename, status='replace', action='write')
    write(unit, '(*(F20.10, ","))') 0._dp, T1
    write(unit, '(*(F20.10, ","))') delta_s12, T2
    close(unit)

    ! write state data from 2 to 3
    write(filename, '(A, I0, A)') './TS_plot_files/case',&
          case_num,'_TS_23_data.csv'
    open (newunit=unit, file=filename, status='replace', action='write')
    ds = (delta_s13 - delta_s12) / (num - 1)
    T = T2
    s = delta_s12
    write(unit, '(*(F20.10, ","))') s, T
    do i = 1,num
        dT = (T / M3_pressure_coefficient(T)) * ds
        T = T + dT
        if (T >= T3) then
            exit
        end if
    end do
    num_fin = i
    T = T2
    ds2 = ds * (num - 1) / (num_fin - 1)
    do i =1,num_fin
        write(unit, '(*(F20.10, ","))') s, T
        dT = (T / M3_pressure_coefficient(T)) * ds
        s = s + ds2
        T = T + dT
    end do
    write(unit, '(*(F20.10, ","))') delta_s13, T3
    close(unit)

    ! write state data from 3 to e
    write(filename, '(A, I0, A)') './TS_plot_files/case',&
          case_num,'_TS_3e_data.csv'
    open (newunit=unit, file=filename, status='replace', action='write')
    write(unit, '(*(F20.10, ","))') delta_s13, T3
    write(unit, '(*(F20.10, ","))') delta_s1e, Te
    close(unit)

    ! write state data from e to 4
    write(filename, '(A, I0, A)') './TS_plot_files/case',&
          case_num,'_TS_e4_data.csv'
    open (newunit=unit, file=filename, status='replace', action='write')
    write(unit, '(*(F20.10, ","))') delta_s1e, Te
    write(unit, '(*(F20.10, ","))') delta_s14, T4
    close(unit)

    ! write state data from 4 to 1
    write(filename, '(A, I0, A)') './TS_plot_files/case',&
          case_num,'_TS_41_data.csv'
    open (newunit=unit, file=filename, status='replace', action='write')
    write(unit, '(*(F20.10, ","))') delta_s14, T4
    s = delta_s14
    T = T4
    ds = (delta_s14) / (num - 1)
    do i = 1,num
        dT = (T / M1_pressure_coefficient()) * ds
        T = T - dT
        if (T <= T1) then
            exit
        end if
    end do
    num_fin = i
    T = T4
    ds2 = ds * (num - 1) / (num_fin - 1)
    do i = 1, num_fin
        write(unit, '(*(F20.10, ","))') s, T
        dT = (T / M1_pressure_coefficient()) * ds
        s = s - ds2
        T = T - dT
    end do
    write(unit, '(*(F20.10, ","))') 0._dp, T1
    close(unit)

    ! execute the plotting of the TS diagram
    write(filename, '(A, I0, A)') './TS_plot_files/&
         &TS_plot_for_case_',case_num,'.gp'
    call execute_command_line('gnuplot ' // filename)
end program TS_diagram_plotting
