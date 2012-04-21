cat /home/pradeep/class/poems/leisure/project/dataset/output_test16 | awk 'BEGIN{x=1}{print x,$1;x++}' 1> /tmp/v
join  /home/pradeep/class/poems/leisure/project/dataset/map_16_4201 /tmp/v | cut -d " " -f2- 1> v1
cat v1 | sort -k1 1> v2
#cat output.report.tmp | tail -n +110 | more
#sh ~/scripts/translit.sh_good #gives v3
#cat  tamilwork/map_sed_order2.txt | awk '{printf "\ts/%s/%s/g\n",$1,$2}' 1> ~/scripts/translit.sh_best
sh ~/scripts/translit.sh_best #gives v3
#c++ ~/tamilfreq.cpp -o freq
#cat v3 | sed    -e 's/^ //'   \ do not translit
cat v3 | sed    -e 's/^ //'   \
		-e 's/ /->/' 	1>  v4
freq v4 1> v5 
gedit v5 &
#cat ~/scripts/mapfinal | tr "\t" " " | tr -s " " | tr " " "\n" | sed '/^ *$/d' &> mapfinale
x=0;for i in `cat v5 | cut -d " " -f2`;do x=`expr $x + $i`; done;echo $x
#sh ~/scripts/extract.sh 1> v6 # miss hits 
sh ~/scripts/extract.sh | sort -k2,2 1> v6
sh ~/scripts/sameclass.sh 1> v7
#cat v7 | grep -v \*# 1> v8
cat v7 | grep -v [\*\#] 1> v8
#recognition 2232
#clean blobs 3722
#accuracy 0.599677592692101

#sh ~/scripts/accuracy.sh | cut -d " " -f2 | sed -e '/^ *$/d' | tr "\n" "+" | bc
#cat v3 | grep -v "[\*\#]"| wc -l #metric
