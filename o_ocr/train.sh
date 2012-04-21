if [ -z "$1" ]
then
echo "Usage: `basename $0` 0(test) or 1(train)"
exit 1;
fi
dirprefix="/home/pradeep/Desktop/project/dataset/"
#sfile=$dirprefix"feature_jan_flusser_num1250.txt"
#sfile=$dirprefix"feature_num1250.txt" 
if [ $1 -eq 1 ]
then
sfile=$dirprefix"feature_train.txt"
dfile=$dirprefix"feature_tr_sorted.txt"
cat $sfile | sort -n -k1,1 &> $dfile
#awk -f 4050.awk  output.report.feature 1> output_feature_4067
#awk -f 4050.awk_1col  output.report.feature 1> ground_tr_freq
#freq ground_tr_freq
#x=0;for i in `freq ground_tr_freq | cut -d " " -f2`; do x=`expr $x + $i`; done ; echo $x
#cat output_feature_1250 | awk {'print $2'} &> /tmp/v
#../dataset/1250_map_numfinal
#join $dirprefix"1250_map_numfinal" $dirprefix"feature_num1250_sorted.txt" &> /tmp/v
join $dirprefix"map_16_4201" $dfile 1> /tmp/v
cat /tmp/v | cut -d " " -f2- 1> $dirprefix"feature_tr_label.txt"
cat $dirprefix"feature_tr_label.txt" | sort -n -k1,1 1> $dirprefix"feature_tr_label_sorted.txt"
#for i in k ka ki kI cu
#for i in h  La  pi  A  Tu  ca  I  ng  ng  Ti  e  ru  ri  ci  ki  tu  G  ra  na  ku  la  Ta  ma  ya  rr  L  ta  va  f  c  v  pa  y  g  l  T  ka  n  p  t  m  r  u  i  k  a
#for i in  b ka pa va m k ma g f ya ta Ta r la p G l n tu i ra na rr t T ku ki ci La Tu rra ti ru a L ca nH w wa N pi A rru Ti e u rri ri mu Li yi c pu vi S Lu li wi o mi y zhi zhu zha lu vu Ni Na wU mI yu ni E pU vI Si nu ng kU kI cu z wI Sa nHU LU ja cI Sh pI mU ai zh yU v tU sa O nI nHi ji I hI ha cU
#for i in "*" \#
#do
grep -v "^[#*]"  $dirprefix"feature_tr_label_sorted.txt" 1> /tmp/v2 #$dirprefix"feature_tr_dom" # remove junk characters from training
#done
rm $dirprefix"feature_tr_dom"
for i in  b ka pa
do
grep "^$i" /tmp/v2 >> $dirprefix"feature_tr_dom"
done
#cp /tmp/v2 $dirprefix"feature_tr_dom"
#sh  /home/pradeep/scripts/label_final.sh
#sh  /home/pradeep/scripts/sidekick.sh
#sh /home/pradeep/scripts/createmodel.sh

cat $dirprefix"feature_tr_dom" |
sed     '
	s/ksa/155/g
	s/ksi/154/g
	s/ksI/153/g
	s/ksu/152/g
	s/ksU/151/g
	s/Sha/150/g
	s/Shi/149/g
	s/ShI/148/g
	s/Shu/147/g
	s/ShU/146/g
	s/Sri/145/g
	s/nHa/144/g
	s/nga/143/g
	s/zha/142/g
	s/rra/141/g
	s/nHi/140/g
	s/ngi/139/g
	s/zhi/138/g
	s/rri/137/g
	s/nHI/136/g
	s/ngI/135/g
	s/zhI/134/g
	s/rrI/133/g
	s/nHu/132/g
	s/ngu/131/g
	s/zhu/130/g
	s/rru/129/g
	s/rrU/128/g
	s/zhU/127/g
	s/ngU/126/g
	s/nHU/125/g
	s/ai/124/g
	s/nH/123/g
	s/ng/122/g
	s/ka/121/g
	s/rr/120/g
	s/ca/119/g
	s/zh/118/g
	s/Ta/117/g
	s/Na/116/g
	s/ta/115/g
	s/wa/114/g
	s/pa/113/g
	s/ma/112/g
	s/ya/111/g
	s/ra/110/g
	s/la/109/g
	s/va/108/g
	s/La/107/g
	s/na/106/g
	s/ki/105/g
	s/ci/104/g
	s/Ti/103/g
	s/Ni/102/g
	s/ti/101/g
	s/wi/100/g
	s/pi/99/g
	s/mi/98/g
	s/yi/97/g
	s/ri/96/g
	s/li/95/g
	s/vi/94/g
	s/Li/93/g
	s/ni/92/g
	s/kI/91/g
	s/cI/90/g
	s/TI/89/g
	s/NI/88/g
	s/tI/87/g
	s/wI/86/g
	s/pI/85/g
	s/mI/84/g
	s/yI/83/g
	s/rI/82/g
	s/lI/81/g
	s/vI/80/g
	s/LI/79/g
	s/nI/78/g
	s/ku/77/g
	s/cu/76/g
	s/Tu/75/g
	s/Nu/74/g
	s/tu/73/g
	s/wu/72/g
	s/pu/71/g
	s/mu/70/g
	s/yu/69/g
	s/ru/68/g
	s/lu/67/g
	s/vu/66/g
	s/Lu/65/g
	s/nu/64/g
	s/kU/63/g
	s/cU/62/g
	s/Sh/61/g
	s/Sa/60/g
	s/Si/59/g
	s/SI/58/g
	s/Su/57/g
	s/SU/56/g
	s/ha/55/g
	s/hi/54/g
	s/hI/53/g
	s/hu/52/g
	s/hU/51/g
	s/ja/50/g
	s/ji/49/g
	s/jI/48/g
	s/ju/47/g
	s/jU/46/g
	s/TU/45/g
	s/NU/44/g
	s/tU/43/g
	s/wU/42/g
	s/pU/41/g
	s/mU/40/g
	s/yU/39/g
	s/rU/38/g
	s/lU/37/g
	s/vU/36/g
	s/ks/35/g
	s/LU/34/g
	s/nU/33/g
	s/a/32/g
	s/A/31/g
	s/i/30/g
	s/I/29/g
	s/u/28/g
	s/U/27/g
	s/e/26/g
	s/E/25/g
	s/o/24/g
	s/O/23/g
	s/k/22/g
	s/c/21/g
	s/T/20/g
	s/N/19/g
	s/t/18/g
	s/w/17/g
	s/p/16/g
	s/m/15/g
	s/y/14/g
	s/r/13/g
	s/l/12/g
	s/v/11/g
	s/L/10/g
	s/n/9/g
	s/g/8/g
	s/G/7/g
	s/f/6/g
	s/j/5/g
	s/S/4/g
	s/h/3/g
	s/z/2/g
	s/b/1/g' 1>  $dirprefix"feature_tr_final" 
