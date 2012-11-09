namespace :virtualbox do
    desc "Install virtualbox"
    task :virtualbox => ["dev:essential"] do
        pkgs = %w{ virtualbox }
        install_pkg(pkgs)
    end
end

desc "Install virtualbox"
task :virtualbox => ["virtualbox:virtualbox"]

