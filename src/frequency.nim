import std/strformat
import std/cpuinfo
import strutils
import weave

proc getFrequency(coreNumber: int): uint =
  return readFile(fmt"/sys/devices/system/cpu/cpu{coreNumber}/cpufreq/scaling_cur_freq").strip().parseUint() div 1000

when isMainModule:
  init(Weave)
  var freqs = newSeq[uint](countProcessors())

  parallelFor i in 0..<countProcessors():
    echo getFrequency(i) 

  echo fmt"{freqs.max()}MHz"

  exit(Weave)
