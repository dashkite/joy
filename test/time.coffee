import assert from "assert"
import {test, print} from "amen"

import * as _ from "../src/time"

import { performance } from "perf_hooks"

export default ->

  print await test "time helpers", [

    test "timer", [

      test "set", ->
        new Promise (y, n) ->
          _.timer 100, y
          setTimeout n, 200

      test "cancel", ->
        new Promise (y, n) ->
          cancel = _.timer 100, n
          cancel()
          setTimeout y, 200

    ]

    test "sleep", ->

      new Promise (y, n) ->
        setTimeout n, 200
        await _.sleep 100
        y()

    test "benchmark", ->
      # this can vary quite widely depending on the
      # number of other tests running
      assert 500 > (await _.benchmark -> _.sleep 100)

    test "milliseconds", ->
      assert.equal Number, _.milliseconds().constructor

  ]
