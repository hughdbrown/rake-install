def configure_make(options=nil)
  opt_str = (options && options.join(" ")) || ""
  sh("./configure #{opt_str}") if File.exists?("configure")
  sh("make && sudo make install") unless Dir.glob("[Mm]akefile").empty?
end

