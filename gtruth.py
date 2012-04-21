# coding=UTF-8
import pygtk
pygtk.require('2.0')
import gtk
import codecs
import os
class Train:
	def close_application(self, widget, event, data=None):
		l = len(self.file)
		tim = l - self.count
		for i in xrange(tim):
			x = self.count
			self.fout.write(self.file[x])
			self.count = self.count + 1
		self.fin.close()
		self.fout.close()
		os.system('mv output.report.tmp1 '+ self.source)
		gtk.main_quit()
		return False

	    # is invoked when the button is clicked.  It just prints a message.
	def button_clicked(self, widget, data=None):
#		print "button %s clicked" % data
		x = self.count
		self.count = self.count + 1
		if self.count > self.numIm:
			self.file.close()
	                gtk.main_quit() 
		else:
			w = self.text.get_text()
			if w != '':
#				print repr(self.file[x])
				chop = self.file[x].split('\n')
				st = chop[0] + ' ' + w
				self.fout.write(st+'\n')
			else:
				self.fout.write(self.file[x])
			self.label.set_text(self.file[self.count]) # turn off label temporarily
#			self.label.show()
			self.image.set_from_file(self.dirprefix+str(self.count+1)+'.png')
#	                self.image.show()
			self.text.set_text('')
			self.window.set_title(str(self.count+1)+'.png')
#			self.text.show()
#	        self.text.grab_focus()

	def setfocus(self,widget,event):
		key = event.keyval
		if key == gtk.keysyms.Left or key == gtk.keysyms.Return:
#                        print 'Left'
			self.button.grab_focus()
#		else if key == gtk.keysyms.Up:
				

	def __init__(self):
		# create the main self.window, and attach delete_event signal to terminating
		# the application
#		self.count = 4024
#		self.count = 1700
		self.dirprefix='/home/pradeep/Desktop/project/dataset/orderrnbin/'
		self.dirprefix='/home/pradeep/Desktop/project/dataset/tam/test16_prop_bin/'
		self.dirprefix2='/home/pradeep/Desktop/project/dataset/'
#		self.dirprefix='/home/pradeep/Desktop/project/dataset/Numberedbin/'

		self.count = 0
#		self.source = self.dirprefix2+'output_test16'
		self.source = self.dirprefix2+'map_16_4201'
		self.fin = codecs.open(self.source,encoding='utf-8', mode='r')
		self.fout = codecs.open('output.report.tmp1',encoding='utf-8', mode='w+')
		self.file = list(self.fin)
	        if self.count > 0:
                        for i in xrange(self.count):
                                self.fout.write(self.file[i])
		img = os.listdir(self.dirprefix)
		self.numIm = len(img)
		del img
		self.window = gtk.Window(gtk.WINDOW_TOPLEVEL)
		self.window.set_title(str(self.count+1)+'.png')
		self.window.connect("delete_event", self.close_application)
		self.window.set_border_width(10)
		self.window.set_position(gtk.WIN_POS_CENTER)

		# a horizontal box to hold the buttons
		self.hbox = gtk.HBox()
		x = self.file[self.count]
                self.label = gtk.Label(x)
		self.hbox.pack_start(self.label)
		self.label.show()
		self.window.add(self.hbox)
		self.image = gtk.Image()
#		self.image.set_from_file(self.dirprefix+"blob"+str(self.count+1)+".png")
		self.image.set_from_file(self.dirprefix+str(self.count+1)+".png")
		self.image.show()
		# a button to contain the image widget
		self.button = gtk.Button()
		self.button.add(self.image)
		self.button.connect("clicked", self.button_clicked, "2")
		self.button.show()
		self.hbox.pack_start(self.button)
		self.text = gtk.Entry()
		self.text.set_width_chars(4)
		self.hbox.pack_end(self.text)
#		self.text.grab_focus()
		self.text.show()
		self.hbox.show()
 		self.window.connect("key-press-event", self.setfocus)
		self.window.set_default_size(450,40)
                self.window.show()	

def main():
    gtk.main()
    return 0

if __name__ == "__main__":
    Train()
    main()

