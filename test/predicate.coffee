import assert from "assert"
import sinon from "sinon"
import {print, test, success} from "amen"

import * as _f from "../src/function"

# module under text
import * as $ from "../src/predicate"

T = _f.wrap true
F = _f.wrap false

promised =
  T: _f.wrap Promise.resolve true
  F: _f.wrap Promise.resolve false

export default ->

  print await test "predicates", [

    test "negate", [
        test "sync", ->
          assert.equal true, do $.negate F
          assert.equal false, do $.negate T

        test "async", ->
          assert.equal true, await do $.negate promised.F
          assert.equal false, await do $.negate promised.T

      ]

    test "any", [

      test "sync", ->
        assert.equal true, do $.any [ T, F ]
        assert.equal true, do $.any [ F, T ]
        assert.equal false, do $.any [ F, F ]

      test "async", ->
        assert.equal true, await do $.any [ promised.T, promised.F ]
        assert.equal true, await do $.any [ promised.F, promised.T ]
        assert.equal false, await do $.any [ promised.F, promised.F ]

    ]

    test "all", [

      test "sync", ->
        assert.equal false, do $.all [ T, F ]
        assert.equal false, do $.all [ F, T ]
        assert.equal true, do $.all [ T, T ]

      test "async", ->
        assert.equal false, await do $.all [ promised.T, promised.F ]
        assert.equal false, await do $.all [ promised.F, promised.T ]
        assert.equal true, await do $.all [ promised.T, promised.T ]

    ]

    test "test", [

      test "sync", ->
        f = sinon.fake.returns false
        t = sinon.fake.returns true
        assert.equal true, do $.test T, f
        assert.equal false, do $.test F, t
        assert.equal true, f.called
        assert.equal true, t.notCalled

      test "async", ->
        f = sinon.fake.returns false
        t = sinon.fake.returns true
        assert.equal true, await do $.test promised.T, f
        assert.equal false, await do $.test promised.F, t
        assert.equal true, f.called
        assert.equal true, t.notCalled

    ]

    test "branch", [

      test "sync", ->
        f = sinon.fake.returns false
        t = sinon.fake.returns true
        assert.equal true, do $.branch [[T, f], [F, t]]
        assert.equal true, do $.branch [[F, t], [T, f]]
        assert.equal false, do $.branch [[F, t], [F, f]]
        assert.equal 2, f.callCount
        assert.equal true, t.notCalled


      test "async", ->
        f = sinon.fake.returns false
        t = sinon.fake.returns true
        assert.equal true, await do $.branch [[promised.T, f], [promised.F, t]]
        assert.equal true, await do $.branch [[promised.F, t], [promised.T, f]]
        assert.equal false, await do $.branch [[promised.F, t], [promised.F, f]]
        assert.equal 2, f.callCount
        assert.equal true, t.notCalled

    ]

    test "attempt", [

      test "sync", ->
        f = sinon.fake.throws()
        assert.equal true, do $.attempt [ f, T ]
        assert.equal false, do $.attempt [ f, f ]
        assert.equal 3, f.callCount

      test "async", ->
        f = sinon.fake.rejects()
        assert.equal true, await do $.attempt [ f, promised.T ]
        assert.equal false, await do $.attempt [ f, f ]
        assert.equal 3, f.callCount

    ]
  ]
