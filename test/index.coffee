import {success} from "amen"
import FS from "fs/promises"
import Path from "path"


run = (target) -> ((await import("./#{target}")).default)()

do ->

  targets = (process.env.targets?.split /\s+/) ?
    ((await FS.readdir "test")
      .map (path) -> Path.basename path, ".coffee"
      .filter (name) -> name != "index")
      .map (path) -> "#{path}.js"

  await Promise.all (run target for target in targets)

  process.exit if success then 0 else 1
