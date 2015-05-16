Portable Python
===============

Portable Python is a the python interpreter (http://python.org) that can run from a folder, any USB storage device, local or network location so you can enjoy a powerful and portable programming environment. 

This is a fork of the excellent work from https://github.com/pericazivkovic/portablepython. The motivations to fork the original project were the need to have an updated portable version of python 2.7 in Windows, 64-bit packages, maximize the use of pip, and also make the build script simpler. I tried to simplify the original project as much as possible. There is only one script, and shorter. The steps of creating a portable python are as follows: 

- Download and extract python.
- set the new PATH environment variable so you python is the new executable just donwloaded.
- Download pip and install it. This became quite simple with the git-pip.py script. Setuptools will be installed too.
- Download numpy and scipy, I am using the latest compilations from http://www.lfd.uci.edu/~gohlke/pythonlibs. I decided to use these precompiled packages because they require some extra libraries such as lapack, blas and others, and didn't want to setup such building environment. In addition, these packages will install almost all dependencies needed for any other package.
- Use pip to install the rest of packages.
- It is aslo possible to use pip to install packages that require compilation, such as cython. The trick is to install Visual Studio C++ (I have version 2012), and set this environment variable, so pip will find the right compiler:

.. code:: bash

	c:\portablepython> SET VS90COMNTOOLS=%VS110COMNTOOLS%

In my machine, VS110COMNTOOLS is pointing to `C:\\Program Files (x86)\\Microsoft Visual Studio 11.0\\Common7\\Tools`, but I guess any version of Visual Studio should work.


Usage
-----

The build.bat script will make a portable version of python. It downloads packages from internet, and creates a self-extracting executable. Run the script from a windows terminal:

.. code:: bash
	
	c:\portablepython> build.bat


Licensing
---------
Portable Python build scripts are licensed under MIT license, other third party tools and packages are licensed by their respecitive projects/owners.


