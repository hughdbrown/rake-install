namespace :ipython do
  #desc "Install ipython binary"
  task :ipython do
    deps = %w{ python-matplotlib python-scipy python-pandas python-sympy python-nose }
    install_pkgs(deps)
    pkg = %w{ ipython-notebook }
    install_pkgs(pkg)
  end
end

task :ipython => [
    "ipython:ipython"
]
