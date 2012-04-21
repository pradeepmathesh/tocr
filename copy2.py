import os
dirprefix="/home/pradeep/Desktop/project/dataset/"
N=4201
f=open("/home/pradeep/Desktop/project/dataset/map_16_4201",'r')
lines = f.readlines()
tmp=""
dict = {}
dst=dirprefix+"Number3/"

for i in xrange(N):
	tmp=lines[i].split()
	if dict.has_key(tmp[1]) == False and tmp[1] != '*' and tmp[1] != '#':
		src="/home/pradeep/class/poems/leisure/project/dataset/tam/test16_prop/"+tmp[0]+".png" #note prop and not prop_bin !! :)
#		src="/home/pradeep/class/poems/leisure/project/dataset/tam/test16_prop_bin/"+tmp[1]+".png"
		w = "%s:'%s'," % (tmp[0],tmp[1])
#		w = "%d:'%s'" % tmp[0],':\'',tmp[1],'\',',
		print w,
		dict[tmp[1]] = '0'
	else:
		continue	
#	print src," ",dst
	cmd='cp '+src+' '+dst+tmp[1]+"_"+tmp[0]+".png"
#	cmd='cp '+src+' '+dst
#	print cmd
	os.system(cmd)
f.close()
