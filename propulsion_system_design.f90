program propulsion_system_design
    use universal_module
    use auxiliary_module
    use module_6
    use, intrinsic :: iso_fortran_env, only: sp=>real32, dp=>real64
    implicit none

    character(len=50) :: filename
    integer :: i, j, n(1), n_M2, n_Tt3, io1, io2, ios
    real(dp) :: d_M2, d_Tt3, M2_max
    real(dp), allocatable :: dummy_array(:) , design_array_1(:,:)
    real(dp) :: initial_parameters(8)
    real(dp) :: z, M1, M2, M2_int, eta_d, qf, Tt3_max, eta_n, Area_e
    real(dp) :: p1, Tt1, pt1, V1
    real(dp) :: Tt2, pt2, p2, delta_s12
    real(dp) :: Tt3, Tt3_int, q23, pt3, delta_s13
    real(dp) :: pte, pe, Tte, Ve, me_dot, delta_s1e
    real(dp) :: total_thrust
    real(dp) :: eta_o

    write(filename, '(A, I0, A)') 'data_files/input_variables_case',7,'.csv'
    call read_initial_parameters(filename,initial_parameters)

    ! Initialize variables to be used in calculations
    z = 27400._dp
    M1 = 5._dp
    M2_int = 0.01
    M2_max = 4.99
    d_M2 = 0.001
    Tt3_int = 1260
    Tt3_max = initial_parameters(6)
    Tt3_max = 2400
    d_Tt3 = 10
    eta_d = initial_parameters(3)
    qf = initial_parameters(5)
    eta_n = initial_parameters(7)
    Area_e = initial_parameters(8)

    n_M2 = int((M2_max - M2_int) / d_M2 + 2)
    n_Tt3 = int((Tt3_max - Tt3_int) / d_Tt3 + 1)
    allocate(design_array_1(n_M2*n_Tt3,4))

    ! Calculations from Module 1
    allocate(dummy_array(7))
    dummy_array = M1_all_function(z,M1)
    p1 = dummy_array(2)                                              ! kPa
    Tt1 = dummy_array(3)                                             ! K
    pt1 = dummy_array(4)                                             ! kPa
    V1 = dummy_array(7)                                              ! m/s
    deallocate(dummy_array)

    open(newunit=io1,file='propulsion_design_files/design_data_1.csv',&
         status='replace',action='write',iostat=ios)
    open(newunit=io2,file='propulsion_design_files/design_data_2.csv',&
         status='replace',action='write',iostat=ios)
    do i = 1,n_M2
        M2 = M2_int + d_M2 * int(i - 1)
        Tt3 = Tt3_int
        do j = 1,n_Tt3
            ! Calculations from Module 2
            allocate(dummy_array(8))
            dummy_array = M2_all_function(Tt1,p1,pt1,M1,M2,eta_d)
            Tt2 = dummy_array(1)                                     ! K
            pt2 = dummy_array(3)                                     ! kPa
            p2 = dummy_array(4)                                      ! kPa
            delta_s12 = dummy_array(8)                               ! J/kg-K
            deallocate(dummy_array)

            ! Calculations from Module 3
            allocate(dummy_array(9))
            dummy_array = M3_all_function(Tt2,Tt3_max,p2,pt2,M2,delta_s12,Tt3)
            q23 = dummy_array(3)                                     ! MJ/kg
            pt3 = dummy_array(6)                                     ! kPa
            delta_s13 = dummy_array(9)                               ! J/kg-K
            deallocate(dummy_array)

            ! Calculations from Module 4
            allocate(dummy_array(11))
            dummy_array = M4_all_function(Tt3,p1,pt3,eta_n,delta_s13,Area_e)
            pte = dummy_array(2)                                     ! kPa
            pe = dummy_array(3)                                      ! kPa
            Tte = dummy_array(4)                                     ! K
            Ve = dummy_array(8)                                      ! m/s
            me_dot = dummy_array(9)                                  ! kg/s
            delta_s1e = dummy_array(11)                              ! J/kg-K
            deallocate(dummy_array)

            ! Calculations from Module 6
            allocate(dummy_array(13))
            dummy_array = M6_all_function(q23,qf,me_dot,Ve,V1,pe,p1,p1,Area_e)
            total_thrust = dummy_array(6)                            ! N
            eta_o = dummy_array(12)
            deallocate(dummy_array)

            design_array_1(j + n_Tt3 * (i-1),:) = [M2,Tt3,total_thrust,eta_o]

            write(io1,"(F20.10, ',', F20.10, ',', F20.10, ',', F20.10)")&
                  M2, Tt3, total_thrust, eta_o

            Tt3 = Tt3 + d_Tt3
        end do
        do j = 1,n_Tt3
            ! Calculations from Module 3
            allocate(dummy_array(9))
            dummy_array = M3_all_function(Tt2,Tt3_max,p2,pt2,M2,delta_s12)
            Tt3 = dummy_array(1)
            q23 = dummy_array(3)                                     ! MJ/kg
            pt3 = dummy_array(6)                                     ! kPa
            delta_s13 = dummy_array(9)                               ! J/kg-K
            deallocate(dummy_array)

            ! Calculations from Module 4
            allocate(dummy_array(11))
            dummy_array = M4_all_function(Tt3,p1,pt3,eta_n,delta_s13,Area_e)
            pte = dummy_array(2)                                     ! kPa
            pe = dummy_array(3)                                      ! kPa
            Tte = dummy_array(4)                                     ! K
            Ve = dummy_array(8)                                      ! m/s
            me_dot = dummy_array(9)                                  ! kg/s
            delta_s1e = dummy_array(11)                              ! J/kg-K
            deallocate(dummy_array)

            ! Calculations from Module 6
            allocate(dummy_array(13))
            dummy_array = M6_all_function(q23,qf,me_dot,Ve,V1,pe,p1,p1,Area_e)
            total_thrust = dummy_array(6)                            ! N
            eta_o = dummy_array(12)
            deallocate(dummy_array)
        end do
        write(io2,"(F20.10, ',', F20.10, ',', F20.10, ',', F20.10)")&
                M2, Tt3, total_thrust, eta_o
        write(io1,*)
        ! write(io2,*)
    end do
    close(io1)
    close(io2)
    do i = 3,4
        n = MAXLOC(design_array_1(:,i))
        print *, 'Design that optimizes total thrust'
        print *, 'M2:', design_array_1(n,1), 'Tt3:', design_array_1(n,2),&
                 'Total thrust:', design_array_1(n,3),&
                 'Overall Efficiency:', design_array_1(n,4)
    end do
    call execute_command_line('gnuplot propulsion_design_files/design_plot.gp')
end program propulsion_system_design