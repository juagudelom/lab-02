cd estaciones
#promedio velocidad por hora
rm  -f promedio_hora.csv
for file in `ls estacion *.csv`;
 do fileout=$file"_1"
    sed '1d' $file | sed 's/;\([0-9]\):/;0\1:/g' | sort -t \; -k 2 > $fileout
    sed 's/,/./g' $fileout > $file"_2"
	
    awk 'BEGIN  {FS=";"; count=0}  
            {split($2,hour,":")}
            {if(hour[1]==prev){sum+=$4; count++;} else { {if(count>0){printf "%s   %d   %g\n",FILENAME,prev,sum/count;}} sum=$4; count=1; } }
            {prev=hour[1]}'  $file"_2" >> promedio_hora.csv
			
    rm $file"_1" $file"_2"
done

#promedio velocidad por año
rm -f promedio_year.csv
 for file in `ls estacion*.csv`;
 do  sed 's/,/./g' $file | sed '1d' > $file"_"
    awk 'BEGIN {FS=";"; count=0}
            {split($1,year,"/")}
            {if(year[3]==prev){sum+=$4; count++;} else { {if(count>0){printf "%s %d %g\n",FILENAME,2000+prev,sum/count;}} sum=$4; count=1; } }
            {prev=year[3]}' $file"_" >> promedio_year.csv
    rm $file"_"
 done

# Promedio velocidad por mes
rm -f promedio_mes.csv
 for file in `ls estacion*.csv`;
 do fileout=$file"_1"
    sed '1d' $file | sort -t \/ -k 2 > $fileout
    sed 's/,/./g' $fileout > $file"_2"

    awk 'BEGIN {FS=";"; count=0}
            {split($1,mes,"/")}
            {if(mes[2]==prev){sum+=$4; count++;} else { {if(count>0){printf "%s %d %g\n",FILENAME,prev,sum/count;}} sum=$4; count=1; } }
            {prev=mes[2]}' $file"_2" >> promedio_mes.csv
    rm $file"_1" $file"_2"
 done


