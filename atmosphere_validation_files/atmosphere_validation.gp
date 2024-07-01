# atmosphere_validation.gp
set term pdf dashed enhanced font "Times,15" size 3.25,2.4375
set key box t r w -1 h .5 font "Times,13"
set grid
set format y '%.0s'
set ylabel 'Altitude, km'

set output './atmosphere_validation_files/ICAO_vs_ISEN_pressure.pdf'
set xlabel "Pressure, kPa"
set xrange[0:120]
set yrange[0:30000]
plot './atmosphere_validation_files/ICAO_pres_data.csv' u 2:1 w l lw 2 lc rgb "black" t 'ICAO Std. Atm.',\
     './atmosphere_validation_files/ISEN_pres_data.csv' u 2:1 w l lw 2 lc rgb "black" dt 2 t 'Isentropic Atm.'
set output

set output './atmosphere_validation_files/ICAO_vs_ISEN_temperature.pdf'
set key t l
set xlabel "Temperature, K"
set xrange[0:300]
set yrange[0:30000]
plot './atmosphere_validation_files/ICAO_temp_data.csv' u 2:1 w l lw 2 lc rgb "black" dt 1 t 'ICAO Std. Atm.',\
     './atmosphere_validation_files/ISEN_temp_data.csv' u 2:1 w l lw 2 lc rgb "black" dt 2 t 'Isentropic Atm.',\
     './atmosphere_validation_files/ICAO_temp_delta.csv' u 2:1 w l lw 2 lc rgb "black" dt 4 t 'Std. T_{min}',\
     './atmosphere_validation_files/ICAO_temp_delta.csv' u 3:1 w l lw 2 lc rgb "black" dt 5 t 'Std. T_{max}'
set output