namespace :php do
  task :php_cli do
    pkg = %w{ php5-cli }
    install_pkg(pkg)
  end
end

task :php => ["php:php_cli"]
