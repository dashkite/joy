import assert from "assert"
import {test, print} from "amen"

import {first, second, third, fourth, fifth, nth, last, rest,
  empty, includes, findIndexOf, findLastIndexOf, uniqueBy, unique, uniq, dupes,
  union, intersection, difference, complement, push, pop, shift, unshift,
  enqueue, dequeue, splice, insert, remove, cat, slice, join, fill,
  range, pluck, pair, shuffle} from "../src/array"

do ->

  print await test "array helpers", [

    test "first", -> assert (first [1..5]) == 1
    test "second", -> assert (second [1..5]) == 2
    test "third", -> assert (third [1..5]) == 3
    test "fourth", -> assert (fourth [1..5]) == 4
    test "fifth", -> assert (fifth [1..5]) == 5
    test "nth", -> assert (nth 3, [1..5]) == 3
    test "last", -> assert (last [1..5]) == 5
    test "rest", -> assert (first rest [1..5]) == 2

    test "push/enqueue", -> assert.deepEqual (push [1..4], 5), [1..5]
    test "pop/dequeue", -> assert (pop [1..5]) == 5

    test "shift", ->
      A = [1, 2, 3]
      assert (shift A) == 1
      assert.deepEqual A, [2, 3]

    test "unshift", ->
      A = [1, 2, 3]
      assert.deepEqual (unshift A, 0), [0, 1, 2, 3]

    test "cat", -> assert.deepEqual (cat [1..5], [6..10]), [1..10]

    test "slice", ->
      assert.deepEqual (slice  1,  2, [1..5]), [2]
      assert.deepEqual (slice  2,  5, [1..5]), [3,4,5]
      assert.deepEqual (slice  1, -2, [1..5]), [2,3]
      assert.deepEqual (slice -3, -1, [1..5]), [3,4]
      assert.deepEqual (slice -3, -1, "0123456789"), "78"

    test "splice", ->
      A = [1, 2, 3, 4, 5]
      assert.deepEqual (splice 0, 0, A), [1, 2, 3, 4, 5]
      assert.deepEqual (splice 0, 1, A), [2, 3, 4, 5]
      assert.deepEqual (splice 2, 2, A), [2, 3]
      assert.deepEqual A, [2, 3]

    test "insert", ->
      assert.deepEqual (insert 1, 3, [4,2,1]), [4,3,2,1]
      assert.deepEqual (insert -1, 3, [1,2,4]), [1..4]
      assert.deepEqual (insert 0, 1, [2..4]), [1..4]

    test "remove", ->
      assert.deepEqual (remove 3, [1..5]), [1,2,4,5]
      assert.deepEqual (remove 6, [1..5]), [1..5]

    test "range", ->
      assert.deepEqual (range 1, 5), [1..5]
      assert.deepEqual (range 5, 1), [5..1]

    test "join", ->
      A = ["water", "earth", "fire", "air"]
      assert (join A, "-") == "water-earth-fire-air"

    test "fill", ->
      A = [1, 2, 3, 4]
      assert.deepEqual (fill A, 2), [2, 2, 2, 2]
      assert.deepEqual (fill A, 5), [5, 5, 5, 5]

    test "pluck", ->
      A = [1, 2, 3, 4, 5]
      assert (pluck A) in A
      assert A.length == 5

    test "pair", -> assert.deepEqual (pair 1, 2), [1, 2]

    test "shuffle", ->

      A = [1, 2, 3, 4, 5]
      B = shuffle A

      assert A.length == B.length

      for value in A
        assert value in B

      assert.notDeepEqual A, B

  ]
