import strutils, sequtils, os
func calculate(stat: seq[int]): tuple[total, iowait: int] = (total: stat.foldl(a+b), iowait: stat[4])
func parse(s: string): seq[int] = s.splitWhitespace()[1..^1].mapIt(it.parseInt())
let first = open("/proc/stat").readLine().parse().calculate()
sleep(1000)
let second = open("/proc/stat").readLine().parse().calculate()
echo ((second.iowait-first.iowait) / (second.total - first.total) * 100).formatFloat(ffDecimal, 1), "%"

