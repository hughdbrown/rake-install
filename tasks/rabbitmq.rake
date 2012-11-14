namespace :rabbitmq do
  task :erlang do
    pkgs = %w{ erlang erlang-os-mon erlang-nox }
    install_pkg(pkgs)
  end

  # This also requires amqplib
  # pip install amqplib
  # Not sure whether to install globally or waht
  #desc "Install rabbitmq library"
  task :rabbitmq => [:erlang] do
    deb = "rabbitmq-server_2.8.7-1_all.deb"
    url = "http://www.rabbitmq.com/releases/rabbitmq-server/v2.8.7/#{deb}"

    install_deb(url, deb)
  end
end

#desc "Install rabbitmq"
task :rabbitmq => ["rabbitmq:rabbitmq"]
