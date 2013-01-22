namespace :mercurial do
  #desc "Install mercurial binary"
  task :bin do
    tools = %w{hg}
    install_pkg(tools)
  end
end

task :mercurial => ["mercurial:bin"]
