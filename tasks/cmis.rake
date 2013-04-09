namespace :cmis do
  #desc "Install CMIS workbench binary"
  task :bin => [:maven, :openjvm] do
    url = "http://www.eng.lsu.edu/mirrors/apache/chemistry/opencmis/0.8.0/chemistry-opencmis-workbench-0.8.0-full.zip"
    install_tar(url, version)
  end
end

task :cmis => ["cmis:bin"]
