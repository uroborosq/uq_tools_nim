import os, strformat
# Package

version = "0.1.0"
author = "UroborosQ"
description = "uq tools in nim"
license = "MIT"
srcDir = "src"

let bins = @["uq_ram", "uq_cpufreq", "uq_cpuload", "uq_gpuload", "uq_net", "uq_temperature", "uq_waybar", "uq_dmenu_fzf"]
bin = bins
binDir = "bin"


# Dependencies

requires "nim >= 2.2.6"

task installl, "Install to system":
    for binary in bins:
        let nimbleDir = getEnv("NIMBLE_DIR", getHomeDir() / ".nimble")

        exec &"nim c -d:release --out:{nimbleDir}/bin/uq-{binary} src/{binary}.nim"

task uninstalll, "kek":
    let nimbleDir = getEnv("NIMBLE_DIR", getHomeDir() / ".nimble")
    exec &"rm {nimbleDir}/bin/uq-*"
