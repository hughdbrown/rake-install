namespace :llvm do
    LLVM_INSTALL_PATH = "/home/hbrown/llvm"
    LLVM_CONFIG_PATH = "#{LLVM_INSTALL_PATH}/bin/llvm-config"
    VERSION = "3.3"
    SRC = "llvm-#{VERSION}.src"
    TARFILE = "#{SRC}.tar.gz"

    task :llvm do
        install_pkg(["llvm-dev"])
        FileUtils.cd(TMP_DIR) do
            sh("wget http://llvm.org/releases/3.3/#{TARFILE}")
            sh("tar xvzf #{TARFILE}")
            FileUtils.cd(SRC) do
                sh("./configure --enable-optimized --prefix=#{LLVM_INSTALL_PATH}")
                sh("make && sudo make install")
            end
        end
    end

    desc "Install llvmpy"
    # task :llvmpy => [:llvm] do
    task :llvmpy do
        FileUtils.cd(TMP_DIR) do
            sh("rm -rf llvmpy/")
            sh("git clone git@github.com:llvmpy/llvmpy.git")
            FileUtils.cd("llvmpy") do
                sh("LLVM_CONFIG_PATH=#{LLVM_CONFIG_PATH} python setup.py install")
            end
            sh("rm -rf llvmpy/")
        end
        pip_install_pkg(["llvmmath"])
    end
end

task :llvm => [
    "llvm:llvmpy"
]
