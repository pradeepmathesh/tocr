awk -f 4050.awk  output.report.feature 1> map_4067
awk -f 4050.awk_1col  output.report.feature 1> ground_tr_freq
cp map_4067 /home/pradeep/Desktop/project/dataset/map_4067
x=0;for i in `freq ground_tr_freq | cut -d " " -f2`; do x=`expr $x + $i`; done ; echo $x
