namespace :java do
    task :java do
        pkgs = %w{ openjdk-7-jdk }
        install_pkg(pkgs)
        pkgs = %w{ maven }
        install_pkg(pkgs)
    end
end


