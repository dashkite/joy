# import "coffeescript/register"
import * as t from "@dashkite/genie"
import * as m from "@dashkite/masonry"
import {coffee} from "@dashkite/masonry/coffee"

t.define "clean", -> m.rm "build"

t.define "build", "clean", m.start [
  m.glob [ "{src,test}/**/*.coffee" ], "."
  m.read
  m.tr coffee "node"
  m.extension ".js"
  m.write "build"
]

t.define "test", [ "build" ], ->
  m.exec "node", [
    "--enable-source-maps"
    "./build/test/index.js"
  ]
