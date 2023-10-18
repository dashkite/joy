import assert from "@dashkite/assert"
import { test, success } from "@dashkite/amen"
import print from "@dashkite/amen-console"

# under test
import * as _ from "../src/set"

export default ->

  print await test "set", [

    test "union", ->
      assert.deepEqual (_.union [1..6], [4..10]), new Set [1..10]

    test "intersection", ->
      assert.deepEqual (_.intersection [1..6], [4..10]), new Set [4..6]

    test "complement", ->
      assert.deepEqual (_.complement [1..5], [3..6]), new Set [1,2,6]

    test "difference", ->
      assert.deepEqual (_.difference [1..9], [2..10]), new Set [1]

    test "unique", ->
      assert.deepEqual (_.unique [[1..4]..., [4..1]...]), new Set [1..4]

    test "dupes", ->
      assert.deepEqual (_.dupes [[1..3]..., [2..1]...]), new Set [1,2]


  ]
