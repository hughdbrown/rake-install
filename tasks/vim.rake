namespace :vim do
  #DOTFILESDIR = File.expand_path("~/Dropbox/src/dotfiles")
  #VIMDIR = File.expand_path("~/.vim")
  #VIMRC = File.expand_path("~/.vimrc")
  #
  #VIM_BACKUP_DIR = File.join(VIMDIR, "backup")
  #VIM_TMP_DIR = File.join(VIMDIR, "tmp")
  #VIM_BUNDLES_DIR = File.join(VIMDIR, "bundles")
  #VIM_DIRECTORIES = [VIM_BACKUP_DIR, VIM_TMP_DIR, VIM_BUNDLES_DIR]
  #
  #VIM_PLUGIN = File.join(VIMDIR, "plugin")
  #VIM_COLORS = File.join(VIMDIR, "colors")
  #VIM_FILES = [VIM_PLUGIN, VIM_COLORS]
  #
  #file VIMRC do
  #  FileUtils.ln_sf("#{DOTFILESDIR}/vimrc", VIMRC, :verbose => true) unless File.exists?(VIMRC)
  #end

  def install_colorscheme(cs=nil)
    if cs
      colorschemes = {
        "clouds-midnight" => "http://darcsden.com/alex/dotfiles/raw/.vim/colors/clouds-midnight.vim"
      }
      colorscheme = colorschemes[cs]
      if colorscheme
        FileUtils.cd("~/.vim/bundle/vim-colorschemes/colors") do
          sh("wget #{colorscheme}")
        end
      end
      sh("echo colorscheme #{cs} >> ~/.vimrc")
    end
  end

  desc "Install vim"
  task :vim do
    #pkgs = %w{vim}
    #install_pkg(pkgs)
    FileUtils.cd("~") do
      sh("curl http://j.mp/spf13-vim3 -L -o - | sh")
      
      # Install clouds-mignight colorscheme
      install_colorscheme('cloud-midnight')

      notice("Installed vim spf13")
    end
  end

  #def link_to_dotfiles(dir)
  #  src = File.join(DOTFILESDIR, "vim", dir)
  #  dst = File.join(VIMDIR, dir)
  #  FileUtils.ln_sf(src, dst, :verbose => true) unless File.exists?(dst)
  #end
  #
  #directory VIM_BACKUP_DIR
  #directory VIM_TMP_DIR
  #directory VIM_BUNDLES_DIR
  #
  #file VIM_PLUGIN do
  #  link_to_dotfiles("plugin")
  #end
  #file VIM_COLORS do
  #  link_to_dotfiles("colors")
  #end
  #
  #desc "Install vim tools"
  #task :vimtools => [*VIM_DIRECTORIES] + [*VIM_FILES] do
  #    # %w{backup tmp bundles plugin colors}.collect {|dir| File.join(VIMDIR, dir)}
  #end
end

task :vim => ["vim:vim"] # , "vim:vimtools"]

 
