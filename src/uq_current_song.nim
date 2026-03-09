import osproc, strutils, strformat

func statusToIcon(status: string): string = (if status == "Playing": "" else: "")
        
proc main(): string =
    let titleProcess = startProcess("playerctl", args = ["metadata", "xesam:title"], options = {poUsePath})
    defer: titleProcess.close()

    if titleProcess.waitForExit() != 0: return ""

    let artist = startProcess("playerctl", args = ["metadata", "xesam:artist"], options = {poUsePath}).readLines()[0][0].strip()
    let status = startProcess("playerctl", args = ["status"], options = {poUsePath}).readLines()[0][0].strip()

    return &"{statusToIcon(status)} {artist} | {titleProcess.readLines()[0][0].strip()}"

echo main()
