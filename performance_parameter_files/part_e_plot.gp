# part_e_plot.gp
set term pdf dashed enhanced font "Times,15" size 3.25,2.4375
set output './performance_parameter_files/part_e_range_1_5.pdf'
set key box
set format x '%.0s'
set format y '%.1f'
set xlabel "Flight Altitude, km"
set ylabel "Flight Mach Number"
set grid
set yrange [1.5:5.5]
plot './performance_parameter_files/part_e_data_range_1_5.csv' u 1:2 w l lw 2 lc rgb "black" dt 1 t "Maximizes {/Symbol h}_o",\
     './performance_parameter_files/part_e_data_range_1_5.csv' u 1:3 w l lw 2 lc rgb "black" dt 2 t "Minimizes TSFC"
set output

set output './performance_parameter_files/part_e_range_1_10.pdf'
set yrange [4.5:8]
plot './performance_parameter_files/part_e_data_range_1_10.csv' u 1:2 w l lw 2 lc rgb "black" dt 1 t "Maximizes {/Symbol h}_o",\
     './performance_parameter_files/part_e_data_range_1_10.csv' u 1:3 w l lw 2 lc rgb "black" dt 2 t "Minimizes TSFC"
set output