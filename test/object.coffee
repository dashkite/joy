import assert from "assert"
import {test, print} from "amen"

import {isDefined} from "../src/type"


# module under test
import * as x from "../src/object"


export default ->

  print await test "object helpers", [

    test "keys", ->
      assert.deepEqual (x.keys x: 1, y: 2), [ "x", "y" ]

    test "values", ->
      assert.deepEqual (x.values x: 1, y: 2), [ 1, 2 ]

    test "pairs", ->
      assert.deepEqual (x.pairs {a: 1, b: 2, c: 3}),
        [["a", 1], ["b", 2], ["c", 3]]

    test "has", ->
      assert.equal true, (x.has "x", x: 1)
      assert.equal true, !(x.has "y", x: 1)

    test "get", ->
      assert.equal 1, (x.get "x", x: 1)

    test "set", ->
      assert.deepEqual { x: 2 }, (x.set "x", 2, x: 1)

    test "mask", ->
      assert.deepEqual { foo: "foo", bar: "bar" }, 
        x.mask [ "foo", "bar" ], { foo: "foo", data: "123", bar: "bar" }

    test "assign", ->
      a = x: 1, y: 2
      b = z: 3
      x.assign a, b
      assert.deepEqual a, {x: 1, y: 2, z: 3}

    test "merge", ->
      a = x: 1, y: 2
      b = z: 3
      c = x.merge a, b
      assert.deepEqual a, {x: 1, y: 2}
      assert.deepEqual c, {x: 1, y: 2, z: 3}

    test "query", ->
      assert.equal true, x.query { x: 1 }, { x: 1, y: 2 }
      assert.equal false, x.query { x: 2 }, { x: 1, y: 2 }
      assert.equal true, x.query { x: {y: 2 }}, { x: { y: 2}}
      assert.equal false, x.query { x: {y: 2 }}, { x: { y: 1}}
      assert.equal true, x.query 1, 1
      assert.equal false, x.query 1, 2

  ]
