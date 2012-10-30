namespace :vim do
  def install_colorscheme(cs=nil)
    if cs
      colorschemes = {
        "clouds-midnight" => "http://darcsden.com/alex/dotfiles/raw/.vim/colors/clouds-midnight.vim"
      }
      colorscheme = colorschemes[cs]
      if colorscheme
        FileUtils.cd("#{ENV['HOME']}/.vim/bundle/vim-colorschemes/colors") do
          sh("wget #{colorscheme}")
        end
      end
      sh("echo colorscheme #{cs} >> ~/.vimrc")
    end
  end

  desc "Install vim"
  task :vim do
    pkg = %w{ vim }
    install_pkg(pkg)
  end

  desc "Install vim"
  task :vim_spf13 => ["vim"] do
    #pkgs = %w{vim}
    #install_pkg(pkgs)
    FileUtils.cd("#{ENV['HOME']"}) do
      sh("curl http://j.mp/spf13-vim3 -L -o - | sh")

      # Install clouds-mignight colorscheme
      install_colorscheme('cloud-midnight')

      notice("Installed vim spf13")
    end
  end
end

task :vim => ["vim:vim", "vim:vim_spf13"] # , "vim:vimtools"]

 
