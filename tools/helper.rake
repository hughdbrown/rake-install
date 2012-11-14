#-----------------------------------------------------
# Helper methods
#-----------------------------------------------------
def highlight(message, length=nil)
  stars = '*' * ((length or message.length) + 4)
  return ["", stars, "* #{message} *", stars, "", ""].join("\n")
end

def colorize(message, color=:red)
  colors = { :red => "31", :green => "32" }
  return "\e[#{colors[color]}m#{message}\e[0m"
end

def lowlight(message)
  to_print = "FAILURE: #{message}"
  raw_length = to_print.length

  to_print = colorize(to_print, :red) if $stdout.isatty

  return highlight(to_print, raw_length)
end

def notice(message)
  $stderr.puts highlight(message)
end

def check_env_var(variables)
  missing = variables.find_all { |v| ENV[v] == nil }
  raise "The following variables are missing and are needed to run this script: #{missing.join(', ')}." unless missing.empty?
end
