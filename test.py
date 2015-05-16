# run some tests
#
# author: 	sganis
# date: 	05/16/2015

import unittest

class TestVersions(unittest.TestCase):
	def test_python(self):
		import platform
		self.assertEqual(platform.python_version(), "2.7.10rc1")

	def test_numpy(self):
		import numpy
		self.assertEqual(numpy.version.version, "1.9.2")


if __name__ == '__main__':
	unittest.main()

