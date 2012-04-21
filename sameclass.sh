#!/bin/bash -xv
#this game is about 18 * 5 played between me and computer !!! -:) viola ஔ
for i in \
அ 	ஆ	இ 	ஈ 	உ 	ஊ	எ 	ஏ 	ஐ 	ஒ 	ஓ \
க் 	ங் 	ச் 	ஞ் 	ட் 	ண் 	த் 	ந் 	ப் 	ம் 	ய் 	ர் 	ல் 	வ் 	ழ் 	ள் 	ற் 	ன் \
க 	ங 	ச 	ஞ 	ட 	ண 	த 	ந 	ப 	ம 	ய 	ர 	ல 	வ 	ழ 	ள 	ற 	ன  \
கி 	ஙி 	சி 	ஞி 	டி 	ணி 	தி 	நி 	பி 	மி 	யி 	ரி 	லி 	வி 	ழி 	ளி 	றி 	னி \
கீ 	ஙீ 	சீ 	ஞீ 	டீ 	ணீ 	தீ 	நீ 	பீ 	மீ 	யீ 	ரீ 	லீ 	வீ 	ழீ 	ளீ 	றீ 	னீ  \
கு     ஙு 	சு 	ஞு 	டு 	ணு 	து 	நு 	பு 	மு 	யு 	ரு 	லு 	வு 	ழு 	ளு 	று 	னு \
கூ 	ஙூ 	சூ 	ஞூ 	டூ 	ணூ 	தூ 	நூ 	பூ 	மூ 	யூ 	ரூ 	லூ 	வூ 	ழூ 	ளூ 	றூ 	னூ  ெ  ே ை
do
x=`grep "\->$i " v5`
echo "Possible letters that are classified as $i:"
#grep "\->$i" v5 | sed -e 's/\(.*\)\(->.*\)/\1/'
#if [ $x -gt 0 ]
#then
#echo "$i $x"
echo "$x"
#fi
done
