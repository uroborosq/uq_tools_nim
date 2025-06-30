# Package

version       = "0.1.0"
author        = "UroborosQ"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
bin           = @["ram", "cpu_usage", "frequency", "cpu_stress_test", "temperature"]
binDir        = "bin"

# Dependencies

requires "nim >= 2.2.0"
requires "cligen"
requires "weave"
