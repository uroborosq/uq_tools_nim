import tables
import cligen
import common/sensors
import std/times
import weave

type PlatformType = enum topDesktop, topLaptop, thinkpad

func toTemp(value: uint): string = $(float(value) / 1000) & "°C"

proc temperature(platform: PlatformType): void =
  let start = epochTime()
  let monitors = getSensors()
  case platform:
    of thinkpad:
      echo monitors["thinkpad"]["CPU"].toTemp(), " ", monitors["thinkpad"]["GPU"].toTemp()
    of topLaptop:
      echo "oops"
    of topDesktop:
      echo "oops"
  echo (epochTime() - start) * 1000, "ms"

when isMainModule:
  init(Weave)

  dispatch(temperature)

  exit(Weave)
