import std/[os, strutils, sequtils, strformat]
type Unit = enum `b/s`, `Kib/s`, `Mib/s`, `Gib/s`

func format(value: float, counter = 0): string = (if value > 1024: format(value/1024, counter+1) else: &"{value:.1f} {Unit(counter)}")

proc getCounter(ifaces: seq[string]): tuple[received, sent: float] =
    var counter: tuple[received, sent: float]
    for line in toSeq(lines("/proc/net/dev"))[2..^1]:
        let words = line.splitWhitespace()

        if ifaces.anyIt(words[0].contains(it)):
            counter.received += words[1].parseFloat() 
            counter.sent += words[9].parseFloat()

    counter

let ifaces = commandLineParams()
let first = getCounter(ifaces)
sleep(1000)
let second = getCounter(ifaces)
echo format(second.received - first.received)," ", format(second.sent - first.sent)

