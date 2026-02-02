import std/[osproc]
echo startProcess("nvidia-smi", args = ["--query-gpu", "utilization.gpu", "--format", "csv,noheader,nounits"], options={poUsePath}).readLines()[0][0], "%"
