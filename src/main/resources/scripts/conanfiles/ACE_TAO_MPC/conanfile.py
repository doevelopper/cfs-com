import os, shutil
from conans import ConanFile, tools, MSBuild, AutoToolsBuildEnvironment
from conans.errors import ConanException

from contextlib import contextmanager


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


class AceTaoConan(ConanFile):
    name = "ACE_TAO_MPC"
    version = "6.5.2" #make this automatic
    license = ""
    url = "https://github.com/DOCGroup/ACE_TAO"
    description = "ACE, TAO and MPC all compiled, and running in the setup used for LASAGNE Development"
    settings = "os", "compiler", "build_type", "arch"

    generators = "visual_studio", "gcc"

    source_subfolder = 'source_subfolder'

    short_paths = True

    def build_requirements(self):
        if self.settings.os == "Windows":
            self.build_requires('strawberryperl/5.26.0@conan/stable')

    def configure(self):
        if self.settings.os not in ["Windows", "Linux", "Macos"]:
            raise ConanException("Recipe for settings.os='{}' not implemented.".format(self.settings.os))
        if self.settings.os == "Windows" and self.settings.compiler != "Visual Studio":
            raise ConanException("Recipe for settings.os='{}' and compiler '{}' not implemented.".format(self.settings.os, self.settings.compiler))

    def source(self):
        version = self.version.replace('.', '_')
        las_version = '1.5.1'

        if os.path.isdir('ace') == False:
            source_url = "https://github.com/DOCGroup/ACE_TAO/releases/download/ACE%2BTAO"
            tools.get("{0}-{1}/ACE+TAO-src.tar.gz".format(source_url, version))
            os.rename('ACE_Wrappers', self.source_subfolder)

            names = os.listdir('source_subfolder')
            for name in names:
                srcname = os.path.join('source_subfolder', name)
                shutil.move(srcname, '.')

        if os.path.isdir('LAS_Config_files') == False:
            source_url = "https://github.com/LASAGNE-Open-Systems/LASAGNE-Core/archive/v"
            tools.get("{0}{1}.tar.gz".format(source_url, las_version))
            os.replace('LASAGNE-Core-1.5.1', 'LAS_Config_files')
        
        las_names = os.listdir('LAS_Config_files')
        for name in las_names:
            if name != 'bin':
                srcname = os.path.join('LAS_Config_files', name)
                if os.path.isdir(srcname) == True:
                    shutil.rmtree(srcname)
                elif os.path.exists(srcname) == True:
                    os.remove(srcname) 


