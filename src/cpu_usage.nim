proc readUsage(): string = 
  let content = readLines("/proc/stat", 1)
  echo content
  return content[0]

when isMainModule:
  let c = readUsage()
  echo c
