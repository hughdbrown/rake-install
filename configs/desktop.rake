desc "Install desktop machine"
task :Desktop => [
    "universe",
    "media",
    "docs",
    #"ubuntu:cinnamon",
    #"sanescan"
]
