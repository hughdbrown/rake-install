desc "Install desktop machine"
task :Desktop => [
    "universe",
    "media",
    "ubuntu:cinnamon",
    "sanescan"
]

