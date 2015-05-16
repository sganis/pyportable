# make pip portable
# param: full path of pyportable folder
import sys
import os

assert len(sys.argv)>1
pyportable = sys.argv[1]
pattern = '#!%s\\python.exe' % pyportable
pip_dir = '%s\\Scripts' % pyportable

for exe in os.listdir(pip_dir):
	if exe.endswith('.exe'):
		exe = os.path.join(pip_dir, exe)
		print('patching %s...' % exe)
		r = open(exe,"rb")
		s = r.read()
		r.close()
		s = s.replace(pattern,b'#!python.exe')
		w = open(exe, 'wb')
		w.write(s)
		w.close()
		
	
