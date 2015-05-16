import unittest

class TestCoreSystem(unittest.TestCase):
	"""Test Python core and associated tools"""
	def test_python(self):
		import platform
		self.assertEqual(platform.python_version(), "2.7.10rc1")

	def test_setuptools(self):
		import setuptools
		# self.assertEqual(setuptools.__version__, "0.6c11")		

class TestModuleImports(unittest.TestCase):
	"""Simple set of tests for package imports in case of full installation"""
	def test_numpy(self):
		import numpy
		# self.assertEqual(numpy.version.version, "1.8.1")

	def test_scipy(self):
		import scipy
		# self.assertEqual(scipy.version.version, "0.15.1")

	# def test_pywin32(self):
	# 	import os
	# 	import distutils.sysconfig

	# 	pth = distutils.sysconfig.get_python_lib(plat_specific=1)
	# 	ver = open(os.path.join(pth, "pywin32.version.txt")).read().strip()
	# 	self.assertEqual(ver, "218")

	def test_matplotlib(self):
		import matplotlib
		# self.assertEqual(matplotlib.__version__, "1.3.1")

	def test_dateutil(self):
		import dateutil
		# self.assertEqual(dateutil.__version__, "2.2")

	def test_pyparsing(self):
		import pyparsing
		# self.assertEqual(pyparsing.__version__, "2.0.1")

	# def test_pyqt(self):
	# 	from PyQt4 import QtCore
	# 	# self.assertEqual(QtCore.qVersion(), "4.8.5")

	def test_ipython(self):
		import IPython
		# self.assertEqual(IPython.__version__, "1.2.1")

	def test_pandas(self):
		import pandas
		# self.assertEqual(pandas.__version__, "0.11.0")

if __name__ == '__main__':
	unittest.main()