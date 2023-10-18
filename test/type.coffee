import assert from "@dashkite/assert"
import { test, success } from "@dashkite/amen"
import print from "@dashkite/amen-console"

# module under test
import * as $ from "../src/type"

export default ->

  print await test "type", [


    test "type checking", do ->

      class A
      class B extends A
      b1 = new B
      b2 = Object.create b1

      [ C, D ] = eval """
        (function() {
          class A {}
          class B extends A {}
          return [ A, B ]
        })()
        """

      [

        test "isType", ->
          assert $.isType B, b1
          assert ! $.isType B, b2
          assert ! $.isType b1, b2
          assert ! $.isType A, b1
          assert ! $.isType b1, B
          assert ! $.isType C, b1
          assert ! $.isType D, b1

        test "isSynonymousType", ->
          assert $.isSynonymousType B, b1
          assert $.isSynonymousType B, b2
          assert ! $.isSynonymousType A, b1
          assert ! $.isSynonymousType b1, B
          assert $.isSynonymousType D, b1


        test "isKind", ->
          assert $.isKind B, b1
          assert $.isKind A, b1
          assert ! $.isKind B, {}
          assert $.isKind B, b2
          assert $.isKind A, b2

        test "isSynonymousKind", ->
          assert $.isSynonymousKind B, b1
          assert $.isSynonymousKind A, b1
          assert ! $.isSynonymousKind B, {}
          assert $.isSynonymousKind B, b2
          assert $.isSynonymousKind A, b2
          assert $.isSynonymousKind C, b1
          assert $.isSynonymousKind D, b1

      ]

    test "common types", [

      test "isNumber", ->
        assert $.isNumber 7
        assert ! $.isNumber "7"
        assert ! $.isNumber false
        assert $.isNumber.length == 1

      test "isBoolean", ->
        assert $.isBoolean true
        assert !$.isBoolean 7

      test "isDate", ->
        assert $.isDate (new Date)
        assert !$.isDate 7

      test "isRegExp", ->
        assert $.isRegExp /\s/
        assert !$.isRegExp 7

      test "isString", ->
        assert $.isString "x"
        assert !$.isString 7

      test "isBuffer", ->
        assert $.isBuffer (Buffer.from "hello")

      test "isFunction", ->
        assert $.isFunction ->
        assert !$.isFunction 7
        assert $.isFunction.length == 1

      test "isObject", ->
        assert $.isObject {}
        assert !$.isObject 7

      test "isArray", ->
        assert $.isArray []
        assert !$.isArray 7

      test "isNaN", ->
        assert $.isNaN NaN
        assert ! $.isNaN 0
        assert ! $.isNaN "foobar"

      test "isFinite", ->
        assert $.isFinite 0
        assert $.isFinite 2e64

        assert ! $.isFinite "0"
        assert ! $.isFinite null
        assert ! $.isFinite Infinity
        assert ! $.isFinite NaN
        assert ! $.isFinite -Infinity

      test "isInteger", ->
        assert $.isInteger 5
        assert ! $.isInteger 3.5
        assert ! $.isInteger "5"
        assert ! $.isInteger NaN

      test "isDefined", ->
        assert $.isDefined {}
        assert !$.isDefined undefined

      test "isGeneratorFunction", ->
        f = -> yield true
        assert $.isGeneratorFunction f

      test "isAsyncFunction", ->
        f = -> await true
        assert $.isAsyncFunction f

    ]

    test "Type", do ->

      A = $.Type.define()
      B = $.Type.define A
      b = $.Type.create B

      [

        test "isType", ->
          assert $.isType B, b

        test "isKind", ->
          assert $.isKind A, b

      ]
  ]
