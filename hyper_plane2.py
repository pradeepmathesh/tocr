# coding=UTF-8
import os
import math
import numpy as np
import Image
import codecs
import time
#modeldirprefix='/home/pradeep/Desktop/project/dataset/Numberedbin/';
modeldirprefix='/home/pradeep/Desktop/project/dataset/Number2/';
#datadirprefix='/home/pradeep/Desktop/project/dataset/orderrnbin/';
#datadirprefix='/home/pradeep/Desktop/project/dataset/tam/test16_renum/';
datadirprefix='/home/pradeep/class/poems/leisure/project/dataset/tam/test16_prop_bin/';
#datadirprefix='/home/pradeep/pradeep.tmp/Documents/tesseract-3.00/test1/';

start = time.time()

dict = {1:'ள', 2:'கி', 3:'ட', 4:'ளி', 5:'ப', 6:'க', 7:'ற்', 8:'ை', 9:'ல்', 11:'த', 12:'ே',14:'கு', 15:'ெ', 16:'இ', 17:'ர', 18:'று', 20:'ம்', 21:'எ', 22:'ன்', 25:'க்', 26:'ஃ', 27:'அ', 33:'ஸ்', 34:'ா', 36:'ழு', 41:'ரு', 42:'வி', 43:'த்', 45:'ஞ', 47:'ரி', 49:'லு', 56:'வ', 57:'ட்', 58:'ன', 64:'டு', 66:'றி', 67:'ல', 72:'ப்', 73:'ச', 74:'ம', 76:'ஸ', 77:'ர்', 84:'ஒ', 89:'ய', 91:'யி', 92:'ந', 96:'ஆ', 100:'ள்', 108:'ற', 111:'னு', 114:'வு', 125:'பி', 143:'உ', 164:'பு', 168:'ச்', 178:'ழி', 205:'தி', 209:'து', 211:'கூ', 213:'மு', 225:'நி', 229:'ந்', 234:'ஜி', 251:'ய்', 263:'ங்', 288:'ண்', 305:'டி', 352:'ளு', 388:'சி', 438:'யூ', 498:'ஏ', 520:'ழ', 572:'மி', 607:'ஸி', 609:'நீ', 610:'ழ்', 676:'ஜ',883:'வ்', 936:'ஷி', 939:'சூ', 973:'நூ', 1215:'யு', 1256:'மூ', 1287:'ஈ', 1369:'சு', 1486:'னி', 1712:'டீ', 1735:'ஹ', 1892:'ஐ', 2047:'மீ', 2100:'ஷ', 2140:'வீ', 2216:'ஜ்', 2407:'லி', 3333:'ஞ்', 3377:'தீ', 3381:'கீ', 3668:'ண'}
im_dim = 64
M = im_dim*im_dim;  # size of image vector, i.e., number of pixels
d = 1000
#dir = './orderrn'


charidx = os.listdir(modeldirprefix)
testidx = os.listdir(datadirprefix)
#x = charidx[0]
#w = x.split('.')
#print dict[int(w[0])]
numIm = len(charidx)
numfiles = len(testidx)
DATA = np.mat(np.zeros((M,numIm),float))

j = 0

#print 'Creating Training Data matrix\n'
for i in charidx:
	t = '%s%s' % (modeldirprefix,i);
	im = Image.open( t ).convert('L')
	im = im.resize((im_dim,im_dim))
	m,n = im.size	
	x = np.mat(im)
	DATA[:,j] = x.reshape(M,1)  #assign vector to a particular of matrix
	j = j + 1

#print 'Generating Random matrix\n' 
R = np.random.rand(d,M);# using random matrix

phi = R*DATA

con = u''


fout = codecs.open('/home/pradeep/Desktop/project/dataset/output_test16', encoding='utf-8', mode='w+')
#fout = open('output.tmp','w+')


for i in xrange(numfiles):
#for i in xrange(4199):
#for i in charidx:
#	t = '%s/blob%s.png' % (datadirprefix,str(i+1));
	t = '%s%s.png' % (datadirprefix,str(i+1));
#	t = '%s/%s' % (dir,i);
#if os.path.exists(t):
	im1 = Image.open(t).convert('L') #if not in grayscale
#	im1 = Image.open(t)
	im1 = im1.resize((im_dim,im_dim))
	T_DATA = np.mat(im1)
	T_DATA = T_DATA.reshape(M,1).copy()

	#print 'Creating Test matrix\n'
	test = R*T_DATA

	test_n=test / math.sqrt(test.H*test)

	norm2_phi = np.mat(np.zeros((len(phi),numIm),float))

	#print 'Classifying...\n'

	for j in xrange(numIm):
		norm2 = math.sqrt(phi[:,j].H*phi[:,j])
		norm2_phi[:,j]= phi[:,j]/norm2

	x = norm2_phi.H*test_n

	index = charidx[x.argmax(0)]

#	print "Classified Image:",index

	split = index.split('.')

#	print '%s: %s' % (index,dict[int(split[0])])
#		print '%s: %s' % (t,dict[int(split[0])])
	con =   dict[int(split[0])].decode('utf-8')

	fout.write(con+'\n')

fout.close()

end = time.time()
os.system('gedit /home/pradeep/Desktop/project/dataset/output_test16 &')

print 'It took %s seconds' % (end-start)
