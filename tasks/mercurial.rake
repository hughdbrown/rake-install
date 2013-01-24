namespace :mercurial do
  #desc "Install mercurial binary"
  task :bin do
    tools = %w{mercurial}
    install_pkg(tools)
  end
end

task :mercurial => ["mercurial:bin"]
