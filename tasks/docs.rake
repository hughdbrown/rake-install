namespace :docs do
  LATEX_TAR = "install-tl-unx.tar.gz"

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
]

