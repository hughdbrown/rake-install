namespace :virtualenv do
    desc "Install basic tools"
    task :virtualenv do
        notice("Installign virtualenv")
        
        pkg = %w{ python-setuptools }
        install_pkg(pkg)
        sh("sudo easy_install pip")

        pip_pkg = %w{ virtualenv virtualenvwrapper }
        pip_install_pkg(pip_pkg)

        env_hooks = "#ENV['HOME']/.virtualenvs/env_hooks"
        FileUtils.mkdir_p(env_hooks) unless File.exists?(env_hooks)
    end
end

desc "All virtualenv tasks"
task :virtualenv => ["virtualenv:virtualenv"]
