namespace :node do
  task :all => [:bin]

  task :optipng do
    install_pkg(["optipng"])
  end
  
  task :libjpeg_turbo do
    install_deb(url, deb)
  end

  desc "Install node binary"
  task :bin => [:optipng, :libjpeg_turbo] do
    version = "node-v0.8.8"
    url = "http://nodejs.org/dist/v0.8.8/#{version}.tar.gz"
    install_tar(url, version)
  end
end
