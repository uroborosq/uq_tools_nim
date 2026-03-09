import std/[os, osproc, logging]

addHandler(newConsoleLogger())

let args = commandLineParams()

if args.len() != 1:
    echo "specify config path"
    quit(1)


for _ in 0..1000:
    info "starting waybar"
    discard startProcess("systemd-cat", args = ["-t", "waybar", "waybar", "--config", args[0]], options = {poUsePath}).waitForExit()

    info "restarting waybar"

    sleep(1000)

info "restart limit exceeded"

