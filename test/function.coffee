import assert from "@dashkite/assert"
import { test, success } from "@dashkite/amen"
import print from "@dashkite/amen-console"

# module under text
import * as _ from "../src/function"

export default ->

  print await test "function", [

    test "identity", -> assert.equal 7, _.identity 7
    test "wrap", -> assert.equal 7, (_.wrap 7)()

    test "unary", -> assert.equal 1, (_.unary ->).length
    test "binary", -> assert.equal 2, (_.binary ->).length
    test "ternary", -> assert.equal 3, (_.ternary ->).length
    test "arity", -> assert.equal 4, (_.arity 4, ->).length

    test "curry", -> assert.equal 3, (_.curry (x,y) -> x + y)(1)(2)

    test "curry method", ->
      class A
        foo: _.curry (a, b, c) -> a + b + c

      a = new A
      f = a.foo 1
      assert.equal 6, f 2, 3

    test "substitute", -> assert.equal 2, (_.substitute [1, _._, 3], [2])[1]
    test "partial", -> assert.equal 9, (_.partial Math.pow, [ _._, 2 ])(3)

    test "flip", -> assert.equal 9, (_.curry _.flip Math.pow)(2)(3)

    test "tee", [

      test "sync", ->

        count = 0
        f = _.tee (x) -> count++

        assert.equal 7, f 7
        assert.equal 1, count

      test "async", ->

        count = 0
        f = _.tee (x) -> Promise.resolve count++

        assert.equal 7, await f 7
        assert.equal 1, count

      test "method", ->

        class A
          constructor: -> @count = 0
          foo: _.tee (x) -> @count++
        a = new A
        assert.equal 7, await a.foo 7
        assert.equal 1, a.count

    ]

    test "rtee", [

      test "sync", ->

        count = 0
        f = _.rtee (x, y) -> count++

        assert.equal 7, f 0, 7
        assert.equal 1, count

      test "async", ->

        count = 0
        f = _.rtee (x, y) -> Promise.resolve count++

        assert.equal 7, await f 0, 7
        assert.equal 1, count

      test "method", ->

        class A
          constructor: -> @count = 0
          foo: _.rtee (x, y) -> @count++
        a = new A
        assert.equal 7, await a.foo 0, 7
        assert.equal 1, a.count

    ]

    test "wait", ->
      assert.equal 4, await ((_.wait _.identity)(Promise.resolve 4))

    test "pipe", ->
      a = (x) -> x + "a"
      b = (x) -> x + "b"
      c = (x) -> x + "c"
      f = _.pipe [ a, b, c ]
      assert.equal 1, f.length
      assert.equal "Sabc", f "S"

    test "compose", ->
      a = (x) -> x + "a"
      b = (x) -> x + "b"
      c = (x) -> x + "c"
      f = _.compose [ c, b, a ]
      assert.equal 1, f.length
      assert.equal "Sabc", f "S"

    test "flow", ->
      a = (x) -> Promise.resolve x + "a"
      b = (x) -> Promise.resolve x + "b"
      c = (x) -> Promise.resolve x + "c"
      f = _.flow [ a, b, c ]
      assert.equal 1, f.length
      assert.equal "Sabc", await f "S"

    test "flowWith", ->
      r = []
      log = (f) -> (args...) -> r.push args; f args...
      a = (x) -> Promise.resolve x + "a"
      b = (x) -> Promise.resolve x + "b"
      c = (x) -> Promise.resolve x + "c"
      f = _.flowWith log, [ a, b, c ]
      assert.equal 1, f.length
      assert.equal "Sabc", await f "S"
      assert.deepEqual r, [
        [ "S" ]
        [ "Sa" ]
        [ "Sab" ]
      ]

    test "spread", ->
      assert.equal "ab", (_.spread (a, b) -> a + b)(["a", "b"])

    test "once", ->
      count = 0
      f = _.once -> count++
      f()
      f()
      assert.equal 1, count

    test "memoize", ->
      count = 0
      f = _.memoize (x, y) -> ++count
      assert.equal 1, f 1, 1
      assert.equal 1, f 1, 1
      assert.equal 2, f 1, 2
      assert.equal 3, f 2, 1
      assert.equal 2, f 1, 2
      assert.equal 3, f 2, 1

    test "apply", ->
      assert.equal 1, (_.apply _.identity, [1])

    test "bind", -> assert (_.bind (-> @x), {x: 1})() == 1

    test "detach", ->
      shift = _.detach Array::shift
      replace = _.detach String::replace
      assert.equal 1, shift [1..5]
      assert.equal 3, replace.length
      f = replace "cat"
      assert.equal 2, f.length
      assert.equal "dog", f "cat", "dog"

    test "send", ->
      class Foo
        bar: (t) -> "foo#{t}"
      f = _.send "bar", [ "baz" ]
      foo = new Foo
      assert.equal "foobaz", f foo

    test "chain", [

      test "sync", ->

        class A
          foo: _.chain (x) -> @x = x
        a = new A
        assert.equal a, a.foo 0
        assert.equal 0, a.x

      test "async", ->

        class A
          foo: _.chain (x) -> Promise.resolve @x = x
        a = new A
        assert.equal a, await a.foo 0
        assert.equal 0, a.x

    ]

    test "proxy", ->

      class A
        foo: (a, b, c) -> a + b + c
        bar: _.proxy "foo", [ 1 ]

      a = new A
      assert.equal 6, a.bar 2, 3

  ]
