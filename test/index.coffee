import {success} from "amen"
import p from "path"
import * as q from "panda-quill"

run = (target) -> ((await import("./#{target}")).default)()

do ->

  targets = (process.env.targets?.split /\s+/) ?
    ((await q.ls "test")
      .map (path) -> p.basename path, ".coffee"
      .filter (name) -> name != "index")

  await Promise.all (run target for target in targets)

  process.exit if success then 0 else 1
