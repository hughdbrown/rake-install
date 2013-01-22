namespace :closure do
    TMP_PLOVR_DIR =  File.join(TMP_DIR, "plovr")
    ANT_BUILD_FILE = File.join(TMP_PLOVR_DIR, "build.xml")

    file ANT_BUILD_FILE => ["mercurial:bin"] do
        FileUtils.cd(TMP_DIR) do
            sh("hg clone https://plovr.googlecode.com/hg/ plovr")
        end
    end

    #desc "Build plovr from scratch"
    task :plovr => [ANT_BUILD_FILE] do
        FileUtils.cd(TMP_PLOVR_DIR) do
            begin
                sh("ant jar")
            ensure
                File.rm_rf(TMP_PLOVR_DIR)
            end
        end
    end

    #desc "Build compiler.jar from scratch"
    task :compiler => [] do
        url = "http://closure-compiler.googlecode.com/files/compiler-latest.tar.gz"
        version = "compiler"
        target = "compiler.jar"
        download_tar(url, version, target)
    end
end

task :closure => ["closure:plovr", "closure:compiler"]
