namespace :docs do
  LATEX_TAR = "install-tl-unx.tar.gz"

  task :pandoc do
    pkgs = %w{ haskell-platform }
    install_pkgs(pkgs)
    pkgs = %w{ pandoc }
    install_pkgs(pkgs)
  end

  task :latex do
    FileUtils.cd(TMP_DIR) do
      sh("wget http://mirror.ctan.org/systems/texlive/tlnet/#{LATEX_TAR}")
      sh("tar xvzf #{LATEX_TAR}")
      FileUtils.cd("install-tl-20130407") do
        sh("sudo ./install-tl")
      end
    end
  end
end

task :docs => [
    "docs:latex",
    "docs:pandoc",
]

