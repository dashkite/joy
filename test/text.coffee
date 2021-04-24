import assert from "assert"
import {test, print} from "amen"

import {
  toString
  toUpperCase
  toLowerCase
  trim
  split
  w
  isBlank
  match
  isMatch
  replace
  template
} from "../src/text"

export default ->

  print await test "text helpers", [

    test "toString", ->
      assert (toString 1) == Number(1).toString()

    test "toUpperCase", ->
      assert (toUpperCase "hello, world!") == "HELLO, WORLD!"

    test "toLowerCase", ->
      assert (toLowerCase "Hello, World!") == "hello, world!"

    test "trim", -> assert (trim "  Hello, World!  ") == "Hello, World!"

    test "split", ->
      assert.deepEqual (split ", ", "Hello, World!"), ["Hello", "World!"]

    test "w", -> assert (w "one two three").length == 3

    test "isBlank", ->
      assert isBlank ""
      assert !isBlank " "

    test "match", ->
      assert (match /foo/, "foobar")[0] = "foo"

    test "isMatch", ->
      assert (isMatch /foo/, "foobar")

    test "replace", ->
      assert (replace /bar/, "baz", "foobar") == "foobaz"

    test "template", ->
      f = template "foo {{ bar | reverse }} baz",
        reverse: (s) -> s.split("").reverse().join("")
      assert.equal "foo xuaf baz", f bar: "faux"


]
