import assert from "@dashkite/assert"
import { test, success } from "@dashkite/amen"
import print from "@dashkite/amen-console"

import * as _ from "../src/math"

export default ->
  
  print await test "numeric helpers", [
    test "gt", -> assert _.gt 5, 6
    test "lt", -> assert _.lt 6, 5

    test "gte", ->
      assert _.gte 5, 6
      assert _.gte 5, 5

    test "lte", ->
      assert _.lte 5, 5
      assert _.lte 5, 5

    test "add", -> assert (_.add 5, 5) == 10

    test "sub", ->
      assert (_.sub 5, 3) == -2
      assert (_.sub 3, 5) == 2

    test "mul", -> assert (_.mul 3, 3) == 9

    test "div", ->
      assert (_.div 2, 10) == 5
      assert (_.div 10, 2) == (1/5)

    test "mod", ->
      assert (_.mod 2, 4) == 0
      assert (_.mod 2, 5) == 1

    test "isModulo", ->
      assert _.isModulo 2, 4
      assert ! _.isModulo 2, 5

    test "even", ->
      assert _.even 4
      assert ! _.even 5

    test "odd", ->
      assert ! _.odd 4
      assert _.odd 5

    test "min", -> assert (_.min [ 1, 2 ]) == 1
    test "max", -> assert (_.max [ 1, 2 ]) == 2

    test "abs", ->
      assert (_.abs -5) == 5
      assert (_.abs 5) == 5

    test "pow", ->
      assert.equal 8, _.pow 2, 3
      pow2 = _.pow 2
      assert.equal 8, pow2 3
  ]
