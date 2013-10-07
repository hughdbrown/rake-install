def add_service(service_name, init_script)
    sh("sudo update-rc.d -f #{service_name} remove")
    sh("sudo cp -v #{init_script} /etc/init.d/.")
    sh("sudo chmod +x /etc/init.d/#{service_name} && sudo update-rc.d #{service_name} defaults")
end

