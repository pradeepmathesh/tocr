dirprefix="/home/pradeep/Desktop/project/dataset/"
#sfile=$dirprefix"feature_jan_flusser_num1250.txt"
#sfile=$dirprefix"feature_num1250.txt" 
sfile=$dirprefix"feature_train.txt"
dfile=$dirprefix"feature_num1250_sorted.txt"
cat $sfile | sort -n -k1 &> $dfile
#awk -f 4050.awk  output.report.feature 1> output_feature_4067
#awk -f 4050.awk_1col  output.report.feature 1> ground_tr_freq
#freq ground_tr_freq
#x=0;for i in `freq ground_tr_freq | cut -d " " -f2`; do x=`expr $x + $i`; done ; echo $x
#cat output_feature_1250 | awk {'print $2'} &> /tmp/v
#../dataset/1250_map_numfinal
#join $dirprefix"1250_map_numfinal" $dirprefix"feature_num1250_sorted.txt" &> /tmp/v
join $dirprefix"map_4067" $dirprefix"feature_num1250_sorted.txt" 1> /tmp/v
cat /tmp/v | cut -d " " -f2- 1> $dirprefix"feature_num1250_romanized.txt"
cat $dirprefix"feature_num1250_romanized.txt" | sort -n -k1 1> $dirprefix"feature_num1250_romanized_sorted.txt"
rm $dirprefix"iso_f1_k"
#for i in k ka ki kI cu
#for i in h  La  pi  A  Tu  ca  I  ng  ng  Ti  e  ru  ri  ci  ki  tu  G  ra  na  ku  la  Ta  ma  ya  rr  L  ta  va  f  c  v  pa  y  g  l  T  ka  n  p  t  m  r  u  i  k  a
#for i in  b ka pa va m k ma g f ya ta Ta r la p G l n tu i ra na rr t T ku ki ci La Tu rra ti ru a L ca nH w wa N pi A rru Ti e u rri ri mu Li yi c pu vi S Lu li wi o mi y zhi zhu zha lu vu Ni Na wU mI yu ni E pU vI Si nu ng kU kI cu z wI Sa nHU LU ja cI Sh pI mU ai zh yU v tU sa O nI nHi ji I hI ha cU
#for i in "*" \#
#do
	grep -v "^[#*] "  $dirprefix"feature_num1250_romanized_sorted.txt" 1> $dirprefix"iso_f1_k"
#done
sh  /home/pradeep/scripts/label_final.sh
#sh  /home/pradeep/scripts/sidekick.sh
#sh /home/pradeep/scripts/createmodel.sh
