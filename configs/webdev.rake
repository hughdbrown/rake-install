desc "Install web developer machine"
task :Webdev => ["universe", "webserver", "webdev:xvfb", "closure"]

