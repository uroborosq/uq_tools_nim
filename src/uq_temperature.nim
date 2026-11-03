import tables
import strformat
import sensors/sensors
import std/nativesockets


func format(f: float): string = &"{f/1000:.1f}°C"

let parsedSensors = parse("/sys/class/hwmon")

try:
  case getHostname():
  of "TopDesktop":
    echo parsedSensors["k10temp"]["Tctl"].format(), " ",
        parsedSensors["amdgpu"]["edge"].format(), " ",
        parsedSensors["nvme"]["Composite"].format()
  of "NB-3814":
    echo parsedSensors["coretemp"]["Package id 0"].format(), " ", parsedSensors["nvme"]["Composite"].format()
except:
  echo "Sensors unavailable"

