# Package

version       = "0.1.0"
author        = "UroborosQ"
description   = "uq tools in nim"
license       = "MIT"
srcDir        = "src"
bin           = @["ram", "cpufreq", "cpuload", "gpuload", "net"]
binDir        = "bin"


# Dependencies

requires "nim >= 2.2.6"
