
when isMainModule:
  for i in items(10):
    readFile("/sys/devices/system/cpu/cpu%d/cpufreq/scaling_cur_freq")  
