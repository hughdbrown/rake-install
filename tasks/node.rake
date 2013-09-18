namespace :node do

  task :optipng do
    install_pkg(["optipng"])
  end

  task :libjpeg_turbo do
    pkg = %w{ libjpeg62-dev }
    install_pkg(pkg)
  end

  desc "Install node binary"
  task :bin => [:optipng, :libjpeg_turbo] do
    version = "node-v0.8.8"
    url = "http://nodejs.org/dist/v0.8.8/#{version}.tar.gz"
    install_tar(url, version)
  end
end

task :node => ["node:bin"]
