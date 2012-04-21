#awk -f tes.awk output.report | sed '^ *$/d' &> out.tmp
#awk -f test.awk output.report.tmp 1> v1 #main
awk -f test.awk output.report.feature 1> v1 #sidekick
cat v1 | sort -k1 1> v2
#cat output.report.tmp | tail -n +110 | more
#sh ~/scripts/translit.sh_good #gives v3
#cat  tamilwork/map_sed_order2.txt | awk '{printf "\ts/%s/%s/g\n",$1,$2}' 1> ~/scripts/translit.sh_best
sh ~/scripts/translit.sh_best #gives v3
#c++ ~/tamilfreq.cpp -o freq
#cat v3 | sed    -e 's/^ //'   \ do not translit
cat v3 | sed    -e 's/^ //'   \
		-e 's/ /->/' 	1>  v4
./freq v4 1> v5 
gedit v5 &
cat ~/scripts/mapfinal | tr "\t" " " | tr -s " " | tr " " "\n" | sed '/^ *$/d' &> mapfinale
x=0;for i in `cat v5 | cut -d " " -f2`;do x=`expr $x + $i`; done;echo $x
sh extract.sh 1> v6 # miss hits 
sh extract.sh | sort -k2 1> v6
sh sameclass.sh 1> v7
