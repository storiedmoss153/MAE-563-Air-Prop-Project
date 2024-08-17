# mach_test_plot.gp
set term pdf dashed enhanced font "Times,15" size 4.25,2.4375
set key outside box w 1 h 1 # font "Times,13"
set output './mach_test/mach_test_plot_mach.pdf'
set xlabel "Iterated Parameter"
set ylabel "Mach Number"
set grid
plot './mach_test/mach_test_plot.csv' u 1:2 w l lw 2 lc rgb "black" dt 1 t 'M_3',\
     './mach_test/mach_test_plot.csv' u 1:3 w l lw 2 lc rgb "black" dt 2 t 'M_e',\
     './mach_test/mach_test_plot.csv' u 1:4 w l lw 2 lc rgb "black" dt 3 t 'M_4'
set output

set output './mach_test/mach_test_plot_tempstat.pdf'
set ylabel "Static Temperature, K"
plot './mach_test/mach_test_plot.csv' u 1:5 w l lw 2 lc rgb "black" dt 1 t 'T_{1}',\
     './mach_test/mach_test_plot.csv' u 1:6 w l lw 2 lc rgb "black" dt 2 t 'T_{2}',\
     './mach_test/mach_test_plot.csv' u 1:7 w l lw 2 lc rgb "black" dt 3 t 'T_{3}',\
     './mach_test/mach_test_plot.csv' u 1:8 w l lw 2 lc rgb "black" dt 4 t 'T_{e}',\
     './mach_test/mach_test_plot.csv' u 1:9 w l lw 2 lc rgb "black" dt 5 t 'T_{4}'
set output

set output './mach_test/mach_test_plot_prestot.pdf'
set ylabel "Total Pressure, kPa"
plot './mach_test/mach_test_plot.csv' u 1:10 w l lw 2 lc rgb "black" dt 1 t 'p_{t1}',\
     './mach_test/mach_test_plot.csv' u 1:11 w l lw 2 lc rgb "black" dt 2 t 'p_{t2}',\
     './mach_test/mach_test_plot.csv' u 1:12 w l lw 2 lc rgb "black" dt 3 t 'p_{t3}',\
     './mach_test/mach_test_plot.csv' u 1:13 w l lw 2 lc rgb "black" dt 4 t 'p_{te}',\
     './mach_test/mach_test_plot.csv' u 1:14 w l lw 2 lc rgb "black" dt 5 t 'p_{t4}'
set output

set output './mach_test/mach_test_plot_mass.pdf'
set ylabel "Mass Flow Rate, kg/s"
plot './mach_test/mach_test_plot.csv' u 1:15 w l lw 2 lc rgb "black" dt 1 t 'ṁ_e',\
     './mach_test/mach_test_plot.csv' u 1:16 w l lw 2 lc rgb "black" dt 2 t 'ṁ_i',\
     './mach_test/mach_test_plot.csv' u 1:17 w l lw 2 lc rgb "black" dt 3 t 'ṁ_f'
set output

set output './mach_test/mach_test_plot_thrust.pdf'
set ylabel "Thrust, kN"
plot './mach_test/mach_test_plot.csv' u 1:18 w l lw 2 lc rgb "black" dt 1 t 'T_{jet}',\
     './mach_test/mach_test_plot.csv' u 1:19 w l lw 2 lc rgb "black" dt 2 t 'T_{pressure}',\
     './mach_test/mach_test_plot.csv' u 1:20 w l lw 2 lc rgb "black" dt 3 t 'T_{total}'
set output

set output './mach_test/mach_test_plot_dimless.pdf'
set ylabel "Efficiency and Fuel-Air Mass Ratio"
plot './mach_test/mach_test_plot.csv' u 1:21 w l lw 2 lc rgb "black" dt 1 t 'f',\
     './mach_test/mach_test_plot.csv' u 1:22 w l lw 2 lc rgb "black" dt 2 t '{/Symbol h}_{th}',\
     './mach_test/mach_test_plot.csv' u 1:23 w l lw 2 lc rgb "black" dt 3 t '{/Symbol h}_p',\
     './mach_test/mach_test_plot.csv' u 1:24 w l lw 2 lc rgb "black" dt 4 t '{/Symbol h}_o'