awk '{for (i=NF; i>0; i--) printf("%s ",$i);printf ("\n")}' $dirprefix"feature_tr_final" 1> $dirprefix"feature_tr_final_1" 
x=`grep -c "" $dirprefix"feature_tr_final_1"`
printf "$x\n555\n" 1> $dirprefix"pa_tr"
cat $dirprefix"pa_tr"  $dirprefix"feature_tr_final_1" 1> $dirprefix"feature_tr_final_2"
trainmsvm  $dirprefix"feature_tr_final_2" $dirprefix"myMSVM.model" -n &> "$dirprefix"`date +%h_%d_%s_%N`".trdump"
#trainmsvm  $dirprefix"feature_tr_final_2" $dirprefix"myMSVM.model" -n -m WW -c 3.0 -k 2 -p 2.5
else
sfile=$dirprefix"feature_test.txt"
dfile=$dirprefix"feature_ts_sorted.txt"
cat $sfile | sort -n -k1,1 &> $dfile
#awk -f 4050.awk  output.report.feature 1> output_feature_4067
#awk -f 4050.awk_1col  output.report.feature 1> ground_tr_freq
#freq ground_tr_freq
#x=0;for i in `freq ground_tr_freq | cut -d " " -f2`; do x=`expr $x + $i`; done ; echo $x
#cat output_feature_1250 | awk {'print $2'} &> /tmp/v
#../dataset/1250_map_numfinal
#join $dirprefix"1250_map_numfinal" $dirprefix"feature_num1250_sorted.txt" &> /tmp/v
join $dirprefix"map_4067" $dfile 1> /tmp/v
cat /tmp/v | cut -d " " -f2- 1> $dirprefix"feature_ts_label.txt"
cat $dirprefix"feature_ts_label.txt" | sort -n -k1,1 1> $dirprefix"feature_ts_label_sorted.txt"
#for i in k ka ki kI cu
#for i in h  La  pi  A  Tu  ca  I  ng  ng  Ti  e  ru  ri  ci  ki  tu  G  ra  na  ku  la  Ta  ma  ya  rr  L  ta  va  f  c  v  pa  y  g  l  T  ka  n  p  t  m  r  u  i  k  a
#for i in  b ka pa va m k ma g f ya ta Ta r la p G l n tu i ra na rr t T ku ki ci La Tu rra ti ru a L ca nH w wa N pi A rru Ti e u rri ri mu Li yi c pu vi S Lu li wi o mi y zhi zhu zha lu vu Ni Na wU mI yu ni E pU vI Si nu ng kU kI cu z wI Sa nHU LU ja cI Sh pI mU ai zh yU v tU sa O nI nHi ji I hI ha cU
#for i in "*" \#
#do
grep -v "^[#*]"  $dirprefix"feature_ts_label_sorted.txt" 1> /tmp/v3 #$dirprefix"feature_ts_dom" # remove junk characters from training
rm $dirprefix"feature_ts_dom"	
for i in  b ka pa
do
grep "^$i" /tmp/v3 >> $dirprefix"feature_ts_dom"
done
#cp /tmp/v3 $dirprefix"feature_ts_dom"
#done
#sh  /home/pradeep/scripts/label_final.sh
#sh  /home/pradeep/scripts/sidekick.sh
#sh /home/pradeep/scripts/createmodel.sh

