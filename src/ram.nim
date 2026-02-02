import std/[strutils, strformat]
func format(total, actual: string): string = &"{((total.splitWhitespace()[1].parseFloat() - actual.splitWhitespace()[1].parseFloat()) / 1024 / 1024):.1f}GiB" 
let lines = readFile("/proc/meminfo").splitLines()
echo format(lines[0], lines[2]), " ", format(lines[15], lines[14])

