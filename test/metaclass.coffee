import assert from "assert"
import {test, print} from "amen"

# module under test
import * as x from "@dashkite/joy/metaclass"

do ->

  print await test "metaclass", [

    test "property", ->
      f = x.property "x", get: -> "bar"
      f r = {}
      assert.equal r.x, "bar"

    test "getter", ->
      f = x.getter "x", -> "bar"
      f r = {}
      assert.equal r.x, "bar"

    test "setter", ->
      f = x.setter "x", (z) -> @_x = z
      f r = {}
      r.x = "bar"
      assert.equal r._x, "bar"

    test "method", ->
      f = x.method "x", (z) -> @_x = z
      f r = {}
      r.x "bar"
      assert.equal r._x, "bar"

    test "properties", ->
      f = x.properties x: get: -> "bar"
      f r = {}
      assert.equal r.x, "bar"

    test "getters", ->
      f = x.getters x: -> "bar"
      f r = {}
      assert.equal r.x, "bar"

    test "setters", ->
      f = x.setters x: (z) -> @_x = z
      f r = {}
      r.x = "bar"
      assert.equal r._x, "bar"

    test "methods", ->
      f = x.methods x: (z) -> @_x = z
      f r = {}
      r.x "bar"
      assert.equal r._x, "bar"

    test "mixin", ->
      x.mixin r = {}, [
        x.methods x: (z) -> @_x = z
      ]
      r.x "bar"
      assert.equal r._x, "bar"




  ]
