import os
import tables
import strutils

const hwmon_path = "/sys/class/hwmon"

type Sensor = object
  label: string
  value: uint


proc getSensors*(): Table[string, Table[string, uint]] =
  var monitors = initTable[string, Table[string, uint]]()

  for kind, path in walkDir(hwmon_path):
    if kind == pcFile or kind == pcLinkToFile:
      continue
  
    var id_to_sensors = initTable[string, Sensor]() 

    for kind, path in walkDir(path):
      if kind != pcFile:
        continue

      let name = path.extractFilename()

      let fields = name.split("_")

      if fields.len() != 2:
        continue

      let sensor_id = fields[0]
      let sensor_type = fields[1]

      var sensor = id_to_sensors.getOrDefault(sensor_id)
      case sensor_type:
        of "label":
          sensor.label = readFile(path).strip()
        of "input":
          sensor.value = readFile(path).strip().parseUint()
      id_to_sensors[sensor_id] = sensor


    let monitor_name = readFile(path / "name").strip()

    for id, sensor in id_to_sensors:
      var sensors = monitors.getOrDefault(monitor_name)
      var sensor_name = sensor.label

      if sensor_name == "": sensor_name = id

      sensors[sensor_name] = sensor.value
      monitors[monitor_name]= sensors

  return monitors


