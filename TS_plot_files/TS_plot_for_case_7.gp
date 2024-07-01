# TS_plot_for_case_7.gp
set term pdf dashed enhanced font "Times,15" size 5.375,2.4375
set output './TS_plot_files/TS_plot_for_case_7.pdf'
set termopt enhanced
set key outside box w -3 h .5
set xrange [-100:2500]
set yrange [0:2500]
set xlabel "Specific Entropy Increase, J/kg-K"
set ylabel "Static Temperature, K"
set grid

plot './TS_plot_files/case7_TS_12_data.csv' ev ::0::0 w p pt 6 lc rgb "black" t "State 1",\
     './TS_plot_files/case7_TS_12_data.csv' w l lw 2 lc rgb "black" dt 1 t "Ram Compression, 1-2",\
     './TS_plot_files/case7_TS_12_data.csv' ev ::1::1 w p pt 8 lc rgb "black" t "State 2",\
     './TS_plot_files/case7_TS_23_data.csv' w l lw 2 lc rgb "black" dt 2 t "Isobaric Combustion, 2-3",\
     './TS_plot_files/case7_TS_3e_data.csv' ev ::0::0 w p pt 4 lc rgb "black" t "State 3",\
     './TS_plot_files/case7_TS_3e_data.csv' w l lw 2 lc rgb "black" dt 3 t "Nozzle Expansion, 3-e",\
     './TS_plot_files/case7_TS_3e_data.csv' ev ::1::1 w p pt 12 lc rgb "black" t "State e",\
     './TS_plot_files/case7_TS_e4_data.csv' w l lw 2 lc rgb "black" dt 4 t "External Flow, e-4",\
     './TS_plot_files/case7_TS_e4_data.csv' ev ::1::1 w p pt 14 lc rgb "black" t "State 4",\
     './TS_plot_files/case7_TS_41_data.csv' w l lw 2 lc rgb "black" dt 5 t "Isobaric Heat Removal, 4-1"

set output