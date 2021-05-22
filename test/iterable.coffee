import assert from "assert/strict"
import { test, print } from "amen"
import sinon from "sinon"
import EventEmitter from "events"

import { add, square, odd } from "../src/math"
# under test
import * as _ from "../src/iterable"

reagent = (it) -> yield x for await x from it
promise = (x) -> Promise.resolve x

export default ->

  print await test "iterable", [

    test "includes", ->
      assert (_.includes 3, [1..5]) && !(_.includes 6, [1..5])
      assert.throws -> _.includes [1..5], 3

    test "uniqueBy", ->
      even = (x) -> x % 2 == 0
      assert.deepEqual (_.uniqueBy even, [1..5]), [1,3,5]


    test "map", [

      test "iterator", ->
        assert.deepEqual [ 1, 4, 9 ],
          Array.from _.map square, new Set [1..3]

      test "reagent", ->
        assert.deepEqual [ 1, 4, 9 ],
          await _.collect _.map square, reagent [1..3]

      test "array specialization", ->
        assert.deepEqual [ 1, 4, 9 ],
          Array.from _.map square, [1..3]

    ]

    test "resolve", ->
      assert.deepEqual [1..3],
        await _.collect _.map ((x) -> x++), ((_.resolve _.map promise) [1..3])

    test "tap", do ({f} = {}) ->

      [

        test "iterator", ->
          f = sinon.fake.returns -1
          assert.deepEqual [ 1..5 ],
            Array.from _.tap f, new Set [1..5]
          assert.equal 5, f.callCount

        test "reagent", ->
          f = sinon.fake.returns -1
          assert.deepEqual [ 1..5 ],
            await _.collect _.tap f, reagent [1..5]
          assert.equal 5, f.callCount

      ]

    test "select", [

      test "iterator", ->
        assert.deepEqual [ 1, 3, 5 ],
          Array.from _.select odd, new Set [1..5]

      test "reagent", ->
        assert.deepEqual [ 1, 3, 5 ],
          await _.collect _.select odd, reagent [1..5]

      test "array specialization", ->
        assert.deepEqual [ 1, 3, 5 ],
          Array.from _.select odd, [1..5]

    ]

    test "each", do ({f} = {}) ->

      [

        test "iterator", ->
          f = sinon.fake.returns -1
          assert.equal undefined, _.each f, new Set [1..3]
          assert.equal 3, f.callCount

        test "reagent", ->
          f = sinon.fake.returns -1
          assert.equal undefined,
            await _.each f, reagent [ 1..3 ]
          assert.equal 3, f.callCount

        test "array specialization", ->
          f = sinon.fake.returns -1
          assert.equal undefined, _.each f, [ 1..3 ]
          assert.equal 3, f.callCount

      ]

    test "reduce", [

      test "iterator", ->
        assert.equal 15, _.reduce add, 0, new Set [1..5]

      test "reagent", ->
        assert.equal 15, await _.reduce add, 0, reagent [ 1..5 ]

      test "array specialization", ->
        assert.equal 15, _.reduce add, 0, [ 1..5 ]

    ]

    test "join", [

      test "iterator", ->
        assert.equal "water-earth-fire-air",
          _.join ((r, x) -> r + "-" + x),
            new Set [ "water", "earth", "fire", "air" ]

      test "reagent", ->
        assert.equal "water-earth-fire-air",
          await _.join ((r, x) -> r + "-" + x),
            reagent [ "water", "earth", "fire", "air" ]


      test "iterator/string specialization", ->
        assert.equal "water-earth-fire-air",
          _.join "-", new Set [ "water", "earth", "fire", "air" ]

      test "reagent/string specialization", ->
        assert.equal "water-earth-fire-air",
          await _.join "-", reagent [ "water", "earth", "fire", "air" ]

      test "array/string specialization", ->
          assert.equal "water-earth-fire-air",
            _.join "-", [ "water", "earth", "fire", "air" ]

    ]

    test "events", ->
      source = new EventEmitter
      for i in [ 1..5 ]
        do (i) -> queueMicrotask -> source.emit "test", i
      assert.deepEqual [ 1..5 ],
        await _.collect do ->
          for await j from _.events "test", source
            yield j
            break if j == 5

  ]
