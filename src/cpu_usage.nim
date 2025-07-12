import strutils
import std/os
import std/sequtils
import std/strformat
import cligen

type repeatType = enum once, repeat

proc readUsage(): string = readLines("/proc/stat", 1)[0]

func parseStatLine(line: string): seq[uint] = line.splitWhitespace[1..^1].map(parseUint)

func calculate(stats: seq[uint]): tuple[work: uint, total: uint] =
  let work = stats[0..<3].foldl(a+b)
  return (work: work, total: stats[3..^1].foldl(a+b)+work)

proc cpu_usage(repeat: repeatType): void =
  while true:
    let initial = readUsage().parseStatLine().calculate()
    sleep(1000)
    let new = readUsage().parseStatLine().calculate()
    echo fmt"{float(new.work - initial.work) / float(new.total - initial.total) * 100:.1f}%"

    if repeat == once: break
     
when isMainModule:
  dispatch(cpu_usage)
