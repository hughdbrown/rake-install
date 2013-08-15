namespace :docs do
  LATEX_TAR = "install-tl-unx.tar.gz"

  task :pandoc do
    pkgs = %w{ haskell-platform }
    install_pkg(pkgs)
    pkgs = %w{ pandoc }
    install_pkg(pkgs)
  end

  task :latex do
    FileUtils.cd(TMP_DIR) do
      sh("wget http://mirror.ctan.org/systems/texlive/tlnet/#{LATEX_TAR}")
      sh("tar xvzf #{LATEX_TAR}")
      FileUtils.cd("install-tl-20130815") do
        sh("sudo ./install-tl")
      end
    end
  end
end

task :docs => [
    "docs:latex",
    "docs:pandoc",
]
