# coding=UTF-8
import os
import math
import numpy as np
import Image
import codecs
import time
#modeldirprefix='/home/pradeep/Desktop/project/dataset/Numberedbin/';
modeldirprefix='/home/pradeep/Desktop/project/dataset/Numbered2/';
#datadirprefix='/home/pradeep/Desktop/project/dataset/orderrnbin/';
#datadirprefix='/home/pradeep/Desktop/project/dataset/tam/test16_renum/';
datadirprefix='/home/pradeep/class/poems/leisure/project/dataset/tam/test16_prop_bin';
start = time.time()

dict = {1:'அ',2:'ஆ',3:'இ',4:'ஈ',5:'உ',6:'',7:'எ',8:'ஏ',9:'ஜ',10:'ஒ',11:'ஔ',12:'',13:'க',14:'க்',15:'',16:'கி',17:'கீ',18:'கு',19:'',20:'',21:'',22:'',23:'',24:'',25:'',26:'',27:'ங் ',28:'',29:'',30:'',31:'',32:'',33:'',34:'',35:'',36:'',37:'',38:'',39:'ச ',40:'ச் ',41:'',42:'சி ',43:'',44:'சு',45:'சூ',46:'',47:'',48:'',49:'',50:'',51:'',52:'',53:'ஞ் ',54:'ஞ ',55:'தி',56:'',57:'',58:'',59:'',60:'',61:'',62:'',63:'',64:'',65:'',66:'ட',67:'ட்',68:'',69:'டி',70:'',71:'டு',72:'',73:'',74:'',75:'',76:'',77:'',78:'',79:'ண்',80:'ண',81:'',82:'ணி',83:'',84:'ணு',85:'',86:'',87:'',88:'',89:'',90:'',91:'',92:'த',93:'த்',94:'',95:'தி',96:'',97:'து',98:'',99:'',100:'',101:'',102:'',103:'',104:'',105:'',106:'ந் ',107:'',108:'நி ',109:'',110:'',111:'நூ ',112:'',113:'',114:'ரூ ',115:'',116:'',117:'ப',118:'ப்',119:'',120:'பி',121:'',122:'பு',123:'பூ',124:'',125:'',126:'',127:'',128:'',129:'',130:'ம',131:'ம்',132:'',133:'மி',134:'மீ',135:'மு',136:'மூ',137:'',138:'',139:'',140:'',141:'',142:'',143:'ய',144:'',145:'',146:'யி',147:'',148:'யு',149:'யூ',150:'',151:'',152:'',153:'',154:'',155:'',156:'ர',157:'ர்',158:'',159:'ரி',160:'ரீ',161:'ரு',162:'',163:'',164:'',165:'',166:'',167:'',168:'',169:'ல',170:'ல்',171:'',172:'லி',173:'',174:'லு',175:'',176:'',177:'',178:'',179:'',180:'',181:'',182:'வ',183:'',184:'',185:'வி',186:'வீ',187:'வு',188:'',189:'',190:'',191:'',192:'',193:'',194:'',195:'ழ',196:'',197:'',198:'ழி',199:'',200:'ழு',201:'',202:'',203:'',204:'',205:'',206:'',207:'',208:'ள',209:'ள்',210:'',211:'ளி',212:'ளீ',213:'ளு',214:'',215:'',216:'',217:'',218:'',219:'',220:'',221:'ற',222:'ற்',223:'',224:'றி',225:'',226:'று',227:'',228:'',229:'',230:'',231:'',232:'',233:'',234:'ன',235:'ன்',236:'',237:'னி',238:'',239:'னு',240:'னூ',241:'',242:'',243:'',244:'',245:'',246:'',247:'',248:'ஸ்',249:'ஷ',250:'ஸி',251:'',252: '\xe0\xaf\x87',253:'\xe0\xaf\x88',254: '\xe0\xaf\x86',255: '\xe0\xae\xbe',256:'ஜி',257:'ஹ',258:'',259:'ஷ் ',260:'ஹு',261:'.',262:'1',263:'a',264:'(',265:')',266:',',267:'4',268:'9',269:'o',270:'0',271:'e',272:':',273:'2',274:'i',275:'5',276:'u',277:'m',278:'-',279:'',280:'',281:'',282:'',283:'',284:'',285:'',286:'',287:'',288:'',289:'',290:'',291:'',292:'',293:'',294:'',295:'',296:'',297:'',298:'',299:'',300:''}
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
