namespace :rabbitmq do
  RABBIT_VERSION = "3.1.5"

  task :erlang do
    pkgs = %w{ erlang erlang-os-mon erlang-nox }
    install_pkg(pkgs)
  end

  task :librabbitmq do
    pkgs = %w{ librabbitmq-dev }
    install_pkg(pkgs)
  end

  # This also requires amqplib
  # pip install amqplib
  # Not sure whether to install globally or waht
  desc "Install rabbitmq library"
  task :rabbitmq => [:erlang, :librabbitmq] do
    deb = "rabbitmq-server_#{RABBIT_VERSION}-1_all.deb"
    url = "http://www.rabbitmq.com/releases/rabbitmq-server/v#{RABBIT_VERSION}/#{deb}"

    install_deb(url, deb)
  end
end

desc "Install rabbitmq"
task :rabbitmq => [
    "rabbitmq:rabbitmq"
]
