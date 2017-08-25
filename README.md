This repository provides some instructions on building various external libraries for Windows. Refer to the README files in the sub-directories.

#### Requirements:
##### Windows:
  Git For Windows SDK - https://github.com/git-for-windows/build-extra/releases
  Python 3.x - https://www.python.org/downloads/release/python-362/
  ActivePerl - http://www.activestate.com/activeperl/downloads
  Ruby - https://www.ruby-lang.org/en/downloads/
  DirectX SDK (for SDL2) - https://www.microsoft.com/en-us/download/details.aspx?id=6812
  Mozilla Build (for NSS) - https://ftp.mozilla.org/pub/mozilla.org/mozilla/libraries/win32/MozillaBuildSetup-Latest.exe
  Visual Studio 2013/2015

  If you have problems installing the DirectX SDK, check online. It frequently has issues if you have the visual studio 2010 redistributable installed.

  Git For Windows SDK should be installed to C:/git-sdk-64 or vc-bash*.bat files will have to be modified

#### OSX & Linux:
  (Same purpose but different tools than in Windows)
  Install build tools: (brew|apt) install git automake libtool autoconf python3@3.6.1

#### Setup Instructions:
  1.Clone this repository
  2.Install the above requirements
  3.Run setup-all-libraries.sh