cat $dirprefix"feature_ts_dom" |
sed     '
	s/ksa/155/g
	s/ksi/154/g
	s/ksI/153/g
	s/ksu/152/g
	s/ksU/151/g
	s/Sha/150/g
	s/Shi/149/g
	s/ShI/148/g
	s/Shu/147/g
	s/ShU/146/g
	s/Sri/145/g
	s/nHa/144/g
	s/nga/143/g
	s/zha/142/g
	s/rra/141/g
	s/nHi/140/g
	s/ngi/139/g
	s/zhi/138/g
	s/rri/137/g
	s/nHI/136/g
	s/ngI/135/g
	s/zhI/134/g
	s/rrI/133/g
	s/nHu/132/g
	s/ngu/131/g
	s/zhu/130/g
	s/rru/129/g
	s/rrU/128/g
	s/zhU/127/g
	s/ngU/126/g
	s/nHU/125/g
	s/ai/124/g
	s/nH/123/g
	s/ng/122/g
	s/ka/121/g
	s/rr/120/g
	s/ca/119/g
	s/zh/118/g
	s/Ta/117/g
	s/Na/116/g
	s/ta/115/g
	s/wa/114/g
	s/pa/113/g
	s/ma/112/g
	s/ya/111/g
	s/ra/110/g
	s/la/109/g
	s/va/108/g
	s/La/107/g
	s/na/106/g
	s/ki/105/g
	s/ci/104/g
	s/Ti/103/g
	s/Ni/102/g
	s/ti/101/g
	s/wi/100/g
	s/pi/99/g
	s/mi/98/g
	s/yi/97/g
	s/ri/96/g
	s/li/95/g
	s/vi/94/g
	s/Li/93/g
	s/ni/92/g
	s/kI/91/g
	s/cI/90/g
	s/TI/89/g
	s/NI/88/g
	s/tI/87/g
	s/wI/86/g
	s/pI/85/g
	s/mI/84/g
	s/yI/83/g
	s/rI/82/g
	s/lI/81/g
	s/vI/80/g
	s/LI/79/g
	s/nI/78/g
	s/ku/77/g
	s/cu/76/g
	s/Tu/75/g
	s/Nu/74/g
	s/tu/73/g
	s/wu/72/g
	s/pu/71/g
	s/mu/70/g
	s/yu/69/g
	s/ru/68/g
	s/lu/67/g
	s/vu/66/g
	s/Lu/65/g
	s/nu/64/g
	s/kU/63/g
	s/cU/62/g
	s/Sh/61/g
	s/Sa/60/g
	s/Si/59/g
	s/SI/58/g
	s/Su/57/g
	s/SU/56/g
	s/ha/55/g
	s/hi/54/g
	s/hI/53/g
	s/hu/52/g
	s/hU/51/g
	s/ja/50/g
	s/ji/49/g
	s/jI/48/g
	s/ju/47/g
	s/jU/46/g
	s/TU/45/g
	s/NU/44/g
	s/tU/43/g
	s/wU/42/g
	s/pU/41/g
	s/mU/40/g
	s/yU/39/g
	s/rU/38/g
	s/lU/37/g
	s/vU/36/g
	s/ks/35/g
	s/LU/34/g
	s/nU/33/g
	s/a/32/g
	s/A/31/g
	s/i/30/g
	s/I/29/g
	s/u/28/g
	s/U/27/g
	s/e/26/g
	s/E/25/g
	s/o/24/g
	s/O/23/g
	s/k/22/g
	s/c/21/g
	s/T/20/g
	s/N/19/g
	s/t/18/g
	s/w/17/g
	s/p/16/g
	s/m/15/g
	s/y/14/g
	s/r/13/g
	s/l/12/g
	s/v/11/g
	s/L/10/g
	s/n/9/g
	s/g/8/g
	s/G/7/g
	s/f/6/g
	s/j/5/g
	s/S/4/g
	s/h/3/g
	s/z/2/g
	s/b/1/g' 1>  $dirprefix"feature_ts_final" 
awk '{for (i=NF; i>0; i--) printf("%s ",$i);printf ("\n")}' $dirprefix"feature_ts_final" 1> $dirprefix"feature_ts_final_1" 
x=`grep -c "" $dirprefix"feature_ts_final_1"`
printf "$x\n555\n" 1> $dirprefix"pa_ts"
cat $dirprefix"pa_ts"  $dirprefix"feature_ts_final_1" 1> $dirprefix"feature_ts_final_2"
predmsvm  $dirprefix"feature_ts_final_2" $dirprefix"myMSVM.model" $dirprefix"pred.outputs" &> "$dirprefix"`date +%h_%d_%s_%N`".tsdump"
fi