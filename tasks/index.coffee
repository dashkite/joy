import "coffeescript/register"
import p from "path"
import fs from "fs/promises"
import * as t from "@dashkite/genie"
import * as m from "@dashkite/masonry"
import {coffee} from "@dashkite/masonry/coffee"

import * as writeme from "@dashkite/writeme"
import YAML from "js-yaml"
import { tee, flow } from "../src/function"

t.define "clean", -> m.rm "build"

t.define "build", "clean", m.start [
  m.glob [ "{src,test}/**/*.coffee" ], "."
  m.read
  flow [
    m.tr coffee "node"
    m.extension ".js"
    m.write p.join "build", "node"
  ]
  flow [
    m.tr coffee "import"
    m.extension ".js"
    m.write p.join "build", "import"
  ]
]

t.define "node:test", [ "build" ], ->
  m.exec "node", [
    "--enable-source-maps"
    "./build/node/test/index.js"
  ]

t.define "test", [ "clean" ], ->
  require "../test"

index = undefined
t.define "docs:clean", ->
  fs.rm "docs/reference", recursive: true, force: true
  index = YAML.load await fs.readFile "docs/references.yaml", "utf8"

t.define "docs:index", m.start [
  m.glob [ "**/*.yaml" ], "./specs"
  m.read
  m.tr ({source, input}) ->
    data = YAML.load input
    index[data.name] = "/reference/#{source.directory}/#{source.name}"
]

t.define "docs:build", [ "docs:clean", "docs:index" ], m.start [
  m.glob [ "**/*.yaml" ], "./specs"
  m.read
  flow [
    m.tr ({input}) -> writeme.compile (YAML.load input), index
    m.extension ".md"
    m.write "docs/reference"
  ]
]

t.define "site:configure", ->
  fs.writeFile "docs/reference/index.yaml",
    YAML.dump
      expanded: true
      icon: "book"

t.define "site:build", [ "docs:build", "site:configure" ], ->
  fs.copyFile "./README.md", "docs/index.md"

t.define "site:watch", ->
  t.run "site:build"
  m.watch "specs", -> t.run "site:build"
