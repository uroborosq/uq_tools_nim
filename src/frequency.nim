import strutils
import std/[asyncdispatch, asyncfile, sequtils, strformat, cpuinfo]

proc getFreq(coreNumber: int): Future[uint] {.async.} = 
  var f = openAsync(fmt"/sys/devices/system/cpu/cpu{coreNumber}/cpufreq/scaling_cur_freq", fmRead)
  let freq = await f.readAll()
  f.close()
  return freq.strip().parseUint() div 1000

when isMainModule:
  let freqs = waitFor toSeq(0..<countProcessors()).map(getFreq).all()
  echo fmt"{freqs.max()}MHz"

