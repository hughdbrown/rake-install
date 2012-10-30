namespace :dev do
  desc "Install dev tools"
  task :tools do
    tools = %w{libxml2-dev swig uuid-dev ack-grep meld alien tree xclip pidgin multitail }
    install_pkg(tools)
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
