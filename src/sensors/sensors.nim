import std/[tables, os, strutils]

proc parse*(path: string): Table[string, Table[string, float]] =
    var t = initTable[string, Table[string, float]]()

    for kind, monitor in walkDir(path):
        if kind in {pcDir, pcLinkToDir}:
            var m = initTable[string, float]()
            var temp = initTable[string, string]()
            var monitorName: string

            for kind, sensor in walkDir(monitor):
                if kind != pcFile: continue

                let name = extractFilename(sensor)

                if name == "name":
                    monitorName = readFile(sensor).strip()
                    continue

                if not name.startsWith("temp"): continue

                let sensorType = name.split("_")[1]
                let id = name.split("_")[0]

                case sensorType:
                of "label":
                    temp[id] = readFile(sensor).strip()
                of "input":
                    m[id] = readFile(sensor).strip().parseFloat()

            for k, v in temp:
                m[v] = m[k]
                m.del(k)

            t[monitorName] = m


    return t
