import assert from "@dashkite/assert"
import { test, success } from "@dashkite/amen"
import print from "@dashkite/amen-console"

import {isDefined} from "../src/type"


# module under test
import * as _ from "../src/object"


export default ->

  print await test "object helpers", [

    test "keys", ->
      assert.deepEqual (_.keys x: 1, y: 2), [ "x", "y" ]

    test "values", ->
      assert.deepEqual (_.values x: 1, y: 2), [ 1, 2 ]

    test "pairs", ->
      assert.deepEqual (_.pairs {a: 1, b: 2, c: 3}),
        [["a", 1], ["b", 2], ["c", 3]]

    test "has", ->
      assert.equal true, (_.has "x", x: 1)
      assert.equal true, !(_.has "y", x: 1)

    test "get", ->
      assert.equal 1, (_.get "x", x: 1)

    test "set", ->
      assert.deepEqual { x: 2 }, (_.set "x", 2, x: 1)

    test "mask", ->
      assert.deepEqual { foo: "foo", bar: "bar" }, 
        _.mask [ "foo", "bar" ], { foo: "foo", data: "123", bar: "bar" }

    test "exclude", ->
      assert.deepEqual { foo: "foo", bar: "bar" }, 
        _.exclude [ "data" ], { foo: "foo", data: "123", bar: "bar" }

    test "assign", ->
      a = x: 1, y: 2
      b = z: 3
      _.assign a, b
      assert.deepEqual a, {x: 1, y: 2, z: 3}

    test "merge", ->
      a = x: 1, y: 2
      b = z: 3
      c = _.merge a, b
      assert.deepEqual a, {x: 1, y: 2}
      assert.deepEqual c, {x: 1, y: 2, z: 3}

    test "query", ->
      assert.equal true, _.query { x: 1 }, { x: 1, y: 2 }
      assert.equal false, _.query { x: 2 }, { x: 1, y: 2 }
      assert.equal true, _.query { x: {y: 2 }}, { x: { y: 2}}
      assert.equal false, _.query { x: {y: 2 }}, { x: { y: 1}}
      assert.equal true, _.query 1, 1
      assert.equal false, _.query 1, 2

    test "expand/collapse", ->
      before = { x: { a: 1, b: 2, c: { q: 3 }}, y: 4, z: { d: 5 }}
      after = _.collapse delimiter: "-", before        
      assert.deepEqual after,
        { 'x-a': 1, 'x-b': 2, 'x-c-q': 3, y: 4, 'z-d': 5 }
      assert.deepEqual before, _.expand delimiter: "-", after

    test "getx", ->
      target = { x: { a: 1, b: 2, c: { q: 3 }}, y: 4, z: { d: 5 }}
      assert.equal 3, _.getx "x.c.q", target
      assert.deepEqual { q: 3 }, _.getx "x.c", target
      assert.deepEqual { d: 5 }, _.getx "z", target

    test "setx", ->
      target = { x: { a: 1, b: 2, c: { q: 3 }}, y: 4, z: { d: 5 }}
      _.setx "x.c.q", 5, target
      assert.equal 5, _.getx "x.c.q", target
      # implicit initialization
      _.setx "x.d.q", 7, target
      assert.equal 7, _.getx "x.d.q", target

    test "hasx", ->
      target = { x: { a: 1, b: 2, c: { q: 3 }}, y: 4, z: { d: 5 }}
      assert _.hasx "x.c.q", target
      assert !(_.has "x.c.p", target )


  ]
