# Conan

These are the steps to add and buld new 3rd-party libraries using conan. You may install conan from https://conan.io/downloads.

## Configure conan.conf

For Windows, modify the `[settings_defaults]` section of ~/.conan/conan.conf` as follows. These options will by default make 64-bit Release builds using Visual Studio 2015 (vc14):

  [settings_defaults]
  arch=x86_64
  build_type=Release
  os=Windows
  compiler=Visual Studio
  compiler.version=14
  compiler.runtime=MD

## Add nginx as a remote

  conan remote add nginx http://nginx.leap.corp:9300

## Remove conan.io as a remote

By default, the ~/.conan/registry.txt file will contain an instance of conan.io. Remove it using:

  conan remote remove conan.io

## Using nginx conan server

Instead of using the remote conan.io server, we are storing the conan artifacts locally on the nginx server. To gain write permissions to the server, we need to specify the username and password to use with the remote:

  conan user -r nginx -p leapmotion leapmotion

## Stating with an existing package

The various conan forumlas can be found in this directory. 

  git clone https://github.com/lasote/conan-bzip2.git
  cd conan-bzip2
  rm -fr .git
  grep lasote *
 
Change instances of `lasote` to `leapmotion` based on the results of the previous `grep` command. Although we don't use `appveyor.yml`, you may update that by also changing the `PYTHON_VERSION`, `PYTHON_ARCH`, `CONAN_REFERENCE`, `CONAN_USERNAME`, and `CONAN_CHANNEL` as needed. The important file to change is `conanfile.py`. While changing that file, also change any instances of `def config(self):` to `def config_options(self):`. Under the `def build(self):` section, add the following three lines:

  	if self.settings.compiler == "Visual Studio" and self.settings.build_type == "Debug":
  	    if not str(self.settings.compiler.runtime).endswith("d"):
  		self.settings.compiler.runtime = str(self.settings.compiler.runtime) + "d"

That will allow Debug builds under Windows to use the `/MDd` option when building, instead of `/MD`.

You may also have to change build depdencies. For instance, the `conanfile.py` may reference an older version of the library than what is being used. Update it appropriately.

## Building and installing

Here is an example of building and copying the resulting binaries (Release and Debug) to the nginx server. We are using bzip2 as an example, but you must replace `bzip2` and `1.0.6` with the appropriate package name and version:

  conan export leapmotion/stable -k
  conan upload bzip2/1.0.6@leapmotion/stable

If you run into problems with your build because of a mistake in your `conanfile.py` file, modify the file then re-run the above two commands before continuing with these commands:

  conan install bzip2/1.0.6@leapmotion/stable --build bzip2
  conan install bzip2/1.0.6@leapmotion/stable --build bzip2 -s build_type=Debug
  conan upload bzip2/1.0.6@leapmotion/stable --all

Notice that we build the library twice. Once with Release (the default) and once with Debug. We configured conan to build 64-bit versions by default. To build 32-bit versions, include `-s x86` on each of those two lines.
