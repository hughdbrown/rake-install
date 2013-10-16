namespace :ipython do
  IPYTHON_VERSION = "0.13.2-1"

  desc "Install ipython binary"
  task :ipython do
    deps = %w{ python-matplotlib python-scipy python-pandas python-sympy python-nose }
    install_pkg(deps)
    pkg = %w{ ipython=#{IPYTHON_VERSION} ipython-notebook=#{IPYTHON_VERSION} }
    install_pkg(pkg)
    pkg = %w{ ipython3=#{IPYTHON_VERSION} ipython3-notebook=#{IPYTHON_VERSION} }
    install_pkg(pkg)
  end
end

desc "Install all ipython"
task :ipython => [
    "ipython:ipython"
]
