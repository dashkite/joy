import assert from "@dashkite/assert"
import { test, success } from "@dashkite/amen"
import print from "@dashkite/amen-console"

import * as _ from "../src/time"

import { performance } from "perf_hooks"

export default ->

  print await test "time helpers", [

    test "timer", [

      await test "set", ->
        new Promise (y, n) ->
          _.timer 100, y
          setTimeout n, 200

      await test "cancel", ->
        new Promise (y, n) ->
          cancel = _.timer 100, n
          cancel()
          setTimeout y, 200

    ]

    await test "sleep", ->

      new Promise (y, n) ->
        setTimeout n, 200
        await _.sleep 100
        y()

    await test "benchmark", ->
      # this can vary quite widely depending on the
      # number of other tests running
      assert 500 > (await _.benchmark -> _.sleep 100)

    test "milliseconds", ->
      assert.equal Number, _.milliseconds().constructor

    await test "debounce", ->
      count = 0
      inc = _.debounce 10, -> count++
      inc()
      inc()
      await _.sleep 11
      inc()
      assert.equal 2, count

    await test "expect", ->
      flag = false
      do ->
        start = Date.now()
        await _.sleep 1
        flag = true
      assert await _.expect timeout: 50, -> flag == true

  ]
