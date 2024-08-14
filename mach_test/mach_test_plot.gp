# mach_test_plot.gp
set term pdf dashed enhanced font "Times,15" size 4.25,2.4375
set key outside box w 1 h 1 # font "Times,13"
set output './mach_test/mach_test_plot_mach.pdf'
set xlabel "Combustor Inlet Mach"
set ylabel "Mach Number"
set grid
plot './mach_test/mach_test_plot.csv' u 1:2 w l lw 2 lc rgb "black" dt 1 t 'M_3',\
     './mach_test/mach_test_plot.csv' u 1:3 w l lw 2 lc rgb "black" dt 2 t 'M_e',\
     './mach_test/mach_test_plot.csv' u 1:4 w l lw 2 lc rgb "black" dt 3 t 'M_4'
set output

set output './mach_test/mach_test_plot_temp.pdf'
set ylabel "Total Temperature"
plot './mach_test/mach_test_plot.csv' u 1:5 w l lw 2 lc rgb "black" dt 1 t 'T_{t3}'
set output

set output './mach_test/mach_test_plot_pres.pdf'
set ylabel "Static Pressure"
plot './mach_test/mach_test_plot.csv' u 1:6 w l lw 2 lc rgb "black" dt 1 t 'p_{2}',\
     './mach_test/mach_test_plot.csv' u 1:7 w l lw 2 lc rgb "black" dt 2 t 'p_{e}'
set output