set output

set output './mach_test/mach_test_plot_velo.pdf'
set ylabel "Velocity, m/s"
plot './mach_test/mach_test_plot.csv' u 1:25 w l lw 2 lc rgb "black" dt 1 t 'V_1',\
     './mach_test/mach_test_plot.csv' u 1:26 w l lw 2 lc rgb "black" dt 2 t 'V_2',\
     './mach_test/mach_test_plot.csv' u 1:27 w l lw 2 lc rgb "black" dt 3 t 'V_e',\
     './mach_test/mach_test_plot.csv' u 1:28 w l lw 2 lc rgb "black" dt 4 t 'V_4',\
     './mach_test/mach_test_plot.csv' u 1:29 w l lw 2 lc rgb "black" dt 5 t 'V_{eq}'
set output

set output './mach_test/mach_test_plot_heat.pdf'
set ylabel "Heat per Unit Mass, MJ/kg"
plot './mach_test/mach_test_plot.csv' u 1:30 w l lw 2 lc rgb "black" dt 1 t 'q_{23}'
set output

set output './mach_test/mach_test_plot_sos.pdf'
set ylabel "Speed of Sound, m/s"
plot './mach_test/mach_test_plot.csv' u 1:36 w l lw 2 lc rgb "black" dt 1 t 'a_1',\
     './mach_test/mach_test_plot.csv' u 1:37 w l lw 2 lc rgb "black" dt 2 t 'a_2',\
     './mach_test/mach_test_plot.csv' u 1:38 w l lw 2 lc rgb "black" dt 3 t 'a_e',\
     './mach_test/mach_test_plot.csv' u 1:39 w l lw 2 lc rgb "black" dt 4 t 'a_4'
set output

set output './mach_test/mach_test_plot_delent.pdf'
set ylabel "Entropy Change, J/(kg-K)"
plot './mach_test/mach_test_plot.csv' u 1:40 w l lw 2 lc rgb "black" dt 1 t '{/Symbol D}s_{12}',\
     './mach_test/mach_test_plot.csv' u 1:41 w l lw 2 lc rgb "black" dt 2 t '{/Symbol D}s_{23}',\
     './mach_test/mach_test_plot.csv' u 1:42 w l lw 2 lc rgb "black" dt 3 t '{/Symbol D}s_{3e}',\
     './mach_test/mach_test_plot.csv' u 1:43 w l lw 2 lc rgb "black" dt 4 t '{/Symbol D}s_{e4}'
set output

set term pdf dashed enhanced font "Times,15" size 5,2.4375

set output './mach_test/mach_test_plot_presstat.pdf'
set ylabel "Static Pressure, kPa"
plot './mach_test/mach_test_plot.csv' u 1:33 w l lw 2 lc rgb "black" dt 1 t 'p_1 = p_4',\
     './mach_test/mach_test_plot.csv' u 1:34 w l lw 2 lc rgb "black" dt 2 t 'p_2 = p_3',\
     './mach_test/mach_test_plot.csv' u 1:35 w l lw 2 lc rgb "black" dt 3 t 'p_e'
set output

set term pdf dashed enhanced font "Times,15" size 5.375,2.4375

set output './mach_test/mach_test_plot_temptot.pdf'
set ylabel "Total Temperature, K"
plot './mach_test/mach_test_plot.csv' u 1:31 w l lw 2 lc rgb "black" dt 1 t 'T_{t1} = T_{t2}',\
     './mach_test/mach_test_plot.csv' u 1:32 w l lw 2 lc rgb "black" dt 2 t 'T_{t3} = T_{te} = T_{t4}'
set output