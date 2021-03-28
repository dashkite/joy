import assert from "assert"
import {print, test, success} from "amen"

import {noOp, identity, wrap,
  arity, unary, binary, ternary,
  curry, _, substitute, partial,
  flip, compose, pipe, apply, spread, wait, flow,
  negate, once, given, memoize, tee, rtee} from "../src/compose"

do ->

  print await test "Core functions", [

    test "identity", -> assert (identity 7) == 7
    test "wrap", -> assert (wrap 7)() == 7

    test "unary", -> assert (unary ->).length == 1
    test "binary", -> assert (binary ->).length == 2
    test "ternary", -> assert (ternary ->).length == 3

    test "arity", ->
      f = (x=0, y=0, z=0) -> x + y + z
      g = arity 2, f
      assert g.length == 2
      assert (g 1, 2) == 3
      assert (g 1, 2, 3) == 6

    test "curry", [
        test "nullary function", ->
          g = curry -> 0
          assert g.length == 0
          assert g() == 0
        test "unary function", ->
          g = curry (x) -> x
          assert g.length == 1
          assert (g 1) == 1
        test "binary function", ->
          g = curry (x,y) -> x + y
          assert g.length == 2
          assert (g 1, 2) == 3
        test "ternary function", ->
          g = curry (x,y,z) -> x + y + z
          assert g.length == 3
          assert (g 1, 2, 3) == 6
        test "returns curried function", ->
          g = curry (w,x,y,z) -> w + x + y + z
          assert g.length == 4
          h = g 1
          assert h.length == 3
          i = h 2
          assert i.length == 2
          j = i 3
          assert j.length == 1
          assert (j 4) == 10
    ]

    test "substitute", ->
      assert (substitute [1, _, 3], [2])[1] == 2

    test "partial", ->
      square = partial Math.pow, [ _, 2 ]
      assert (square 3) == 9

    test "flip", ->
      square =  (curry flip Math.pow)(2)
      assert (square 3) == 9

    test "tee", [
      test "nullary function", ->
        f = -> 1
        g = tee f
        assert g.length == 1
        assert (g 5) == 5
      test "unary function", ->
        f = tee (x) -> 1/x
        assert f.length == 1
        assert (f 5) == 5
      test "binary function", ->
        f = tee (x, y) -> x + y
        assert f.length == 2
        assert (f 5, 10) == 5
      test "ternary function", ->
        f = tee (x, y, z) -> x + y + z
        assert f.length == 3
        assert (f 5, 10, 15) == 5
    ]

    test "tee (promise)", [
      test "nullary function", ->
        f = tee -> Promise.resolve 1
        assert f.length == 1
        assert (await f 5) == 5
      test "unary function", ->
        f = tee (x) -> Promise.resolve 1/x
        assert f.length == 1
        assert (await f 5) == 5
      test "binary function", ->
        f = tee (x, y) -> Promise.resolve x + y
        assert f.length == 2
        assert (await f 5, 10) == 5
      test "ternary function", ->
        f = tee (x, y, z) -> Promise.resolve x + y + z
        assert f.length == 3
        assert (await f 5, 10, 15) == 5
    ]

    test "rtee", [
      test "nullary function", ->
        f = rtee -> 1
        assert f.length == 1
        assert (f 5) == 5
      test "unary function", ->
        f = rtee (x) -> 1/x
        assert f.length == 1
        assert (f 5) == 5
      test "binary function", ->
        f = rtee (x, y) -> x + y
        assert f.length == 2
        assert (f 5, 10) == 10
      test "ternary function", ->
        f = rtee (x, y, z) -> x + y + z
        assert f.length == 3
        assert (f 5, 10, 15) == 15
    ]

    test "rtee (promise)", [

      test "nullary function", ->
        f = rtee -> Promise.resolve 1
        assert f.length == 1
        assert (await f 5) == 5
      test "unary function", ->
        f = rtee (x) -> Promise.resolve 1/x
        assert f.length == 1
        assert (await f 5) == 5
      test "binary function", ->
        f = rtee (x, y) -> Promise.resolve x + y
        assert f.length == 2
        assert (await f 5, 10) == 10
      test "ternary function", ->
        f = rtee (x, y, z) -> Promise.resolve x + y + z
        assert f.length == 3
        assert (await f 5, 10, 15) == 15
    ]

    test "wait", ->
      square = wait (x) -> Math.pow x, 2
      # assert.equal 4, (square 2)
      assert.equal 4, await square Promise.resolve 2

    test "pipeWith (validations)", [

      # test "non-array-like inputs", ->
      #   assert.throws (-> flow()),
      #     /^Error: garden: pipeWith:[^\n]+\nProvided: undefined/m
      #
      #   assert.throws (-> flow null),
      #     /^Error: garden: pipeWith:[^\n]+\nProvided: null/m

      test "with exceptions", ->

        a = (x) -> Promise.resolve x + "a"
        _a = (x) -> Promise.reject new Error "test error in _a"
        b = (x) -> x + "b"
        _b = (x) -> throw new Error "test error in _b"
        c = (x) -> Promise.resolve x + "c"
        _d = ""

        alpha = flow [a, _a, b, c]
        await assert.rejects (-> alpha "S"),
          /^Error: garden: pipeWith:[^\n]+\nat\: _a/m

        alpha = flow [a, b, _b, c]
        await assert.rejects (-> alpha "S"),
          /^Error: garden: pipeWith:[^\n]+\nat: _b/m

        # This is a strange test: _d gets converted into an
        # anonymous function (!) and this is Dan's fault!
        alpha = flow [ a, b, c, _d ]
        await assert.rejects (-> alpha "S"),
          /^TypeError: garden: pipeWith:[^\n]+\nat: anonymous-3/m

    ]

    test "pipe", ->
      a = (x) -> x + "a"
      b = (x) -> x + "b"
      c = (x) -> x + "c"
      alpha = pipe [ a, b, c ]
      assert (alpha "S") == "Sabc"

    test "compose", ->
      inverse = (x) -> 1/x
      square = (x) -> x * x
      inverseSquare = compose [ inverse, square ]
      assert inverseSquare 5 == 1/25

    test "flow", ->
      a = (x) -> Promise.resolve x + "a"
      b = (x) -> Promise.resolve x + "b"
      c = (x) -> Promise.resolve x + "c"
      alpha = flow [ a, b, c ]
      assert.equal "Sabc", await alpha "S"

    test "apply", ->
      assert (apply identity, [1]) == 1

    test "spread", ->
      assert (spread (a, b) -> a + b)(["a", "b"]) == "ab"

    test "negate", ->
      assert (negate -> false)()

    test "once", ->
      (f = do (i=0) -> once -> i++)()
      assert f() == 0

    test "memoize", do ->
      count = 0
      f = memoize (x, y) -> count++; x
      [
        test "runs the function", ->
          assert f(1, 2) == 1 && count == 1
        test "but only once for a given argument", ->
          assert f(1, 2) == 1 && count == 1
        test "without affecting any other arguments", ->
          assert f(2, 1) == 2 && count == 2
      ]
  ]
