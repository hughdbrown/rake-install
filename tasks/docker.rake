namespace :docker do
    desc "Install docker"
    task :prereq do
        sh('sudo sh -c "curl https://get.docker.io/gpg | apt-key add -"')

        # Add the Docker repository to your apt sources list.
        sh('sudo sh -c "echo deb http://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"')
        
        # Update your sources and install
        sh('sudo apt-get update')
        install_pkg(['lxc-docker'])
    end
end

task :docker => [
    "docker:prereq"
]
