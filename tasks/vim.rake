namespace :vim do
  COLORSCHEMES = {
    :clouds_midnight => "http://darcsden.com/alex/dotfiles/raw/.vim/colors/clouds-midnight.vim"
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

  #desc "Install vim"
  task :vim do
    # Use vim-gnome because the usual vim on Ubuntu does not have clipboard support
    pkg = %w{ vim-gnome }
    install_pkg(pkg)
  end

  #desc "Install vim-spf13"
  task :vim_spf13 => ["vim", "system:curl"] do
    FileUtils.cd(HOME) do
      unless File.exists?(".spf13-vim-3")
        sh("curl http://j.mp/spf13-vim3 -L -o - | sh") unless File.exists?(".vimrc-bundles")

        # Install clouds-midnight COLORSCHEMES
        install_colorscheme(:clouds_midnight)

        notice("Installed vim spf13")
      end
    end
  end
end

task :vim => ["vim:vim", "vim:vim_spf13"]

