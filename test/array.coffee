import assert from "@dashkite/assert"
import { test, success } from "@dashkite/amen"
import print from "@dashkite/amen-console"

# module under test
import * as _ from "../src/array"

export default ->

  print await test "array", [

    test "first", -> assert (_.first [1..5]) == 1
    test "second", -> assert (_.second [1..5]) == 2
    test "third", -> assert (_.third [1..5]) == 3
    test "fourth", -> assert (_.fourth [1..5]) == 4
    test "fifth", -> assert (_.fifth [1..5]) == 5
    test "nth", -> assert (_.nth 3, [1..5]) == 3
    test "last", -> assert (_.last [1..5]) == 5
    test "rest", -> assert (_.first _.rest [1..5]) == 2

    test "push/enqueue", -> assert.deepEqual (_.push [1..4], 5), [1..5]
    test "pop/dequeue", -> assert (_.pop [1..5]) == 5

    test "shift", ->
      A = [1, 2, 3]
      assert (_.shift A) == 1
      assert.deepEqual A, [2, 3]

    test "unshift", ->
      assert.deepEqual (_.unshift 0, [1, 2, 3]), [0, 1, 2, 3]

    test "cat", -> assert.deepEqual (_.cat [1..5], [6..10]), [1..10]

    test "slice", ->
      assert.deepEqual (_.slice  1,  2, [1..5]), [2]
      assert.deepEqual (_.slice  2,  5, [1..5]), [3,4,5]
      assert.deepEqual (_.slice  1, -2, [1..5]), [2,3]
      assert.deepEqual (_.slice -3, -1, [1..5]), [3,4]
      assert.deepEqual (_.slice -3, -1, "0123456789"), "78"

    test "splice", ->
      A = [1, 2, 3, 4, 5]
      assert.deepEqual (_.splice 0, 0, A), [1, 2, 3, 4, 5]
      assert.deepEqual (_.splice 0, 1, A), [2, 3, 4, 5]
      assert.deepEqual (_.splice 2, 2, A), [2, 3]
      assert.deepEqual A, [2, 3]

    test "insert", ->
      assert.deepEqual (_.insert 1, 3, [4,2,1]), [4,3,2,1]
      assert.deepEqual (_.insert -1, 3, [1,2,4]), [1..4]
      assert.deepEqual (_.insert 0, 1, [2..4]), [1..4]

    test "remove", ->
      assert.deepEqual (_.remove 3, [1..5]), [1,2,4,5]
      assert.deepEqual (_.remove 6, [1..5]), [1..5]

    test "range", ->
      assert.deepEqual (_.range 1, 5), [1..5]
      assert.deepEqual (_.range 5, 1), [5..1]

    test "fill", ->
      A = [1, 2, 3, 4]
      assert.deepEqual (_.fill 0, A), [0,0,0,0]

    test "pluck", ->
      A = [1, 2, 3, 4, 5]
      assert (_.pluck A) in A
      assert A.length == 5

    test "pair", -> assert.deepEqual (_.pair 1, 2), [1, 2]

    test "sort", ->
      assert.deepEqual [0..5], _.sort ((a, b) -> a - b), [5..0]

    test "shuffle", ->

      A = [1, 2, 3, 4, 5]
      B = _.shuffle A

      assert A.length == B.length

      for value in A
        assert value in B

      assert.notDeepEqual A, B

  ]
