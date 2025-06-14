# Package

version       = "0.1.0"
author        = "UroborosQ"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
bin           = @["ram", "cpu_usage"]
binDir        = "bin"

# Dependencies

requires "nim >= 2.2.0"
requires "cligen"
