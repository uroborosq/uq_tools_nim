import std/strformat
import strutils
import weave

proc getFrequency(coreNumber: int): uint =
  return readFile(fmt"/sys/devices/system/cpu/cpu{coreNumber}/cpufreq/scaling_cur_freq").parseUint()


when isMainModule:
  init(Weave)
  for i in 0..10:
    spawn getFrequency(i)

  exit(Weave)
