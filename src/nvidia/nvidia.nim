import std/[osproc, strutils]
proc gpuLoad*(): float = startProcess("nvidia-smi",
    args = ["--query-gpu", "utilization.gpu", "--format",
        "csv,noheader,nounits"],
    options = {poUsePath}).readLines()[0][0]
  .strip().parseFloat()

proc gpuTemp*(): float = startProcess("nvidia-smi",
    args = ["--query-gpu", "temperature.gpu", "--format",
        "csv,noheader,nounits"],
    options = {poUsePath}).readLines()[0][0]
  .strip().parseFloat()
