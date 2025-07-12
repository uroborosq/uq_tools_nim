import os
import tables
import strutils
import std/times
import weave

const hwmon_path = "/sys/class/hwmon"

type Sensor = object
  label: string
  value: uint


proc getSensors*(): Table[string, Table[string, uint]] =
  var monitors = initTable[string, Table[string, uint]]()

  let start = epochTime()
  var counter: float 

  for kind, path in walkDir(hwmon_path, skipSpecial=true):
    if kind == pcFile or kind == pcLinkToFile: continue
  
    var idToSensors = initTable[string, Sensor]() 

    let start = epochTime()
    let cycleStart = epochTime()

    for kind, path in walkDir(path, skipSpecial=true):
      if kind != pcFile: continue

      let name = path.extractFilename()

      let fields = name.split("_")
      if fields.len() != 2: continue

      let (sensorId, sensorType) = (fields[0], fields[1])

      var sensor = idToSensors.getOrDefault(sensorId)
      case sensorType:
        of "label":
          let startRead = epochTime()
          sensor.label = readFile(path).strip()
          counter += (epochTime() - startRead)
          # echo (), " label", " ms"
          echo "label"
        of "input":
          let startRead = epochTime()
          sensor.value = readFile(path).strip().parseUint()
          # echo (), " input", " ms"
          counter += (epochTime() - startRead)
          echo  sensor
        else:
          continue

      idToSensors[sensorId] = sensor
    echo (epochTime() - cycleStart), " cycle", " ms"


    let monitorName = readFile(path / "name").strip()

    let sensorToMonitorStart= epochTime()
    for id, sensor in idToSensors:
      var sensors = monitors.getOrDefault(monitorName)
      var sensorName = sensor.label

      if sensorName == "": sensorName = id

      sensors[sensorName] = sensor.value
      monitors[monitorName]= sensors

    echo (epochTime() - sensorToMonitorStart) * 1000, " sensormoncycle" , "ms"
    echo counter, " counter", "ms"

    echo (epochTime() - start) * 1000, " bigcycle" , "ms"
    

  echo (epochTime() - start) * 1000, "ms", " whole"

  return monitors


