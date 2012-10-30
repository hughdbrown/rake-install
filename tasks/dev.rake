namespace :dev do
  PARALLEL_VERSION = "parallel-20120622"
  PARALLEL_URL ="http://ftp.gnu.org/gnu/parallel/#{PARALLEL_VERSION}.tar.bz2"

  task :libbz2 do
    pkg = %w{libbz2-dev}
    install_pkg(pkg)
  end

  task :parallel => ["dev:libbz2"] do
    install_tar(PARALLEL_URL, PARALLEL_VERSION, ext="tar.bz2")
  end

  desc "Install dev tools"
  task :tools do
    tools = %w{libxml2-dev swig uuid-dev ack-grep meld alien tree xclip pidgin multitail }
    install_pkg(tools)
    Rake::Task["dev:parallel"].invoke()
  end

  desc "Install essential tools"
  task :essential do
    tools = %w{build-essential autogen autoconf automake ubuntu-dev-tools dkms libtool }
    install_pkg(tools)
  end

  desc "Install language tools"
  task :language do
    tools = %w{fortran-compiler gawk python-dev}
    install_pkg(tools)
  end

  desc "Install web tools"
  task :web do
    tools = %w{curl pngcrush}
    install_pkg(tools)
  end

  desc "Install zip tools"
  task :zip do
    tools = %w{p7zip}
    install_pkg(tools)
  end
end

desc "Install all dev tools"
task :dev => ["dev:essential", "dev:language", "dev:web", "dev:zip", "dev:tools"]
