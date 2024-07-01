program atmosphere_validation
    use module_1
    use universal_module
    use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64
    implicit none

    character(len=100) :: filename
    real(dp), allocatable :: z(:), ICAO_data(:,:), ISEN_data(:,:)
    real(dp), allocatable :: ICAO_delta(:,:)
    integer :: ncolumn, nlines, nheadder, i

    filename = './atmosphere_validation_files/&
              &ICAO_Standard_Atmosphere_SI_units.csv'
    ncolumn = 9
    nheadder = 2
    nlines = count_lines(filename,nheadder)

    allocate(ISEN_data(nlines,2), ICAO_delta(nlines,2))

    ICAO_data = split_data(filename,nheadder,ncolumn)

    z = ICAO_data(:,1)

    do i = 1,nlines
        ISEN_data(i,:) = M1_isentropic_atmos_model(z(i))
        ICAO_delta(i,:) = [ICAO_data(i,3) - 30,ICAO_data(i,3) + 30]
    end do

    call write_2_arrays_to_file('./atmosphere_validation_files/&
                               &ICAO_temp_data.csv',ICAO_data(:,1),&
                                ICAO_data(:,3))
    call write_2_arrays_to_file('./atmosphere_validation_files/&
                               &ICAO_pres_data.csv',ICAO_data(:,1),&
                                ICAO_data(:,4)/1e3)
    call write_2_arrays_to_file('./atmosphere_validation_files/&
                               &ISEN_temp_data.csv',z,ISEN_data(:,1))
    call write_2_arrays_to_file('./atmosphere_validation_files/&
                               &ISEN_pres_data.csv',ICAO_data(:,1),&
                                ISEN_data(:,2))
    call write_3_arrays_to_file('./atmosphere_validation_files/&
                               &ICAO_temp_delta.csv',ICAO_data(:,1),&
                                ICAO_delta(:,1),Icao_delta(:,2))

    call execute_command_line('gnuplot ./atmosphere_validation_files/&
                             &atmosphere_validation.gp')
end program atmosphere_validation
