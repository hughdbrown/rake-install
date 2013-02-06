require 'open3'

def capture_output(cmd)
  stdin, stdout, stderr = Open3.popen3(cmd)
  return {:stdout => stdout, :stderr => stderr}
end

def capture_stderr(cmd)
  return capture_output(cmd)[:stderr].readlines
end

def capture_stdout(cmd)
  return capture_output(cmd)[:stdout].readlines
end

def command_exists(cmd)
  return ENV["PATH"]
    .split(":")
    .map {|p| File.join(p, cmd)}
    .keep_if {|fp| File.exists?(fp)}
    .first
end
