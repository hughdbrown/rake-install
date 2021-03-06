namespace :virtualenv do
  VIRTUALENV_HOME = File.join(HOME, ".virtualenvs")
  BIN = File.join(HOME, "bin")
  HUB = File.join(BIN, "hub")

  task :setuptools do
    pkg = %w{ python-setuptools }
    install_pkg(pkg)
  end

  task :pip => ["virtualenv:setuptools", "system:curl"] do
    sh("curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py | sudo python")
  end

  desc "Install hub (a github fronend for git)"
  task :hub do
    install_gems(["hub"])
  end

  desc "Install virtualenv tools"
  task :virtualenv => ["virtualenv:pip", "virtualenv:hub"] do
    notice("Installing virtualenv")

    pip_pkg = %w{ virtualenvwrapper }
    pip_install_pkg(pip_pkg)

    env_hooks = File.join(VIRTUALENV_HOME, "env_hooks")
    FileUtils.mkdir_p(env_hooks) unless File.exists?(env_hooks)
  end
end

#desc "All virtualenv tasks"
task :virtualenv => ["virtualenv:virtualenv"]
