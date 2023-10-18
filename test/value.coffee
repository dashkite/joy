import assert from "@dashkite/assert"
import { test, success } from "@dashkite/amen"
import print from "@dashkite/amen-console"

import {sleep} from "../src/time"
import {equal, notEqual, eq, neq, clone, size, isEmpty} from "../src/value"

export default ->

  print await test "value", [

    test "clone", [

      test "primitive types", do (scenario = undefined) ->

        scenario = (original) ->
          -> assert.equal original, clone original

        [
          test "null", scenario null
          test "number", scenario 3
          test "NaN", -> scenario NaN
          test "with bigint", scenario 35n
          test "string", scenario "hello"
          test "boolean", scenario true
        ]

      test "complex types", do (scenario = undefined) ->

        scenario = (original) ->
          ->
            copy = clone original
            assert.notEqual original, copy
            assert.deepEqual original, copy

        [
          test "object", scenario foo: "bar", baz: true
          test "array", scenario [1..5]
          # test "set", scenario new Set [ 1, 2, 3 ]
          # test "map", scenario new Map [ [ "foo", "bar" ] ]
          # test "buffer", scenario Buffer.from "panda"
          # test "array buffer", scenario (new Uint8Array.from "hello").buffer
          # test "data view", scenario new DataView new ArrayBuffer.from "hello"
          test "regexp", scenario  /foo/gi
          test "date", scenario  new Date()
          # test "symbol", scenario  Symbol "z"
        ]

      test "unsupported", do (scenario = undefined) ->

        scenario = (original) -> -> assert.throws (-> clone original)

        [
          test "function", scenario ->
          test "weak map", scenario new WeakMap
          test "error", scenario new Error "foobar"
        ]
    ]

    test "equal", [

      test "shallow", ->
        assert equal "panda", "panda"
        assert ! equal "panda", "panda2"

      test "deep", ->
        assert.equal true,
          equal x: 1, y: { z: {a: {b: {c: 12}}} },
            x: 1, y: { z: {a: {b: {c: 12}}} }
        assert.equal false,
          equal x: 1, y: { z: {a: {b: {c: 12}}} },
            x: 1, y: { z: {a: {b: {c: 13}}} }

      test "number", ->
        assert equal 1, 1
        assert ! equal 1, 2
      test "NaN", ->
        assert equal NaN, NaN
      test "string", ->
        assert equal " ", " "
        assert ! equal "", " "
      test "boolean", ->
        assert equal true, true
        assert ! equal true, false


      test "regexp", ->
        assert equal (/panda/gi), (/panda/gi)
        assert ! equal (/panda/gi), (/foo/gi)

      test "date", ->
        d1 = new Date('1995-12-17T03:24:00')
        d2 = new Date('1995-12-17T03:24:00')
        d3 = new Date('1995-12-17T03:24:01')
        assert.equal true, equal d1, d2
        assert.equal false, equal d1, d3

      test "symbol", ->
        A = Symbol "panda"
        assert equal A, A
        assert ! equal (Symbol "panda"), (Symbol "panda")
        assert ! equal (Symbol "panda"), (Symbol "bear")

      test "error", ->
        assert equal (new Error "panda"), (new Error "panda")
        assert ! equal (new Error "panda"), (new Error "foobar")

      test "array", ->
        assert equal [1, 2, 3], [1, 2, 3]
        assert ! equal [1, 2, 3], [1, 2, 4]

      test "set", ->
        assert equal ( new Set [1, 2, 3 ] ), ( new Set [ 1, 2, 3 ] )
        assert ! equal ( new Set [ 1, 2, 3 ] ), (new Set [ 1, 2, 4 ] )

      test "map", ->
        A = new Map()
        B = new Map()
        C = new Map()
        A.set "pandas", "are good"
        B.set "pandas", "are good"
        C.set "pandas", "are best"
        assert equal A, B
        assert ! equal A, C

      test "buffer", ->
        assert equal (Buffer.from "panda"), (Buffer.from "panda")
        assert ! equal (Buffer.from "panda" ), (Buffer.from "foobar")

      test "array buffer", ->
        assert equal (new ArrayBuffer 8), (new ArrayBuffer 8)
        assert ! equal (new ArrayBuffer 6), (new ArrayBuffer 8)

      test "data view", ->
        assert equal (new DataView new ArrayBuffer 8),
          (new DataView new ArrayBuffer 8)
        assert ! equal (new DataView new ArrayBuffer 6),
          (new DataView new ArrayBuffer 8)

      test "curryable", ->
        isOne = equal 1
        assert isOne 1
        assert ! isOne 2


      # Negative tests
      # test "weak map", ->
      #   assert.throws (-> equal new WeakMap(), new WeakMap())
      #
      # test "set", ->
      #   assert.throws (-> equal new Set(), new Set())

    ]

    test "notEqual", [

      test "shallow", ->
        assert ! notEqual "panda", "panda"
        assert notEqual "panda", "panda2"

      test "deep", ->
        assert.equal false,
          notEqual x: 1, y: { z: {a: {b: {c: 12}}} },
            x: 1, y: { z: {a: {b: {c: 12}}} }
        assert.equal true,
          notEqual x: 1, y: { z: {a: {b: {c: 12}}} },
            x: 1, y: { z: {a: {b: {c: 13}}} }
    ]

    test "eq", [

      test "equality", ->
        assert eq 1, 1
        assert ! eq 1, 2

      test "is shallow", ->
        assert.equal false,
          eq { x: 1 }, { x: 1 }

      test "curryable", ->
        isOne = equal 1
        assert isOne 1
        assert ! isOne 2
    ]

    test "neq", [

      test "negated equality", ->
        assert ! neq 1, 1
        assert neq 1, 2

      test "is shallow", ->
        assert.equal true,
          neq { x: 1 }, { x: 1 }

      test "curryable", ->
        isNotOne = neq 1
        assert ! isNotOne 1
        assert isNotOne 2
    ]

    test "size", [

      test "isEmpty", ->
        assert isEmpty ""
        assert ! isEmpty " "
        assert isEmpty []
        assert ! isEmpty [ 0 ]
        assert isEmpty {}
        assert ! isEmpty x: 1
        assert isEmpty new Map
        assert ! isEmpty new Map [[ "x", 1 ]]
        assert isEmpty new Set
        assert ! isEmpty new Set [ 0 ]

    ]


  ]
