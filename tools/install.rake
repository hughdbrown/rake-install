#-----------------------------------------------------
# Installation methods
#-----------------------------------------------------

TARCMD = {
    "tar.gz" => "xvfz",
    "tar.bz2" => "xvfj"
}

def install_pkg(apps)
  notice("Installing #{apps.join(' ')}")
  sh("sudo apt-get -y install #{apps.join(' ')}")
end

def remove_pkg(apps)
  notice("Removing #{apps.join(' ')}")
  sh("sudo apt-get -y remove #{apps.join(' ')}")
end

def install_ppa(ppa)
  sh("sudo add-apt-repository \"#{ppa}\" && sudo apt-get update")
  notice("Installed ppa #{ppa}")
end

def install_gems(gems)
  all_gems = "#{gems.sort.join(' ')}"
  sh("sudo gem install #{all_gems}")
  notice("Installed #{all_gems}")
end

def upgrade_gems(gems)
  all_gems = "#{gems.sort.join(' ')}"
  sh("sudo gem install -u #{all_gems}")
  notice("Upgraded #{all_gems}")
end

def _download_tar(url, tarfile, tarcmd="xvfz")
  notice("Downloading tarfile #{tarfile}")
  sh("wget #{url} -O #{tarfile}") unless File.exists?(tarfile)
  
  notice("Untarring tarfile #{tarfile}")
  sh("tar #{tarcmd} #{tarfile}") if File.exists?(tarfile)
end

def download_tar(url, version, target, options={})
  # test is a proc to call to test whether to perform the download
  test = options[:test]
  
  if (not test) or test.call
    ext = options[:ext] || "tar.gz"
    dir = options[:dir] || TMP_DIR
    block = options[:block]

    tarfile = "#{version}.#{ext}"
    tarcmd = TARCMD[ext]
    pwd = FileUtils.pwd()
  
    FileUtils.cd(dir) do
      begin
        _download_tar(url, tarfile, tarcmd)
        block.call if block
      ensure
        FileUtils.mv(target, pwd, :verbose => true) if File.exists?(target)
        FileUtils.rm(tarfile, :verbose => true) if File.exists?(tarfile)
      end
    end
  end
end

def install_tar(url, version, options={})
  # test is a proc to call to test whether to perform the download
  test = options[:test]
  
  if (not test) or test.call
    ext = options[:ext] || "tar.gz"
    dir = options[:dir] || TMP_DIR
    block = options[:block]
    
    tarfile = "#{version}.#{ext}"
    tarcmd = TARCMD[ext]
    notice("Installing tarfile #{tarfile}")
    FileUtils.cd(dir) do
      begin
        _download_tar(url, tarfile, tarcmd)
    
        FileUtils.cd(version) do
          sh("./configure") if File.exists?("configure")
          sh("make && sudo make install") unless Dir.glob("[Mm]akefile").empty?
          block.call if block
        end
      ensure
        FileUtils.rm(tarfile, :verbose => true)
      end
    end
  end
end

def install_deb(url, debfile, dir=TMP_DIR)
  notice("Installing debfile #{debfile}")
  begin
    FileUtils.cd(dir) do
      sh("wget #{url} -O #{debfile} && sudo dpkg -i #{debfile}")
    end
  ensure
    FileUtils.rm(debfile) if File.exists?(debfile)
  end
end

def pip_install_pkg(pkg)
  notice("pip-installing #{pkg.join(' ')}")
  sh("sudo pip install #{pkg.join(' ')}")
end

def command_exists(cmd)
  return system("which #{cmd}")
end
