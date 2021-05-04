import assert from "assert"
import {print, test, success} from "amen"

import * as fn from "../src/function"

# module under text
import * as x from "../src/predicate"

export default ->

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
        f = (n) -> fn.wrap n
        T = fn.wrap true
        F = fn.wrap false
        g = x.test T, f "a"
        h = x.test F, f "b"
        assert.equal true, do (x.test T, f "a")
        assert.equal false, do (x.test F, f "b")

      test "async", ->
        z = ""
        f = (n) -> fn.wrap n
        T = fn.wrap Promise.resolve true
        F = fn.wrap Promise.resolve false
        g = x.test T, f "a"
        h = x.test F, f "b"
        assert.equal true, await do (x.test T, f "a")
        assert.equal false, await do (x.test F, f "b")

    ]

    test "branch", [

      test "sync", ->
        z = ""
        f = (n, m) -> -> z += n; m
        a = f "a", false
        b = f "b", false
        c = f "c", true
        d = f "d", false
        T = fn.wrap true
        F = fn.wrap false
        assert.equal true, do x.branch [
          [ F, a ]
          [ F, b ]
          [ T, c ]
          [ F, d ]
        ]
        assert.equal "c", z
        assert.equal false, do x.branch [
          [ F, a ]
          [ F, b ]
          [ F, c ]
          [ F, d ]
        ]
        assert.equal "c", z


      test "async", ->
        z = ""
        f = (n) -> -> z += n
        a = f "a"
        b = f "b"
        c = f "c"
        d = f "d"
        T = fn.wrap Promise.resolve true
        F = fn.wrap Promise.resolve false
        assert.equal true, await do x.branch [
          [ F, a ]
          [ F, b ]
          [ T, c ]
          [ F, d ]
        ]
        assert.equal "c", z
        assert.equal false, await do x.branch [
          [ F, a ]
          [ F, b ]
          [ F, c ]
          [ F, d ]
        ]
        assert.equal "c", z

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
