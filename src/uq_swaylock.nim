import std/[os, osproc, json, strutils, sequtils, strformat]
import vips/vips

func filename(o: string): string = &"/tmp/swaylock-{o}.jpg"

if vips_init("nim-vips") != 0:
    quit("vips_init() failed")

var outputs = startProcess("swaymsg", args = ["-r", "-t", "get_outputs"], options = {poUsePath}).readLines()[0].join().parseJson().getElems().filterIt(it["type"].getStr() == "output" and it["active"].getBool() == true).mapIt(it["name"].getStr()) 
outputs.apply(proc(o: string) = discard startProcess("grim", args = ["-t", "jpeg", "-q", "80", "-o", o, &"/tmp/swaylock-{o}.jpg"], options = {poUsePath}).waitForExit())
outputs.apply(proc(o: string) = blur(&"/tmp/swaylock-{o}.jpg", &"/tmp/swaylock-{o}.jpg", 8))

var args: seq[string] = @[]

outputs = outputs.mapIt(&"{it}:{filename(it)}")

for output in outputs:
    args.add("-i")
    args.add(output)

args.add(commandLineParams())


startProcess("swaylock", args = args, options = {poUsePath}).close()


vips_shutdown()

