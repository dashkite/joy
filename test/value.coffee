import assert from "assert"
import {test, print} from "amen"

import {sleep} from "../src/time"
import {equal, clone, size, isEmpty} from "../src/value"

export default ->

  print await test "value", [

    test "clone", do (scenario=null) ->

      scenario = (original) ->
        ->
          copy = clone original
          assert original != copy
          assert.deepEqual original, copy

      failScenario = (original) ->
        -> assert.throws (-> clone original)

      [
        test "shallow", -> assert.deepEqual "panda", clone "panda"
        test "deep", scenario x: 1, y: { z: {a: {b: {c: 12}}} }

        test "number", scenario x: 1, y: { z: 3 }
        test "NaN", -> assert isNaN clone NaN
        test "string", scenario x: 1, y: { z: "3" }
        test "boolean", scenario x: 1, y: { z: true }

        test "regexp", scenario  x: 1, y: { z: /foo/gi }
        test "date", scenario  x: 1, y: { z: new Date() }
        test "symbol", scenario  x: 1, y: { z: [Symbol "z"] }

        test "array", scenario x: 1, y: { z: [1, 2, 3] }
        test "set", scenario x: 1, y: { z: new Set [1, 2, 3] }
        test "map", ->
          map = new Map()
          map.set "pandas", "are the best"
          do scenario x: 1, y: { z: map }
        test "buffer", scenario x: 1, y: { z: Buffer.from "panda" }
        test "array buffer", scenario x: 1, y: { z: new ArrayBuffer 8 }
        test "data view",
          scenario x: 1, y: { z: new DataView new ArrayBuffer 8 }

        # Negative tests
        test "function", failScenario x: 1, y: { z: -> }
        test "weak map", failScenario x: 1, y: { z: new WeakMap() }
        test "error", failScenario x: 1, y: { z: new Error "panda" }
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
        assert ! equal NaN, NaN
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


      # Negative tests
      # test "weak map", ->
      #   assert.throws (-> equal new WeakMap(), new WeakMap())
      #
      # test "set", ->
      #   assert.throws (-> equal new Set(), new Set())

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
