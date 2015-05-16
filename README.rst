.. _latest release: https://github.com/sganis/pyportable/releases/download/v2.7.10rc1/pyportable-2.7.10.zip
.. _Microsoft Visual C++ Compiler for Python 2.7: http://aka.ms/vcpython27
.. _runtime libraries for Intel C++ and Fortran: https://software.intel.com/en-us/articles/redistributable-libraries-for-intel-c-and-visual-fortran-composer-xe-2013-sp1-for-windows
.. _Intel® Math Kernel Library: http://software.intel.com/en-us/articles/intel-mkl/
.. _PyPi: https://pypi.python.org
.. _UCI: http://www.lfd.uci.edu/~gohlke/pythonlibs
.. _portable python: http://portablepython.com

Pyportable
==========

Pyportable is a portable Python programming environment (http://python.org) that runs from a local folder or a USB device, without the normal installation process common in Windows, and no admin priveledges needed.

User guide
----------

If you just want to use a portable version of Python, download the `latest release`_, unzip it in a folder, and run the terminal.bat launcher script. Pip will be available in the command line.

Developer guide
---------------

I got the inspiration from the excellent work at `portable python`_. The motivations to fork the original project were the need to have an updated portable version of python 2.7 in Windows, 64-bit packages, maximize the use of pip, and also make the build script simpler. I tried to simplify the original project as much as possible. There is only one short script. However, it is less tested, too. Only 64-bit Windows 7/8/8.1, and Windows Server 2008/2008R2/2012/2012R2. I also only tested in machines with some version of Visual Studio installed, and I guess this might satisfy some dependencies, so a thoghrough testing in fresh Windows installations is needed. 

The steps of creating a portable python are as follows: 

- Download and extract python.
- Set the new PATH environment variable so you python is the new executable just donwloaded.
- Download pip and install it. This became quite simple with the git-pip.py script. Setuptools will be installed too. The only problem is that pip will not be portable, the executable is saved in the Scripts directory and it has the full path of the python interpreter hard-coded. To make pip portable, we need to change that path. See below.
- Download numpy wheel. I am using the latest build from UCI_. I decided to use this precompiled package because it requires some extra libraries such as atlas, lapack, blas, as well as `Intel® Math Kernel Library`_ and the `runtime libraries for Intel C++ and Fortran`_, and didn't want to setup such building environment. In addition, these packages will install almost all dependencies needed for many other packages.
- Use pip to install the rest of packages.

Packages with C extensions will require compilation if a pre-build wheel is not available, such as Cython and Pycrypt. Pip will build it if you have a compiler. The trick is to install `Microsoft Visual C++ Compiler for Python 2.7`_. It might work with any Visual Studio (I have version 2012), but you need to do some configuration so pip can find the compiler. Make sure it works for 64-bits typing in the command line:

.. code:: bash

	c:\> cd c:\wherever\the\msvc\compiler\is\located>
	c:\wherever\the\msvc\compiler\is\located> vcvarsall.bat amd64
	Setting environment for using Microsoft Visual Studio 2008 x64 tools.

In my machine, I only needed to do this:

.. code:: bash

	c:\pyportable> SET VS90COMNTOOLS=%VS110COMNTOOLS%

But sometimes take longer to setup the compiler. The important thing is that the script `vcvarsall.bat` must be available in your path, usually located somewhere in `C:\\Program Files (x86)\\Microsoft Visual Studio 11.0\\VC` or something similar. That script will be called from pip to set some variables such as new PATH, LIB, LIBPATH, INCLUDE..., all this needed for the MSVC compiler. 

If you do not have a compiler, then the other option is to find a wheel with a pre-build release, such as those at UCI_. You can use pip directly with an url:

.. code:: bash

	c:\pyportable> set UCI=http://www.lfd.uci.edu/~gohlke/pythonlibs/r7to5k3j
	c:\pyportable> pip install %UCI%/pandas-0.16.1-cp27-none-win_amd64.whl

In this example, numpy must be installed before to satisfy dependencies.

The build.bat script will do everything, ending up with a portable version of python. It downloads packages from internet if needed, executes the steps from above, and creates a self-extracting executable. Run the script from a windows terminal:

.. code:: bash
	
	c:\pyportable> build.bat


Making pip portable
-------------------

I followed the steps at http://www.clemens-sielaff.com/create-a-portable-python-with-pip-on-windows/


