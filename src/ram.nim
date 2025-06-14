import strutils
import std/strformat

func getBytes(line: string): uint = return parseUint(line.splitWhitespace()[1]) * 1024

func toGigaBytes(bytes: uint): float = return float(bytes) / 1024 / 1024 / 1024

when isMainModule:
  let lines = readFile("/proc/meminfo").splitLines()
  let usedRam = toGigaBytes(getBytes(lines[0])) - toGigaBytes(getBytes(lines[2]))
  let usedSwap = toGigaBytes(getBytes(lines[14])) - toGigaBytes(getBytes(lines[15]))
  echo fmt"{usedRam:.1f} GiB {usedSwap:.1f} GiB"

