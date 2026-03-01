import std/[os, tempfiles, osproc, strformat]


proc process() = 
    let input = stdin.readAll()

    let (_, writerPath) = createTempFile("uq_dmenu_fzf_writer", ".tmp")
    let (readerFile, readerPath) = createTempFile("uq_dmenu_fzf_reader", ".tmp")

    defer: removeFile(writerPath)
    defer: removeFile(readerPath)

    writerPath.writeFile(input)

    discard startProcess("kitty", args= ["--class", "terminal-floating", "/usr/bin/bash", "-c", &"fzf < {writerPath} > {readerPath}"], options = {poUsePath}).waitForExit()

    let output = readerFile.readAll()
    echo output

process()
