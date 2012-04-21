tput reset;

#sh ~/scripts/label.sh
echo "Training..."
dirprefix="/home/pradeep/Desktop/project/dataset/"
outfile="$dirprefix"`date +%h_%d_%s_%N`
#svm_multiclass_learn -c 0.01 -t 2 -g 1  "$dirprefix"iso_f1_k_label "$dirprefix"model.dat
#for i in `seq 1 155`
#do
#grep "^$i " "$dirprefix"iso_f1_k_label 1> $dirprefix"test1.dat"
echo "Classifying... $i" >> $outfile
#svm_multiclass_classify "$dirprefix"test1.dat "$dirprefix"model.dat "$dirprefix"output.txt >> $outfile
svm_multiclass_classify "$dirprefix"iso_f1_k_label "$dirprefix"model_train.dat "$dirprefix"output.txt 1> $outfile
#done

