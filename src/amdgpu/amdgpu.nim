import std/[os, strutils]

proc gpuLoad*(): float =
  for card in walkDirs("/sys/class/drm/card*/device"):
    if fileExists(card / "vendor") and readFile(card / "vendor").strip() == "0x1002":
      return readFile(card / "gpu_busy_percent").strip().parseFloat()
  raise newException(IOError, "amdgpu not found")
