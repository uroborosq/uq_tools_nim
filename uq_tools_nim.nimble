import os, strformat
# Package

version = "0.1.0"
author = "UroborosQ"
description = "uq tools in nim"
license = "MIT"
srcDir = "src"

bin = @["uq_ram", "uq_cpufreq", "uq_cpuload", "uq_gpuload", "uq_net", "uq_temperature", "uq_waybar", "uq_dmenu_fzf", "uq_current_song"]
binDir = "bin"


# Dependencies

requires "nim >= 2.2.6"