#This bit to be replaced by a LASAGNE-Core Package of some sort
#Pulling in the files from LASAGNE-Core that need to be copied to ACE_TAO before building ACE_TAO. 

    def build(self):
        working_dir = self.build_folder

        # Copy over config.h
        shutil.copy(os.path.join(working_dir, 'LAS_Config_files', 'bin', 'build', 'ace', 'config.h' ), os.path.join(working_dir, 'ace', 'config.h'))
        # Copy over default.features
        shutil.copy(os.path.join(working_dir, 'LAS_Config_files', 'bin', 'build', 'ace', 'default.features'), os.path.join(working_dir, 'bin', 'MakeProjectCreator', 'config', 'default.features'))

        # Edit the common.mpt file 
        os.rename(os.path.join(working_dir, 'MPC', 'templates', 'common.mpt'), os.path.join(working_dir, 'MPC', 'templates', 'common_orig.mpt')) 
        file_common_orig_mpt = open(os.path.join(working_dir, 'MPC', 'templates', 'common_orig.mpt'), "r", 10)
        file_common_mpt = open(str(os.path.join(working_dir, 'MPC', 'templates', 'common.mpt')), "w+", 10)
        
        for line in file_common_orig_mpt:
            file_common_mpt.write(line.replace('use_exe_modifier =', 'use_exe_modifier = 1'))

        file_common_orig_mpt.close()
        file_common_mpt.close()

        # Set env variables and run build
        with tools.environment_append({'MPC_ROOT': os.path.join(working_dir, 'MPC'),
                                       'ACE_ROOT': working_dir,
                                       'TAO_ROOT': os.path.join(working_dir, 'TAO')}):
            if self.settings.os == "Windows":
                self.build_windows(working_dir)
            elif self.settings.os == "Linux":
                self.build_linux(working_dir)
            else:
                self.build_macos(working_dir)

    def _exec_mpc(self, working_dir, mpc_type, mwc=None):
        mwc = mwc or os.path.join(working_dir, 'TAO', 'TAO_ACE.mwc')
        command = ['perl', os.path.join(working_dir, 'bin', 'mwc.pl'), '--type', mpc_type, mwc, ]
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
            sln = os.path.join(working_dir, 'TAO', 'TAO_ACE.sln')
            # for build_type='Debug' build release first
            if self.settings.build_type == 'Debug':
                MSBuild(self).build(sln, build_type='Release', upgrade_project=False)
            MSBuild(self).build(sln, upgrade_project=False)

    def build_linux(self, working_dir):
        assert self.settings.os == "Linux"
        platform_gnu = "platform_linux_clang.GNU" if self.settings.compiler == "clang" else "platform_linux.GNU"
        self._build_unix(working_dir, platform_gnu)

    def build_macos(self, working_dir):
        assert self.settings.os == "Macos"
        self._build_unix(working_dir, platform_gnu="platform_macosx.GNU")

    def _build_unix(self, working_dir, platform_gnu):
        conan_mwc = os.path.join(working_dir, 'conan.mwc')
        with open(conan_mwc, 'w') as f:
            f.write("workspace {\n")
            f.write("$(TAO_ROOT)/TAO_ACE.mwc\n")  # Condition to TAO
            # f.write("$(TAO_ROOT)/tests/Hello\n")
            # f.write("$(ACE_ROOT)/ace/ace.mwc\n")  # Condition to ACE
            # f.write("$(ACE_ROOT)/tests\n")  # Condition to ACETESTS
            f.write("}\n")

        with open(os.path.join(working_dir, 'ACE', 'include', 'makeinclude', 'platform_macros.GNU'), 'w') as f:
            # TODO: It is not working :/ f.write("INSTALL_PREFIX = {}\n".format(os.path.join(self.build_folder, 'install')))  # Will ease package creation
            f.write("inline=0\nipv6=1\n")
            f.write("c++11=1\n")
            f.write("ace_for_tao=1\n")
            f.write("include $(ACE_ROOT)/include/makeinclude/{}\n".format(platform_gnu))

        with open(os.path.join(working_dir, 'ACE', 'bin', 'MakeProjectCreator', 'config', 'default.features'), 'w') as f:
            f.write("ace_for_tao=1\n")

        self._exec_mpc(working_dir, mpc_type='gnuace', mwc=conan_mwc)
        with append_to_env_variable('LD_LIBRARY_PATH', os.path.join(working_dir, 'ACE', 'lib'), separator=':', prepend=True): 
            with tools.chdir(working_dir):
                env_build = AutoToolsBuildEnvironment(self)
                env_build.make()
                # Cannot make it to work with the "INSTALL_PREFIX" (see above)  self.run("make install")

    def package(self):
        self.copy("*.*", dst="", src="", keep_path="True", excludes=("*.iobj", "*.ipdb", "*.tlog", "*.obj", "*.lastbuildstate"))

    def package_info(self):
        working_dir = self.package_folder
        self.cpp_info.libs = tools.collect_libs(self)
        self.env_info.MPC_ROOT = str(os.path.join(working_dir, 'MPC'))
        self.env_info.ACE_ROOT = working_dir
        self.env_info.TAO_ROOT = str(os.path.join(working_dir, 'TAO'))
        self.env_info.PATH.append(os.path.join(working_dir, 'lib'))
        self.env_info.PATH.append(os.path.join(working_dir, 'bin'))