namespace :vagrant do
    LUCID = "http://files.vagrantup.com/lucid32.box"

    task :vagrant do
        pkgs = %w{ vagrant }
        install_pkg(pkgs)
        sh("vagrant box add base #{LUCID}")
    end
end


