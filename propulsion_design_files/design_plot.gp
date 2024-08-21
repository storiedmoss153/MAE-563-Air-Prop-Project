# test_design_plot.gp
set term pdf color enhanced font "Times,14" size 4,2.4375
set datafile separator ","
set output 'propulsion_design_files/total_thrust_plot.pdf'
set size .8125,1
set origin .09375,0

unset key
set grid xtics ytics ztics vert

set xrange reverse
set xlabel "Combustor Exit\nTotal Temperature, K" offset -1,-1
set ylabel "Combustor Inlet Mach" offset 0,-1
set zlabel "Total Thrust, kN" rotate by 90 # offset -1,0
set format z '%.0s'

set xtics 300 offset .5,-.5
set ytics offset .5,-.5
set ztics offset .5,.5

set colorbox user origin .85,.225 size .05,.55
set cbtics format "%.0s"

set view 60,70
set ticslevel 0
set pm3d border retrace
set palette rgb 30,31,32

splot 'propulsion_design_files/design_data_1.csv' u 2:1:3 w pm3d, \
      'propulsion_design_files/design_data_2.csv' u 2:1:3 w l lc rgb "black"
set output
set cbtics format
set format z '%.1f'

set output 'propulsion_design_files/eta_o_plot.pdf'
set zrange [-2.5:.5]
set zlabel "Overall Efficiency" rotate by 90 offset -2,0

splot 'propulsion_design_files/design_data_1.csv' u 2:1:($4) w pm3d,\
      'propulsion_design_files/design_data_2.csv' u 2:1:($4) w l lc rgb "black"
set output
