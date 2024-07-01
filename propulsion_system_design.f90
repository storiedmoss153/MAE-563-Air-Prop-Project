program propulsion_system_design
    use universal_module
    use auxiliary_module
    use module_6
    use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64
    implicit none

    character(len=50) :: filename
    integer :: i, j, n(1), n_M2, n_Tt3, io, ios
    real(dp) :: d_M2, d_Tt3, M2_max !, max_matrix(2,4)
    real(dp), allocatable :: dummy_array(:) , design_array(:,:)
    real(dp) :: initial_parameters(8)
    real(dp) :: z, M1, M2, M2_int, eta_d, qf, Tt3_max, eta_n, Area_e
    real(dp) :: T1, p1, Tt1, pt1, cp1, a1, V1
    real(dp) :: Tt2, T2, pt2, p2, cp2, a2, V2, delta_s12
    real(dp) :: Tt3, Tt3_int, M3, q23, T3, p3, pt3, cp3, delta_s23, delta_s13
    real(dp) :: Me, pte, pe, Tte, Te, cpe, ae, Ve, me_dot, delta_s3e, delta_s1e
    real(dp) :: M4, pt4, p4, Tt4, T4, cp4, a4, V4, delta_se4, delta_s14
    real(dp) :: mf_dot, mi_dot, f, jet_thrust, pressure_thrust, total_thrust
    real(dp) :: Veq, TSFC, Isp, eta_th, eta_p, eta_o, prop_power

    write(filename, '(A, I0, A)') './data_files/input_variables_case',7,'.csv'
    call read_initial_parameters(filename,initial_parameters)

    ! Initialize variables to be used in calculations
    z = 27400._dp
    M1 = 5._dp
    M2_int = 0.1
    M2_max = 5
    d_M2 = 0.1
    Tt3_int = 1300
    Tt3_max = initial_parameters(6)
    d_Tt3 = 10
    eta_d = initial_parameters(3)
    qf = initial_parameters(5)
    eta_n = initial_parameters(7)
    Area_e = initial_parameters(8)

    n_M2 = int((M2_max - M2_int) / d_M2 + 2)
    n_Tt3 = int((Tt3_max - Tt3_int) / d_Tt3 + 1)
    allocate(design_array(n_M2*n_Tt3,4))

    ! Calculations from Module 1
    allocate(dummy_array(7))
    dummy_array = M1_all_function(z,M1)
    T1 = dummy_array(1)                                              ! K
    p1 = dummy_array(2)                                              ! kPa
    Tt1 = dummy_array(3)                                             ! K
    pt1 = dummy_array(4)                                             ! kPa
    cp1 = dummy_array(5)                                             !J/kg-K
    a1 = dummy_array(6)                                              ! m/s
    V1 = dummy_array(7)                                              ! m/s
    deallocate(dummy_array)

    open(newunit=io,file='./propulsion_design_files/design_data.csv',&
         status='replace',action='write',iostat=ios)
    do i = 1,n_M2
        M2 = M2_int + d_M2 * int(i - 1)
        Tt3 = Tt3_int
        do j = 1,n_Tt3
            ! Calculations from Module 2
            allocate(dummy_array(8))
            dummy_array = M2_all_function(Tt1,p1,pt1,M1,M2,eta_d)
            Tt2 = dummy_array(1)                                     ! K
            T2 = dummy_array(2)                                      ! K
            pt2 = dummy_array(3)                                     ! kPa
            p2 = dummy_array(4)                                      ! kPa
            cp2 = dummy_array(5)                                     ! J/kg-K
            a2 = dummy_array(6)                                      ! m/s
            V2 = dummy_array(7)                                      ! m/s
            delta_s12 = dummy_array(8)                               ! J/kg-K
            deallocate(dummy_array)

            ! Calculations from Module 3
            allocate(dummy_array(9))
            dummy_array = M3_all_function(Tt2,Tt3_max,p2,pt2,M2,delta_s12,Tt3)
            M3 = dummy_array(2)                                      !
            q23 = dummy_array(3)                                     ! MJ/kg
            T3 = dummy_array(4)                                      ! K
            p3 = dummy_array(5)                                      ! kPa
            pt3 = dummy_array(6)                                     ! kPa
            cp3 = dummy_array(7)                                     ! J/kg-K
            delta_s23 = dummy_array(8)                               ! J/kg-K
            delta_s13 = dummy_array(9)                               ! J/kg-K
            deallocate(dummy_array)

            ! Calculations from Module 4
            allocate(dummy_array(11))
            dummy_array = M4_all_function(Tt3,p1,pt3,eta_n,delta_s13,Area_e)
            Me = dummy_array(1)                                      !
            pte = dummy_array(2)                                     ! kPa
            pe = dummy_array(3)                                      ! kPa
            Tte = dummy_array(4)                                     ! K
            Te = dummy_array(5)                                      ! K
            cpe = dummy_array(6)                                     ! J/kg-K
            ae = dummy_array(7)                                      ! m/s
            Ve = dummy_array(8)                                      ! m/s
            me_dot = dummy_array(9)                                  ! kg/s
            delta_s3e = dummy_array(10)                              ! J/kg-K
            delta_s1e = dummy_array(11)                              ! J/kg-K
            deallocate(dummy_array)

            ! Calculations from Module 5
            allocate(dummy_array(10))
            dummy_array = M5_all_function(p1,pt3,pte,Tte,eta_n,delta_s1e)
            M4 = dummy_array(1)                                      !
            pt4 = dummy_array(2)                                     ! kPa
            p4 = dummy_array(3)                                      ! kPa
            Tt4 = dummy_array(4)                                     ! K
            T4 = dummy_array(5)                                      ! K
            cp4 = dummy_array(6)                                     ! J/kg-K
            a4 = dummy_array(7)                                      ! m/s
            V4 = dummy_array(8)                                      ! m/s
            delta_se4 = dummy_array(9)                               ! J/kg-K
            delta_s14 = dummy_array(10)                              ! J/kg-K
            deallocate(dummy_array)

            ! Calculations from Module 6
            allocate(dummy_array(13))
            dummy_array = M6_all_function(q23,qf,me_dot,Ve,V1,pe,p1,p1,Area_e)
            mf_dot = dummy_array(1)                                  ! kg/s
            mi_dot = dummy_array(2)                                  ! kg/s
            f = dummy_array(3)
            jet_thrust = dummy_array(4)                              ! N
            pressure_thrust = dummy_array(5)                         ! N
            total_thrust = dummy_array(6)                            ! N
            Veq = dummy_array(7)                                     ! m/s
            TSFC = dummy_array(8)                                    ! (kg/hr)/N
            Isp = dummy_array(9)                                     ! s
            eta_th = dummy_array(10)
            eta_p = dummy_array(11)
            eta_o = dummy_array(12)
            prop_power = dummy_array(13)                             ! MW
            deallocate(dummy_array)

            design_array(j + n_Tt3 * (i-1),:) = [M2,Tt3,total_thrust,eta_o]

            write(io,"(F20.10, ',', F20.10, ',', F20.10, ',', F20.10)")&
                  M2, Tt3, total_thrust, eta_o

            Tt3 = Tt3 + d_Tt3
        end do
        write(io,*)
    end do
    close(io)
    do i = 3,4
        n = MAXLOC(design_array(:,i))
        print *, 'Design that optimizes total thrust'
        print *, 'M2:', design_array(n,1), 'Tt3:', design_array(n,2),&
                 'Total thrust:', design_array(n,3),&
                 'Overall Efficiency:', design_array(n,4)
    end do
    call execute_command_line('gnuplot ./propulsion_design_files/&
                             &design_plot.gp')
end program propulsion_system_design