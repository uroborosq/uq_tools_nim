import tables
import common/sensors

type PlatformType = enum topDesktop, topLaptop, thinkpad

proc temperature(platformType: PlatformType): void =
  

when isMainModule:
  let monitors = getSensors()
