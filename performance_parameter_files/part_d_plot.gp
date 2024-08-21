# part_d_plot.gp
set term pdf dashed enhanced font "Times,15" size 3.25,2.4375
set datafile separator ","
set output './performance_parameter_files/part_d_eta_o.pdf'
unset key
set format x '%.0s'
set xlabel "Flight Altitude, km"
set ylabel "Overall Efficiency"
set grid
plot './performance_parameter_files/part_d_data.csv' u 1:2 w l lw 2 lc rgb "black" dt 1
set output

set output './performance_parameter_files/part_d_T.pdf'
set ylabel "Total Thrust, kN"
set format y '%.0s'
plot './performance_parameter_files/part_d_data.csv' u 1:3 w l lw 2 lc rgb "black" dt 1
set output
unset format y

set output './performance_parameter_files/part_d_TSFC.pdf'
set ylabel "TSFC, (kg/hr)/N"
plot './performance_parameter_files/part_d_data.csv' u 1:4 w l lw 2 lc rgb "black" dt 1
set output