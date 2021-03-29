import assert from "assert"
import {test, print} from "amen"

import {get} from "../src/object"

import {promise, resolve, reject, all, any, race, map} from "../src/promise"

do -> print await test "promise", [

  test "promise", ->
    assert.equal true, (promise ->).then?

  test "resolve", ->
    assert.equal true, await resolve true

  test "reject", ->
    assert.rejects -> reject false

  test "all", ->
    assert.deepEqual [ true, true ],
      await all [
        resolve true
        resolve true
      ]

    assert.rejects ->
      await all [
        resolve true
        reject false
      ]

  test "any", ->
    assert.equal true,
      await any [
        resolve true
        reject false
      ]

    assert.rejects ->
      await any [
        reject false
        reject false
      ]

  test "race", ->
    assert.equal true,
      await race [
        resolve true
        reject false
      ]

  test "map", ->
    assert.deepEqual [ true, undefined ],
      (await map [
        resolve true
        reject false
      ]).map get "value"
]
