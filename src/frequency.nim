import std/strformat
import std/cpuinfo
import strutils
import malebolgia

proc getFrequency(coreNumber: int): uint =
  return readFile(fmt"/sys/devices/system/cpu/cpu{coreNumber}/cpufreq/scaling_cur_freq").strip().parseUint() div 1000

when isMainModule:
  var m = createMaster()

  var freqs = newSeq[uint](countProcessors())

  m.awaitAll:
    for i in 0..<countProcessors():
      m.spawn getFrequency(i) -> freqs[i] 

  echo fmt"{freqs.max()}MHz"
