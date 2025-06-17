import weave
import std/cpuinfo

proc spin(i: int): void = 
  var a = 0 
  while true:
    a = a + 1

when isMainModule:
  init(Weave)

  parallelFor i in 0..<countProcessors():
    spin(i)

  syncRoot(Weave)
  exit(Weave)
