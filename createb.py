import Image
import string
import subprocess
import os

IMAGES = 1

def roll(image, delta):
    "Roll an image sideways"

    xsize, ysize = image.size

    delta = delta % xsize
    if delta == 0: return image

    part1 = image.crop((0, 0, delta, ysize))
    part2 = image.crop((delta, 0, xsize, ysize))
    image.paste(part2, (0, 0, xsize-delta, ysize))
    image.paste(part1, (xsize-delta, 0, xsize, ysize))

    return image


def createblobs():
#	count = 0
	for i in xrange(IMAGES):
#		filename = "April/"+str(i+1)+".tif" #Malayalam
		filename = "testimages/test"+str(i+1)+".tif" #Tamil
		im1 = Image.open(filename)
		#print im1.mode
		x,y = im1.size
		#print y
		#im4 = roll(im1,750)
		#im4.show()
		os.system('tesseract '+filename+' testimages  batch.nochop makebox')
                os.system('cat testimages.box | cut -d " " -f2-5 &> tuple')
		f = open("tuple",'r')                                                               
		boxList = f.readlines()                                                                     
		f.close()     
		#boxer = (600,958,613,974)
#		x,y = im1.size
		#boxer = (600,280,x,y)
		#for box in boxList:
		#	region = box.rstrip()
		#im2  = Image.open("pil.tif")
		count = 1
		for box in boxList:
			tmp = box.rstrip()
			parts = string.split(tmp)
		#	print parts[0],parts[1],parts[2],parts[3]
			x0 = int(parts[0]) 
			y0 = y - int(parts[3]) 
			x1 = int(parts[2])
			y1 = y - int(parts[1])
		#	print x0,y0,x1,y1
			boxer = (x0,y0,x1,y1)
			region = im1.crop(boxer)
			size = (x1-x0,y1-y0)
		#region = region.transpose(Image.ROTATE_180)
			im2 = Image.new("RGB",size)
			im2.paste(region,(0,0)) #source --> destination(0,0)
			filename = "test"+str(i+1)+"/"+str(count)+".png"
#			filename = "test"+str(i+1)+"/blob"+str(count)+".png"
#			filename = "blobs/blob"+str(count)+".png"
			im2.save(filename, "PNG")
			count = count + 1
def makedirs():
	for i in xrange(IMAGES):
                os.system('rm -rf '+' test'+str(i+1))
	for i in xrange(IMAGES):
		os.system('mkdir -p '+'test'+str(i+1))
def cleanup():
	os.system('rm -f blobs/*')	
#im1.show()
#filename = "transpose.png"
#im2.save(filename, "PNG")
#cmd = ['eog', '%s'%(filename)]
#subprocess.call(cmd)

#im1.rotate(45).show()
makedirs()
cleanup()
print 'creating blobs'
createblobs()
