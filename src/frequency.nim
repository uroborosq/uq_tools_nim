import std/[strformat,cpuinfo]
import strutils
import sequtils

when isMainModule:
  let max = (0..<countProcessors()).toSeq().map(proc (i: int): uint = readFile(fmt"/sys/devices/system/cpu/cpu{i}/cpufreq/scaling_cur_freq").strip().parseUint() div 1000).max()
  echo fmt"{max}MHz"

