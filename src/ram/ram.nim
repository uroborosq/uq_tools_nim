when isMainModule:
  let content = readFile("/proc/meminfo")
  echo content

