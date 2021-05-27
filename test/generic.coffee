import assert from "assert"
import {test, print, success} from "amen"

import {
  isType
  isKind
  isFunction
  isString
  isNumber
} from "../src/type"

import {
  eq
  gte
  lte
} from "../src/math"

import { Generic, generic } from "../src/generic"

export default ->

  print await test "Generics", [

    test "Fibonacci function", do ->

      fib = generic
        name: "fib"
        description: "Fibonacci sequence"

      generic fib, (gte 1), (n) -> (fib n - 1) + (fib n - 2)
      generic fib, (eq 1), -> 1
      generic fib, (eq 2), -> 1

      [

        test "matches simple predicates", ->
          assert (fib 5) == 5

        test "throws with name/arguments on type error", ->
          assert.throws (-> fib 0),
            message: "fib: invalid arguments."
            arguments: [ 0 ]

      ]

    test "Polymorphic dispatch", ->

      class A
      class B extends A

      a = new A
      b = new B

      foo = generic()
      generic foo, (isKind A), -> "foo: A"
      generic foo, (isType B), -> "foo: B"
      generic foo, (isKind A), (isKind B), -> "foo: A + B"
      generic foo, (isKind B), (isKind A), -> "foo: B + A"
      generic foo, (eq a), (eq b), -> "foo: a + b"

      assert (foo b) == "foo: B"
      assert (foo a, b) == "foo: a + b"
      assert (foo b, a) == "foo: B + A"
      assert.throws ->
        foo b, a, b

    test "Variadic arguments", ->

      bar = generic()
      generic bar, String, (-> true), (x, a...) -> a[0]
      generic bar, Number, (-> true), (x, a...) -> x

      assert (bar "foo", 1, 2, 3) == 1

    test "Predicate functions", ->

      baz = generic()
      generic baz, ((x) -> x != 7), -> false
      generic baz, ((x) -> x == 7), (x) -> true

      assert (baz 7)
      assert !(baz 6)

    test "Generics are functions", ->
      assert isFunction generic()

    test "Lookups", ->

      foo = generic()

      generic foo, isNumber, (x) -> x + x
      generic foo, isString, (x) -> false

      f = Generic.lookup foo, [ 7 ]
      assert (f 7) == 14

  ]
