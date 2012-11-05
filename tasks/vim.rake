namespace :vim do
  HOME = ENV['HOME']
  COLORSCHEMES = {
    "clouds-midnight" => "http://darcsden.com/alex/dotfiles/raw/.vim/colors/clouds-midnight.vim"
  }

  def install_colorscheme(cs=nil)
    if cs
      colorscheme = COLORSCHEMES[cs]
      if colorscheme
        FileUtils.cd(File.join(HOME, ".vim/bundle/vim-colorschemes/colors")) do
          sh("wget #{colorscheme}")
        end
        sh("echo colorscheme #{cs} >> ~/.vimrc")
      end
    end
  end

  desc "Install vim"
  task :vim do
    pkg = %w{ vim }
    install_pkg(pkg)
  end

  desc "Install vim"
  task :vim_spf13 => ["vim"] do
    FileUtils.cd(HOME) do
      sh("curl http://j.mp/spf13-vim3 -L -o - | sh") unless File.exists?(".vimrc-bundles")

      # Install clouds-mignight colorscheme
      install_colorscheme('clouds-midnight')

      notice("Installed vim spf13")
    end
  end
end

task :vim => ["vim:vim", "vim:vim_spf13"] # , "vim:vimtools"]

