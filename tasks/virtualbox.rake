namespace :virtualbox do
    #desc "Install virtualbox"
    task :virtualbox => ["dev:essential"] do
        pkgs = %w{ virtualbox-4.2 }
        install_pkg(pkgs)
    end
end

#desc "Install virtualbox"
task :virtualbox => ["virtualbox:virtualbox"]
