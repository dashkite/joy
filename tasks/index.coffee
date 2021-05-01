import "coffeescript/register"
import p from "path"
import fs from "fs/promises"
import * as t from "@dashkite/genie"
import * as m from "@dashkite/masonry"
import {coffee} from "@dashkite/masonry/coffee"
import * as q from "panda-quill"
import YAML from "js-yaml"
# import Handlebars from "handlebars"
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

# Handlebars.registerHelper "lower", (text) ->
#   text = Handlebars.escapeExpression text
#   new Handlebars.SafeString text.toLowerCase()

# t.define "docs:generate", ->
#   reference = YAML.load await q.read p.join "docs", "reference.yaml"
#   template = Handlebars.compile await q.read p.join "docs", "reference.md.hbs"
#   q.write (p.join "docs", "reference.md"), template reference

import * as writeme from "@dashkite/writeme"

t.define "docs:clean", ->
  fs.rm "docs/reference", recursive: true, force: true

t.define "docs:build", "docs:clean", m.start [
  m.glob [ "**/*.yaml" ], "./specs"
  m.read
  flow [
    m.tr ({input}) -> writeme.compile YAML.load input
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

t.define "docs:migrate", ->
  console.info "Cleaning ..."
  await fs.rm "specs", recursive: true, force: true
  console.info "Loading reference.yaml ..."
  reference = YAML.load await q.read p.join "docs.old", "reference.yaml"
  for category in reference
    path = "specs/#{category.name.toLowerCase()}"
    console.info "Creating directory #{path} ..."
    await fs.mkdir path, recursive: true
    for f in category.functions
      name = f.name.replace /[^\w\.].*$/, ""
      [, aliases...] = f.name.split "/"
      console.info "Normalizing metadata for #{name} ..."
      metadata =
        title: f.name
        name: name
        aliases: if aliases.length > 0 then aliases
        type: "function"
        summary: f.description
        signatures: [
          arguments: do ->
            for argument in f.arguments.split ","
              name: argument.trim()
          returns: name: f.returns
        ]
        examples: do ->
          if f.example?
            [ code: CoffeeScript: f.example ]
      console.info "Writing metadata as YAML for #{name} ..."
      await fs.writeFile "#{path}/#{name}.yaml", YAML.dump metadata
