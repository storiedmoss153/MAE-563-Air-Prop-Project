# design_plot.gp
# load './propulsion_design_files/gnuplot-palettes-master/inferno.pal'
set term pdf color enhanced font "Times,14" size 4,2.4375 # size 3.25,2.4375
set output './propulsion_design_files/total_thrust_plot.pdf'
set size 0.8125,1
set origin 0.09375,0
set datafile separator ","
unset key
set grid

set xrange reverse
set xlabel "Combustor Exit\nTotal Temperature, K" offset -1,-1
# set yrange [0:3]
set ylabel "Combustor Inlet Mach" offset 0,-1
# set zrange [-5000:2000]
set zlabel "Total Thrust, N" rotate by 90 offset -1,0

set xtics 300 offset 0.5,-0.5
set ytics offset 0.5,-0.5
set ztics offset 0.5,0.5

set colorbox user origin .85,.225 size .05,.55

set view 60,60
set ticslevel 0
set pm3d border retrace
set palette rgb 30,31,32

splot './propulsion_design_files/design_data.csv' u 2:1:3 w pm3d
set output

set output './propulsion_design_files/eta_o_plot.pdf'
# set zrange [-50:10]
set zlabel "Overall Efficiency" rotate by 90

splot "<awk '{if($4 != \"-Infinity\|Infinity\") print}' ./propulsion_design_files/design_data.csv" \
u ($2):($1):($4) w pm3d
set output
