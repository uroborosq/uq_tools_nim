import tables
import os, strformat
import sensors/sensors
import nvidia/nvidia

func format(f: float): string = &"{f/1000:.1f}°C"

let args = commandLineParams()
if args.len() != 1:
    echo "no profile specified"
    quit(1)

let parsedSensors = parse("/sys/class/hwmon")

case args[0]:
of "topdesktop":
    echo parsedSensors["k10temp"]["Tctl"].format(), " ",
        parsedSensors["nvme"]["Sensor 2"].format(), " ",
        gpuTemp(), "°C"
of "kvadra":
    echo parsedSensors["coretemp"]["Package id 0"].format(), " ", parsedSensors["nvme"]["Composite"].format()


