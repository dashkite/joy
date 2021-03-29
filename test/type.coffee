import assert from "assert"
import {test, print} from "amen"

import {
  prototype
  isType
  isKind
  isBoolean
  isNumber
  isNaN
  isFinite
  isInteger
  isString
  isBuffer
  isFunction
  isObject
  isArray
  isRegExp
  isDate
  isDefined
  isGeneratorFunction
  isPromise
  isAsyncFunction
  Type
  instanceOf
  areType
  areKind
} from "../src/type"

do ->

  print await test "type", [

    test "prototype", [

      # isType and isKind relies on prototype

      test "isKind", ->
        A = class
        B = class extends A
        b = new B
        assert isKind B, b
        b2 = Object.create b
        assert isKind B, b2
        assert !isKind B, {}
        assert !isKind b, B

      test "isType", [

        # these are all defined using isType

        test "isNumber", ->
          assert isNumber 7
          assert ! isNumber "7"
          assert ! isNumber false
          assert isNumber.length == 1

        test "isBoolean", ->
          assert isBoolean true
          assert !isBoolean 7

        test "isDate", ->
          assert isDate (new Date)
          assert !isDate 7

        test "isRegExp", ->
          assert isRegExp /\s/
          assert !isRegExp 7

        test "isString", ->
          assert isString "x"
          assert !isString 7

        test "isBuffer", ->
          assert isBuffer (Buffer.from "hello")

        test "isFunction", ->
          assert isFunction ->
          assert !isFunction 7
          assert isFunction.length == 1

        test "isObject", ->
          assert isObject {}
          assert !isObject 7

        test "isArray", ->
          assert isArray []
          assert !isArray 7

        test "isNaN", ->
          assert isNaN NaN
          assert ! isNaN 0
          assert ! isNaN "foobar"

        test "isFinite", ->
          assert isFinite 0
          assert isFinite 2e64

          assert ! isFinite "0"
          assert ! isFinite null
          assert ! isFinite Infinity
          assert ! isFinite NaN
          assert ! isFinite -Infinity

        test "isInteger", ->
          assert isInteger 5
          assert ! isInteger 3.5
          assert ! isInteger "5"
          assert ! isInteger NaN

        test "isDefined", ->
          assert isDefined {}
          assert !isDefined undefined

        test "isGeneratorFunction", ->
          f = -> yield true
          assert isGeneratorFunction f

        test "isAsyncFunction", ->
          f = -> await true
          assert isAsyncFunction f
      ]

    test "Type", do ->

      A = Type.define()
      B = Type.define A
      b = Type.create B
      [
        test "isType", ->
          assert isType B, b

        test "areType", ->
          check = areType String
          assert check ["1", "2", "3"]
          assert ! check "1"
          assert ! check ["1", 2, "3"]
          assert ! check [1, 2, 3]

        test "isKind", ->
          assert isKind A, b

        test "areKind", ->
          check = areKind A
          assert check [b, b, b]
          assert ! check b
          assert ! check [b, 2, b]
          assert ! check [1, 2, 3]
      ]

  ]
]
