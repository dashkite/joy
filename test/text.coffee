import assert from "assert"
import {test, print} from "amen"

#module under test
import * as $ from "../src/text"

export default ->

  print await test "text helpers", [

    test "toString", ->
      assert ($.toString 1) == Number(1).toString()

    test "toBase", ->
      assert.equal "101", $.toBase 2, 5
      assert.equal "3f", $.toBase 16, 63
      assert.equal "3w5e11264sgsg", $.toBase 36, 2n ** 64n

    test "toUpperCase", ->
      assert ($.toUpperCase "hello, world!") == "HELLO, WORLD!"

    test "toLowerCase", ->
      assert ($.toLowerCase "Hello, World!") == "hello, world!"

    test "collapse", ->
      assert.equal "What exactly is it?",
        $.collapse " What exactly is it?   "

    test "uncase", ->
      assert.equal "foo bar", $.uncase "foo-bar"
      assert.equal "foo bar", $.uncase "fooBar"
      assert.equal "foo bar", $.uncase "foo_bar"

    test "gloss", ->
      assert.equal "whats happening",
        $.gloss "What's happening?!"
      assert.equal "foo bar", $.gloss "foo, bar"
      assert.equal "foo bar", $.gloss "foo' bar"
      assert.equal "foo bar", $.gloss "  foo  bâr"
      assert.equal "ola como esta a senhorita",
        $.gloss "Olá\r\n  como  está a   senhorita?"

    test "normalize", ->
      verify = (s1, s2) ->
        assert.equal ($.normalize s1), ($.normalize s2)

      verify "\u00F1", "\u006E\u0303"
      verify "\u00F1", "\u006E\u0303"
      verify "\uFB00", "\u0066\u0066"

      assert.equal "ola como esta a senhorita",
        $.normalize "olá como está a senhorita"

    test "split", ->
      assert.deepEqual ($.split ", ", "Hello, World!"), ["Hello", "World!"]

    test "w", -> assert ($.w "one two three").length == 3

    test "isBlank", ->
      assert $.isBlank ""
      assert !$.isBlank " "

    test "match", ->
      assert ($.match /foo/, "foobar")[0] = "foo"

    test "isMatch", ->
      assert ($.isMatch /foo/, "foobar")

    test "replace", ->
      assert ($.replace /bar/, "baz", "foobar") == "foobaz"

    test "template", ->
      f = $.template "foo {{ bar | reverse }} baz",
        reverse: (s) -> s.split("").reverse().join("")
      assert.equal "foo xuaf baz", f bar: "faux"


]
