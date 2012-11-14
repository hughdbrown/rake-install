namespace :rabbitmq do
  #desc "Install rabbitmq library"
  task :rabbitmq do
    deb = "rabbitmq-server_2.8.7-1_all.deb"
    url = "http://www.rabbitmq.com/releases/rabbitmq-server/v2.8.7/#{deb}"

    install_deb(url, deb)
  end
end

#desc "Install redis"
task :rabbitmq => ["rabbitmq:rabbitmq"]
