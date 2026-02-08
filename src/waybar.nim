import std/[os, osproc, logging]

addHandler(newConsoleLogger())

let args = commandLineParams()

if args.len() != 1:
    echo "specify config path"
    quit(1)


for _ in 0..1000:
    info "starting waybar"
    let p = startProcess("waybar", args = ["--config", args[0]], options = {poUsePath}).waitForExit()
    if p != 0:
        error "waybar failed"
    else:
        info "waybar finished"
    sleep(1000)

info "restart limit exceeded"

