program module_validation
    use universal_module
    use auxiliary_module
    use module_6
    use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64
    implicit none

    real(dp) :: z, M1, eta_d, M2, qf, Tt3_max, eta_n, Area_e
    real(dp) :: initial_parameters(8)
    real(dp), allocatable :: dummy_array(:)
    real(dp) :: T1, p1, Tt1, pt1, cp1, a1, V1
    real(dp) :: Tt2, T2, pt2, p2, cp2, a2, V2, delta_s12
    real(dp) :: Tt3, M3, q23, T3, p3, pt3, cp3, delta_s23, delta_s13
    real(dp) :: Me, pte, pe, Tte, Te, cpe, ae, Ve, me_dot, delta_s3e
    real(dp) :: delta_s1e
    real(dp) :: M4, pt4, p4, Tt4, T4, cp4, a4, V4, delta_se4, delta_s14
    real(dp) :: mf_dot, mi_dot, f, jet_thrust, pressure_thrust, total_thrust
    real(dp) :: Veq, TSFC, Isp, eta_th, eta_p, eta_o, prop_power
    character(len=50) :: filename
    integer :: case_num = 7

    ! Call funciton to read saved initial parameters from file
    write(filename, '(A, I0, A)') './data_files/input_variables_case',&
          case_num,'.csv'
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

    ! Calculations from Module 1
    allocate(dummy_array(7))
    dummy_array = M1_all_function(z,M1)
    T1 = dummy_array(1)                                               ! K
    p1 = dummy_array(2)                                               ! kPa
    Tt1 = dummy_array(3)                                              ! K
    pt1 = dummy_array(4)                                              ! kPa
    cp1 = dummy_array(5)                                              ! J/kg-K
    a1 = dummy_array(6)                                               ! m/s
    V1 = dummy_array(7)                                               ! m/s

    print *, 'State 1 conditions:'
    print *, 'T1 = ', T1, 'p1 = ', p1, 'Tt1 = ', Tt1
    print *, 'pt1 = ', pt1, 'cp1 = ', cp1, 'a1 = ', a1
    print *, 'V1 = ', V1
    deallocate(dummy_array)

    ! Calculations from Module 2
    allocate(dummy_array(8))
    dummy_array = M2_all_function(Tt1,p1,pt1,M1,M2,eta_d)
    Tt2 = dummy_array(1)                                             ! K
    T2 = dummy_array(2)                                              ! K
    pt2 = dummy_array(3)                                             ! kPa
    p2 = dummy_array(4)                                              ! kPa
    cp2 = dummy_array(5)                                             ! J/kg-K
    a2 = dummy_array(6)                                              ! m/s
    V2 = dummy_array(7)                                              ! m/s
    delta_s12 = dummy_array(8)                                       ! J/kg-K

    print *, 'State 2 conditions:'
    print *, 'Tt2 = ', Tt2, 'T2 = ', T2, 'pt2 = ', pt2
    print *, 'p2 = ', p2, 'cp2 = ', cp2, 'a2 = ', a2
    print *, 'V2 = ', V2, 'delta_s12 = ', delta_s12
    deallocate(dummy_array)

    ! Calculations from Module 3
    allocate(dummy_array(9))
    dummy_array = M3_all_function(Tt2,Tt3_max,p2,pt2,M2,delta_s12)
    Tt3 = dummy_array(1)                                             ! K
    M3 = dummy_array(2)                                              !
    q23 = dummy_array(3)                                             ! MJ/kg
    T3 = dummy_array(4)                                              ! K
    p3 = dummy_array(5)                                              ! kPa
    pt3 = dummy_array(6)                                             ! kPa
    cp3 = dummy_array(7)                                             ! J/kg-K
    delta_s23 = dummy_array(8)                                       ! J/kg-K
    delta_s13 = dummy_array(9)                                       ! J/kg-K

    print *, 'State 3 conditions:'
    print *, 'Tt3 = ', Tt3, 'M3 = ', M3, 'q23 = ', q23
    print *, 'T3 = ', T3, 'p3 = ', p3, 'pt3 = ', pt3
    print *, 'cp3 = ', cp3, 'delta_s23 = ', delta_s23, 'delta_s13 = ',&
              delta_s13
    deallocate(dummy_array)

    ! Calculations from Module 4
    allocate(dummy_array(11))
    dummy_array = M4_all_function(Tt3,p1,pt3,eta_n,delta_s13,Area_e)
    Me = dummy_array(1)                                              !
    pte = dummy_array(2)                                             ! kPa
    pe = dummy_array(3)                                              ! kPa
    Tte = dummy_array(4)                                             ! K
    Te = dummy_array(5)                                              ! K
    cpe = dummy_array(6)                                             ! J/kg-K
    ae = dummy_array(7)                                              ! m/s
    Ve = dummy_array(8)                                              ! m/s
    me_dot = dummy_array(9)                                          ! kg/s
    delta_s3e = dummy_array(10)                                      ! J/kg-K
    delta_s1e = dummy_array(11)                                      ! J/kg-K

    print *, 'Exit state conditions:'
    print *, 'Me = ', Me, 'pte = ', pte, 'pe = ', pe
    print *, 'Tte = ', Tte, 'Te = ', Te, 'cpe = ', cpe
    print *, 'ae = ', ae, 'Ve = ', Ve, 'me_dot = ', me_dot
    print *, 'delta_s3e = ', delta_s3e, 'delta_s1e = ', delta_s1e
    deallocate(dummy_array)

    ! Calculations from Module 5
    allocate(dummy_array(10))
    dummy_array = M5_all_function(p1,pt3,pte,Tte,eta_n,delta_s1e)
    M4 = dummy_array(1)                                              !
    pt4 = dummy_array(2)                                             ! kPa
    p4 = dummy_array(3)                                              ! kPa
    Tt4 = dummy_array(4)                                             ! K
    T4 = dummy_array(5)                                              ! K
    cp4 = dummy_array(6)                                             ! J/kg-K
    a4 = dummy_array(7)                                              ! m/s
    V4 = dummy_array(8)                                              ! m/s
    delta_se4 = dummy_array(9)                                       ! J/kg-K
    delta_s14 = dummy_array(10)                                      ! J/kg-K

    print *, 'External flow conditions:'
    print *, 'M4 = ', M4, 'pt4 = ', pt4, 'p4 = ', p4
    print *, 'Tt4 = ', Tt4, 'T4 = ', T4, 'cp4 = ', cp4
    print *, 'a4 = ', a4, 'V4 = ', V4, 'delta_se4 = ', delta_se4
    print *, 'delta_s14 = ', delta_s14
    deallocate(dummy_array)

    ! Calculations from Module 6
    allocate(dummy_array(13))
    dummy_array = M6_all_function(q23,qf,me_dot,Ve,V1,pe,p1,p1,Area_e)
    mf_dot = dummy_array(1)                                          ! kg/s
    mi_dot = dummy_array(2)                                          ! kg/s
    f = dummy_array(3)
    jet_thrust = dummy_array(4)                                      ! N
    pressure_thrust = dummy_array(5)                                 ! N
    total_thrust = dummy_array(6)                                    ! N
    Veq = dummy_array(7)                                             ! m/s
    TSFC = dummy_array(8)                                            ! (kg/hr)/N
    Isp = dummy_array(9)                                             ! s
    eta_th = dummy_array(10)
    eta_p = dummy_array(11)
    eta_o = dummy_array(12)
    prop_power = dummy_array(13)                                     ! MW

    print *, 'Mass flux parameters:'
    print *, 'mf_dot = ', mf_dot, 'mi_dot = ', mi_dot, 'f = ', f
    print *, 'Thrust parameters:'
    print *, 'Jet thrust = ', jet_thrust, 'Pressure thrust = ',&
              pressure_thrust, 'Total thrust = ', total_thrust
    print *, 'Efficiency parameters:'
    print *, 'Veq = ', Veq, 'TSFC = ', TSFC, 'Isp = ', Isp
    print *, 'eta_th = ', eta_th, 'eta_p = ', eta_p, 'eta_o = ', eta_o
    print *, 'Propusive power = ', prop_power
    deallocate(dummy_array)

    ! Saving Temperature and Pressure data for plotting
    allocate(dummy_array(5))
    write(filename, '(A, I0, A)') './data_files/case',case_num,&
          '_static_temperature_data.csv'
    dummy_array = [T1,T2,T3,Te,T4]
    call write_state_data_to_file(filename,dummy_array)

    write(filename, '(A, I0, A)') './data_files/case',case_num,&
          '_total_temperature_data.csv'
    dummy_array = [Tt1,Tt2,Tt3,Tte,Tt4]
    call write_state_data_to_file(filename,dummy_array)

    write(filename, '(A, I0, A)') './data_files/case',case_num,&
          '_static_pressure_data.csv'
    dummy_array = [p1,p2,p3,pe,p4]
    call write_state_data_to_file(filename,dummy_array)

    write(filename, '(A, I0, A)') './data_files/case',case_num,&
          '_total_pressure_data.csv'
    dummy_array = [pt1,pt2,pt3,pte,pt4]
    call write_state_data_to_file(filename,dummy_array)
    deallocate(dummy_array)

    allocate(dummy_array(4))
    write(filename, '(A, I0, A)') './data_files/case',case_num,&
          '_entropy_change_data.csv'
    dummy_array = [delta_s12,delta_s13,delta_s1e,delta_s14]
    call write_state_data_to_file(filename,dummy_array)
    deallocate(dummy_array)
end program module_validation