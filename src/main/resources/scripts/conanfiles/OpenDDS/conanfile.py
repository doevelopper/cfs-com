import os, shutil
from conans import ConanFile, tools, MSBuild, AutoToolsBuildEnvironment
from conans.errors import ConanException

from contextlib import contextmanager

#Helper function for appending to environment variables
@contextmanager
def append_to_env_variable(var, value, separator, prepend=False):
    old_value = os.getenv(var, None)
    try:
        new_value = [old_value, value] if old_value else [value, ]
        if prepend:
            new_value = reversed(new_value)
        os.environ[var] = separator.join(new_value)
        yield
    finally:
        if old_value is not None:
            os.environ[var] = old_value
        else:
            del os.environ[var]




class OpenDDSConan(ConanFile):
    name = "OpenDDS"
    version = "3.13"
    #license = "<Put the package license here>"
    #url = "<Package recipe repository url here, for issues about the package>"
    description = "At this stage, a test of getting a Conan package of OpenDDS"
    settings = "os", "compiler", "build_type", "arch"
    generators = "visual_studio", "gcc"

    source_subfolder = 'source_subfolder'

    short_paths = True

    def build_requirements(self):
        if self.settings.os == "Windows":
            self.build_requires('strawberryperl/5.26.0@conan/stable')

    def configure(self):
        self.requires('ACE_TAO_MPC/6.5.2@lasagne/stable')

        if self.settings.os not in ["Windows", "Linux", "Macos"]:
            raise ConanException("Recipe for settings.os='{}' not implemented.".format(self.settings.os))
        if self.settings.os == "Windows" and self.settings.compiler != "Visual Studio":
            raise ConanException("Recipe for settings.os='{}' and compiler '{}' not implemented.".format(self.settings.os, self.settings.compiler))


    def source(self):
#        version = self.version.replace('.', '_')

        if os.path.isdir('DDS') == False:
#            https://github.com/objectcomputing/OpenDDS/archive/DDS-3.13.tar.gz
            source_url = "https://github.com/objectcomputing/OpenDDS/archive/DDS"
            tools.get("{0}-{1}.tar.gz".format(source_url, self.version))
            os.rename('OpenDDS-DDS-3.13', self.source_subfolder)

            names = os.listdir('source_subfolder')
            for name in names:
                srcname = os.path.join('source_subfolder', name)
                shutil.move(srcname, '.')

    def build(self):
        working_dir = self.build_folder
        
        #print(working_dir)

        # Set env variables and run build
        with tools.environment_append({'DDS_ROOT': os.path.join(working_dir, '.')}):
            if self.settings.os == "Windows":
                self.build_windows(working_dir)
            elif self.settings.os == "Linux":
                self.build_linux(working_dir)
            else:
                self.build_macos(working_dir)

    def _exec_mpc(self, working_dir, mpc_type, mwc=None):
        mwc = mwc or os.path.join(working_dir, 'DDS_no_tests.mwc')
        command = ['perl', os.path.join(os.environ['ACE_ROOT'], 'bin', 'mwc.pl'), '--type', mpc_type, mwc, ]
        self.run(' '.join(command))

    def build_windows(self, working_dir):
        assert self.settings.os == "Windows"
        assert self.settings.compiler == "Visual Studio"

        # Generate project using MPC
        compiler_version = int(str(self.settings.compiler.version))
        if compiler_version <= 14:
            self._exec_mpc(working_dir, mpc_type='vc{}'.format(compiler_version))
        else:
            compiler_type = {15: '2017', }[compiler_version]
            self._exec_mpc(working_dir, mpc_type='vs{}'.format(compiler_type))

        # Compile
        # Do we want the .sln files to have the names represent the vs version being used? 
        with append_to_env_variable("PATH", os.path.join(working_dir, 'lib'), ';', prepend=True):
            with append_to_env_variable("PATH", os.path.join(working_dir, 'bin'), ';', prepend=True):
                sln = os.path.join(working_dir, 'DDS_no_tests.sln')
                # for build_type='Debug' build release first
                if self.settings.build_type == 'Debug':
                    MSBuild(self).build(sln, build_type='Release', upgrade_project=False)
                MSBuild(self).build(sln, upgrade_project=False)

    def build_linux(self, working_dir):
        assert self.settings.os == "Linux"

    def build_macos(self, working_dir):
        assert self.settings.os == "Macos"
#---------------------------------------------------------------------------------------------

    def package(self):
        self.copy("*.*", dst="", src="", keep_path="True", excludes=("*.iobj", "*.ipdb", "*.tlog", "*.obj", "*.lastbuildstate"))

    def package_info(self):
        working_dir = self.package_folder
#        self.cpp_info.libs = ["OpenDDS"]
        self.env_info.DDS_ROOT = working_dir
        self.env_info.PATH.append(os.path.join(working_dir, 'bin'))
        self.env_info.PATH.append(os.path.join(working_dir, 'lib'))
