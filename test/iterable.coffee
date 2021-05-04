import assert from "assert"
import {test, print} from "amen"

# under test
import * as _ from "../src/iterable"

export default ->

  print await test "iterable", [

    test "includes", ->
      assert (_.includes 3, [1..5]) && !(_.includes 6, [1..5])
      assert.throws -> _.includes [1..5], 3

    test "uniqueBy", ->
      even = (x) -> x % 2 == 0
      assert.deepEqual (_.uniqueBy even, [1..5]), [1,3,5]


  ]