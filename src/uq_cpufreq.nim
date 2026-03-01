import std/[cpuinfo, sequtils, strformat, strutils]
echo ((0..countProcessors()-1).mapIt(readFile(&"/sys/devices/system/cpu/cpu{it}/cpufreq/scaling_cur_freq").strip.parseInt).max()/1000).formatFloat(ffDecimal, 1), "MHz"
