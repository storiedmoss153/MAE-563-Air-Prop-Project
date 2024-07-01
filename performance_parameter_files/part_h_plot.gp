# part_h_plot.gp
set term pdf dashed enhanced font "Times,15" size 3.25,2.4375
set output './performance_parameter_files/part_h_eta_o.pdf'
unset key
set xlabel "Mach Number M_2"
set ylabel "Overall Efficiency"
set grid
set datafile separator ","
plot "<awk '{if(($2) != \"********************\") print} ' ./performance_parameter_files/part_h_data.csv" \
u ($1):($2)  w l lw 2 lc rgb "black" dt 1
set output

set output './performance_parameter_files/part_h_T.pdf'
set ylabel "Total Thrust, kN"
set format y '%.0s'
plot './performance_parameter_files/part_h_data.csv' u 1:3 w l lw 2 lc rgb "black" dt 1
set output
unset format y

set output './performance_parameter_files/part_h_TSFC.pdf'
set ylabel "TSFC, (kg/hr)/N"
plot './performance_parameter_files/part_h_data.csv' u 1:4 w l lw 2 lc rgb "black" dt 1
set output