import assert from "assert"
import {print, test, success} from "amen"

import * as fn from "../src/function"

# module under text
import * as x from "../src/predicate"

do ->

  print await test "predicates", [

    test "negate", [
        test "sync", ->
          f = -> false
          assert.equal true, (x.negate f)()

        test "async", ->
          f = -> Promise.resolve false
          assert.equal true, await (x.negate f)()

      ]

    test "any", [

      test "sync", ->
        z = ""
        f = (n, m) -> -> z += n; m
        a = f "a", false
        b = f "b", false
        c = f "c", true
        d = f "d", false
        do x.any [ a, b, c, d ]
        assert.equal "abc", z

      test "async", ->
        z = ""
        f = (n, m) -> -> z += n; Promise.resolve m
        a = f "a", false
        b = f "b", false
        c = f "c", true
        d = f "d", false
        await do x.any [ a, b, c, d ]
        assert.equal "abc", z
    ]

    test "all", [

      test "sync", ->
        z = ""
        f = (n, m) -> -> z += n; m
        a = f "a", true
        b = f "b", true
        c = f "c", false
        d = f "d", true
        do x.all [ a, b, c, d ]
        assert.equal "abc", z

      test "async", ->
        z = ""
        f = (n, m) -> -> z += n; Promise.resolve m
        a = f "a", true
        b = f "b", true
        c = f "c", false
        d = f "d", true
        await do x.all [ a, b, c, d ]
        assert.equal "abc", z
    ]

    test "test", [

      test "sync", ->
        z = ""
        f = (n) -> -> z += n
        T = fn.wrap true
        F = fn.wrap false
        do x.test T, f "a"
        do x.test F, f "b"
        assert.equal "a", z

      test "async", ->
        z = ""
        f = (n) -> -> z += n
        T = fn.wrap Promise.resolve true
        F = fn.wrap Promise.resolve false
        await do x.test T, f "a"
        await do x.test F, f "b"
        assert.equal "a", z
    ]

    test "branch", [

      test "sync", ->
        z = ""
        f = (n) -> -> z += n
        T = fn.wrap true
        F = fn.wrap false
        assert.equal "b",
          do x.branch [
            [ F, f "a" ]
            [ T, f "b" ]
          ]

      test "async", ->
        z = ""
        f = (n) -> -> z += n
        T = fn.wrap Promise.resolve true
        F = fn.wrap Promise.resolve false
        assert.equal "b",
          await do x.branch [
            [ F, f "a" ]
            [ T, f "b" ]
          ]
    ]

    test "attempt", [

      test "sync", ->
        f = -> throw new Error "test error"
        assert.equal false,
          do x.attempt f

      test "async", ->
        f = -> Promise.reject "test error"
        assert.equal false,
          await do x.attempt f

    ]
  ]
