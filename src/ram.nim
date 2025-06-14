import strutils
import std/strformat

func getBytes(line: string): uint = return parseUint(line.splitWhitespace()[1]) * 1024

func toGigaBytes(bytes: uint): float = return float(bytes) / 1024 / 1024 / 1024

when isMainModule:
  let lines = readFile("/proc/meminfo").splitLines()
  let usedRam = lines[0].getBytes.toGigaBytes - lines[2].getBytes.toGigaBytes
  let usedSwap = lines[14].getBytes.toGigaBytes - lines[15].getBytes.toGigaBytes
  echo fmt"{usedRam:.1f} GiB {usedSwap:.1f} GiB"

