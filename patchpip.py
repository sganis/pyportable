# make pip portable
#
# author: 	sganis
# date: 	05/16/2015
#
# param: full path of pyportable folder

import sys
import os

assert len(sys.argv)>1
pyportable = sys.argv[1]
pattern = '#!%s\\python.exe' % pyportable
pattern = pattern.lower()
pip_dir = '%s\\Scripts' % pyportable

for exe in os.listdir(pip_dir):
	if exe.endswith('.exe'):
		exe = os.path.join(pip_dir, exe)
		print('patching %s...' % exe)
		r = open(exe,"rb")
		s = r.read()
		r.close()
		s = s.replace(bytes(pattern),b'#!python.exe')
		w = open(exe, 'wb')
		w.write(s)
		w.close()
		
	
