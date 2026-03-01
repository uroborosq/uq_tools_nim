import osproc, strutils, strformat

func statusToIcon(status: string): string = (if status == "Playing": "" else: "")
        

proc main() =
    let titleProcess = startProcess("playerctl", args = ["metadata", "xesam:title"], options = {poUsePath})

    defer: titleProcess.close()

    if titleProcess.waitForExit() != 0:
        echo ""
        return

    let title = titleProcess.readLines()[0][0].strip()
    let artist = startProcess("playerctl", args = ["metadata", "xesam:artist"], options = {poUsePath}).readLines()[0][0].strip()
    let status = startProcess("playerctl", args = ["status"], options = {poUsePath}).readLines()[0][0].strip()

    echo &"{statusToIcon(status)} {artist} | {title}"


when isMainModule:
    main()
