namespace :sanescan do
    desc "Install sane library for scanners"
    task :sanescan do
        version = "sane-backends_1.0.23"
        url = "https://launchpad.net/ubuntu/+archive/primary/+files/#{version}.orig.tar.gz"
        install_tar(url, "sane-backends-1.0.23")
    end
end

task :sanescan => [
    "sanescan:sanescan"
]
