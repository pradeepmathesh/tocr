import os
dirprefix="/home/pradeep/Desktop/project/dataset/iso_sam/"
N=4201
f=open("/home/pradeep/Desktop/project/dataset/map_16_4201",'r')
lines = f.readlines()
tmp=""
for i in xrange(N):
	tmp=lines[i].split()
	dst=dirprefix+tmp[1]+"/"
	if tmp[1] != '*' and  tmp[1] != '#':
		src="/home/pradeep/class/poems/leisure/project/dataset/tam/test16_prop/"+tmp[0]+".png"
	else:
		continue
#	print src," ",dst
	cmd='cp '+src+' '+dst
#	print cmd
	os.system(cmd)
f.close()
