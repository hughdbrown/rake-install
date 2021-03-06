namespace :docs do
  LATEX_TAR = "install-tl-unx.tar.gz"

  desc "Install pandocs (package for all text formatting)"
  task :pandoc do
    pkgs = %w{ haskell-platform }
    install_pkg(pkgs)
    pkgs = %w{ pandoc }
    install_pkg(pkgs)
  end

  desc "Install latex"
  task :latex do
    FileUtils.cd(TMP_DIR) do
      sh("wget http://mirror.ctan.org/systems/texlive/tlnet/#{LATEX_TAR}")
      sh("tar xvzf #{LATEX_TAR}")
      tar_directory = Dir["/tmp/install-tl-2*"][0]
      FileUtils.cd(tar_directory) do
        sh("sudo ./install-tl")
      end
    end
  end
end

desc "Install all doc packagesS"
task :docs => [
    "docs:latex",
    "docs:pandoc",
]
