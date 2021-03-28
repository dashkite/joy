import {success} from "amen"
import p from "path"
import * as q from "panda-quill"

do ->

  targets = (process.env.targets?.split /\s+/) ?
    ((await q.ls "test")
      .map (path) -> p.basename path, ".coffee"
      .filter (name) -> name != "index")

  for target in targets
    await require "./#{target}"

  process.nextTick ->
    process.exit if success then 0 else 1
