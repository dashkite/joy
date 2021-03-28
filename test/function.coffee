import assert from "assert"
import {print, test, success} from "amen"

# module under text
import * as x from "@dashkite/joy/function"

do ->

  print await test "Core functions", [

    test "identity", -> assert.equal 7, x.identity 7
    test "wrap", -> assert.equal 7, (x.wrap 7)()

    test "unary", -> assert.equal 1, (x.unary ->).length
    test "binary", -> assert.equal 2, (x.binary ->).length
    test "ternary", -> assert.equal 3, (x.ternary ->).length
    test "arity", -> assert.equal 4, (x.arity 4, ->).length

    test "curry", -> assert.equal 3, (x.curry (x,y) -> x + y)(1)(2)

    test "substitute", -> assert.equal 2, (x.substitute [1, x._, 3], [2])[1]
    test "partial", -> assert.equal 9, (x.partial Math.pow, [ x._, 2 ])(3)

    test "flip", -> assert.equal 9, (x.curry x.flip Math.pow)(2)(3)

    test "tee", [

      test "sync", ->

        count = 0
        f = x.tee (x) -> count++

        assert.equal 7, f 7
        assert.equal 1, count

      test "async", ->

        count = 0
        f = x.tee (x) -> Promise.resolve count++

        assert.equal 7, await f 7
        assert.equal 1, count

    ]

    test "rtee", [

      test "sync", ->

        count = 0
        f = x.rtee (x, y) -> count++

        assert.equal 7, f 0, 7
        assert.equal 1, count

      test "async", ->

        count = 0
        f = x.rtee (x, y) -> Promise.resolve count++

        assert.equal 7, await f 0, 7
        assert.equal 1, count

    ]

    test "wait", ->
      assert.equal 4, await ((x.wait x.identity)(Promise.resolve 4))

    test "pipe", ->
      a = (x) -> x + "a"
      b = (x) -> x + "b"
      c = (x) -> x + "c"
      f = x.pipe [ a, b, c ]
      assert.equal "Sabc", f "S"

    test "compose", ->
      a = (x) -> x + "a"
      b = (x) -> x + "b"
      c = (x) -> x + "c"
      f = x.compose [ c, b, a ]
      assert.equal "Sabc", f "S"

    test "flow", ->
      a = (x) -> Promise.resolve x + "a"
      b = (x) -> Promise.resolve x + "b"
      c = (x) -> Promise.resolve x + "c"
      alpha = x.flow [ a, b, c ]
      assert.equal "Sabc", await alpha "S"

    test "apply", ->
      assert.equal 1, (x.apply x.identity, [1])

    test "spread", ->
      assert.equal "ab", (x.spread (a, b) -> a + b)(["a", "b"])

    test "once", ->
      count = 0
      f = x.once -> count++
      f()
      f()
      assert.equal 1, count

    test "memoize", ->
      count = 0
      f = x.memoize (x) -> count++
      assert.equal 0, f 1
      assert.equal 0, f 1
      assert.equal 1, f 2
  ]
