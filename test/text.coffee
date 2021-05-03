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

    test "fromBase", ->
      assert.equal 5, $.fromBase 2, "101"
      assert.equal 63, $.fromBase 16, "3f"
      assert.equal 2n ** 64n, $.fromBase 36, "3w5e11264sgsg"

    test "parseNumber", ->
      assert.equal 25, $.parseNumber " 25 "
      assert.equal 3.14159, $.parseNumber " 3.14159 "

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

    test "camelCase", ->
      assert.equal "helloWorld", $.camelCase "Hello, world!"
      assert.equal "helloWorld", $.camelCase "hello-world"
      assert.equal "helloWorld", $.camelCase "hello_World"
      assert.equal "comoEstaSenor", $.camelCase "¿cómo está, señor?"

    test "dashes", ->
      assert.equal "hello-world", $.dashed "Hello, world!"
      assert.equal "hello-world", $.dashed "helloWorld"
      assert.equal "hello-world", $.dashed "hello_World"
      assert.equal "como-esta-senor", $.dashed "¿cómo está, señor?"

    test "underscores", ->
      assert.equal "hello_world", $.underscores "Hello, world!"
      assert.equal "hello_world", $.underscores "hello-world"
      assert.equal "hello_world", $.underscores "helloWorld"
      assert.equal "como_esta_senor", $.underscores "¿cómo está, señor?"

    test "capitalize", ->
      assert.equal "Hello world", $.capitalize "hello world"

    test "titleCase", ->
      assert.equal "Hello World", $.titleCase "hello world"

    test "startsWith", ->
      assert $.startsWith "foo", "foo bar"
      assert ! $.startsWith "bar", "foo bar"

    test "endsWith", ->
      assert $.endsWith "bar", "foo bar"
      assert ! $.endsWith "foo", "foo bar"

    test "pad", ->
      assert.equal ".foo bar..", $.pad 10, ".", "foo bar"
      assert.equal "foo bar", $.pad 7, ".", "foo bar"
      assert.equal "foo bar.", $.pad 8, ".", "foo bar"

    test "padEnd", ->
      assert.equal "foo bar...", $.padEnd 10, ".", "foo bar"

    test "padStart", ->
      assert.equal "...foo bar", $.padStart 10, ".", "foo bar"

    test "enclose", ->
      assert.equal " foo bar ", $.enclose " ", "foo bar"
      assert.equal "[foo bar]", $.enclose "[]", "foo bar"
      assert.equal "[ foo bar ]", $.enclose [ "[ ", " ]" ], "foo bar"

    test "quote / squote", ->
      assert.equal '"foo bar"', $.quote "foo bar"
      assert.equal "'foo bar'", $.squote "foo bar"

    test "repeat", ->
      assert.equal "****", $.repeat 4, "*"

    test "truncate", ->
      assert.equal "foo", $.truncate 3, "foo bar"

    test "elide", [

      test "no eliding", ->
        assert.equal "This is simply too much!",
          $.elide 24, "...", "This is simply too much!"

      test "elide the last word", ->
        for n in [21..23]
          assert.equal "This is simply too...",
            $.elide n, "...", "This is simply too much!"

      test "elide the last two words", ->
        for n in [17..20]
          assert.equal "This is simply...",
            $.elide n, "...", "This is simply too much!"

    ]

    test "split", ->
      assert.deepEqual ($.split ", ", "Hello, World!"), ["Hello", "World!"]

    test "words", -> assert ($.words "one two three").length == 3

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
