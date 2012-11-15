namespace :vagrant do
    LUCID = "http://files.vagrantup.com/lucid32.box"

    task :vagrant do
        gems = %w{ vagrant }
        install_gems(gems)
        sh("vagrant box add base #{LUCID}")
    end
end


