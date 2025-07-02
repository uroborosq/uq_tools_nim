import strutils
import std/strformat

func bytes(line: string): uint = line.splitWhitespace()[1].parseUint() * 1024

func toGB(bytes: uint): float = float(bytes) / 1024 / 1024 / 1024

when isMainModule:
  let lines = readFile("/proc/meminfo").splitLines()
  let usedRam = lines[0].bytes().toGB() - lines[2].bytes().toGB()
  let usedSwap = lines[14].bytes().toGB() - lines[15].bytes().toGB()
  echo fmt"{usedRam:.1f} GiB {usedSwap:.1f} GiB"

