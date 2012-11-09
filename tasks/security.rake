namespace :security do

  #desc "Install crypt apps"
  task :crypt do
    tools = %w{mcrypt bcrypt}
    install_pkg(tools)
  end

  #desc "Install security libraries"
  task :libraries do
    tools = %w{sasl2-bin libsasl2-dev libldap2-dev ldap-utils libssl-dev}
    install_pkg(tools)
  end
end
task :security => ["security:crypt", "security:libraries"]
