namespace :ipython do
  #desc "Install ipython binary"
  task :ipython do
    deps = %w{ python-matplotlib python-scipy python-pandas python-sympy python-nose }
    install_pkg(deps)
    pkg = %w{ ipython-notebook }
    install_pkg(pkg)
  end
end

task :ipython => [
    "ipython:ipython"
]
