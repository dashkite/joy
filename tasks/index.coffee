# import "coffeescript/register"
import p from "path"
import * as t from "@dashkite/genie"
import * as m from "@dashkite/masonry"
import {coffee} from "@dashkite/masonry/coffee"
import * as q from "panda-quill"
import YAML from "js-yaml"
import Handlebars from "handlebars"

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

t.define "doc:generate", ->
  reference = YAML.load await q.read p.join "docs", "reference.yaml"
  template = Handlebars.compile await q.read p.join "docs", "reference.md.hb"
  q.write (p.join "docs", "reference.md"), template reference
