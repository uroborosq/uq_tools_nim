import os

const hwmon_path = "/sys/class/hwmon"

proc getSensors*(): void =
  for kind, path in walkDir(hwmon_path):
    if kind == pcFile or kind == pcLinkToFile:
      continue
  
    for kind, path in walkDir(path):
      echo kind, path
