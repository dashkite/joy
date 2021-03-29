# Joy API Reference


**Function**

[identity](#identity) | [wrap](#wrap) | [unary](#unary) | [binary](#binary) | [ternary](#ternary) | [arity](#arity) | [curry](#curry) | [substitute](#substitute) | [partial](#partial) | [flip](#flip) | [tee](#tee) | [rtee](#rtee) | [wait](#wait) | [pipe](#pipe) | [pipeWith](#pipeWith) | [compose](#compose) | [flow](#flow) | [flowWith](#flowWith) | [apply](#apply) | [call](#call) | [spread](#spread) | [stack](#stack) | [once](#once) | [memoize](#memoize)

**Predicate**

[negate](#negate) | [any](#any) | [all](#all) | [test](#test) | [branch](#branch) | [attempt](#attempt)

**Object**

[keys](#keys) | [values](#values) | [pairs](#pairs) | [has](#has) | [get](#get) | [set](#set) | [assign](#assign) | [merge](#merge) | [query](#query)


## Function

_@dashkite/joy/function_


### identity

_identity value &rarr; value_

Returns its argument.


### wrap

_wrap value &rarr; function_

Returns a function that returns its argument.


### unary

_unary function &rarr; function_

Returns a unary function that passes its argument to the given function.


### binary

_binary function &rarr; function_

Returns a binary function that passes its arguments to the given function.


### ternary

_ternary function &rarr; function_

Returns a ternary function that passes its arguments to the given function.


### arity

_arity n, function &rarr; function_

Returns an n-ary function that passes its arguments to the given function.


### curry

_curry function &rarr; function_

Returns a curryable function that passes its arguments to the given function.


### substitute

_substitute pattern, values &rarr; array_

Given a pattern array and an array of values, returns an array with the values substited for the special value \_ in the pattern array.


### partial

_partial function, pattern &rarr; function_

Returns a function that substitutes arguments using the given pattern array before passing them to the given function.


### flip

_flip function &rarr; function_

Returns a function that reverses its arguments before passing them to the given function.


### tee

_tee function &rarr; function_

Returns a function that calls the given function but always returns its first argument.


### rtee

_rtee function &rarr; function_

Returns a function that calls the given function but always returns its last argument.


### wait

_wait function &rarr; function_

Returns a function that awaits on its arguments before passing it to the given function.


### pipe

_pipe functions &rarr; function_

Returns a function that composes the given functions, calling them in the order given.


### pipeWith

_pipeWith adapter, functions &rarr; function_

Works like [`pipe`](#pipe), except transforms each function with the given adaper before composing them.

#### Example

```coffeescript
trace = (f) ->
  (args...) ->
    console.log "function:", f.name
    console.log "-- arguments:", args
    console.log "-- returns:", r = f args...
    r

pipeWith trace, [
  # functions to trace...
]
```

### compose

_compose functions &rarr; function_

Returns a function that composes the given functions, calling them in reverse of the order given.


### flow

_flow functions &rarr; function_

Returns an async function that composes the given functions, which may be async, calling them in the order given.
Convenience for `pipeWith wait`.


### flowWith

_flowWith adapter, functions &rarr; function_

Works like [`flow`](#flow), except transforms each function with the given adaper before composing them.


### apply

_apply function, arguments &rarr; value_

Calls the given function with the given arguments. Convenience for [`Function::apply`][mdn], except without a `this` argument. (Compose with [`bind`](#bind) to bind `this`.)
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/apply


### call

_call function, arguments... &rarr; value_

Calls the given function with the given arguments. Convenience for [`Function::call`][mdn], except without a `this` argument. (Compose with [`bind`](#bind) to bind `this`.)
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/apply


### spread

_spread function &rarr; function_

Returns a function that accepts an array of arguments and passes them to the given function.


### stack

_stack function &rarr; function_

Returns a function that passes its arguments to the given function as an array.


### once

_once function &rarr; function_

Returns a function that calls the given function once. Subsequent invocations will simply return the value returned by the initial invocation.


### memoize

_memoize function &rarr; function_

Returns a function that calls the given function once for a given set arguments. Subsequent invocations with the same arguments will simply return the value returned by the initial invocation. The arguments must be serializable with `toString`.



## Predicate

_@dashkite/joy/predicate_


### negate

_negate function &rarr; function_

Returns a function that returns the negation of the given function.


### any

_any functions &rarr; function_

Returns a function that returns true if any of the given _functions_, attempted in the order given, returns true, and false otherwise.


### all

_all functions &rarr; function_

Returns a function that returns true if all of the given _functions_, attempted in the order given, return true, and false otherwise.


### test

_test predicate, consequent[, alternative] &rarr; function_

Returns a function that calls the _consequent_ if the _predicate_ returns true, and the (optional) _alternative_ otherwise.


### branch

_branch conditions &rarr; function_

Returns a function evaluates a list of _conditions_ (and associative array consisting of pairs of predicates and consequents), in the order given, until one of the predicates matches. Calls the corresponding consquent if a match is found.


### attempt

_attempt function &rarr; function_

Returns a function that calls the given function, returning false if the function throws an exception or returns a rejected promise, and true otherwise.



## Object

_@dashkite/joy/object_


### keys

_keys object &rarr; array_

Returns the property names for the given object.


### values

_values object &rarr; array_

Returns the property values for the given object.


### pairs

_pairs object &rarr; array_

Returns the properties for the given object as an associative array (an array of two-element arrays).

#### Example

```coffeescript
assert.deepEqual (x.pairs {a: 1, b: 2, c: 3}),
  [["a", 1], ["b", 2], ["c", 3]]

```

### has

_has key, object &rarr; boolean_

Returns the true if the given object has a property matching the given key, false otherwise.


### get

_get key, object &rarr; boolean_

Returns the value of the property matching the given key for the given object. Like most Joy functions, `get` is curryable, so `get` can be used like Ramda's [`pluck`][ramda].
[ramda]: https://ramdajs.com/docs/#pluck


### set

_set key, value, object &rarr; boolean_

Sets the value of the property matching the given key for the given object.


### assign

_assign object, objects... &rarr; object_

Adds the properties for _objects_ to _object_. Modifies _object_. If you want to create a new object, use [`merge`](#merge).


### merge

_merge object, objects... &rarr; object_

Adds the properties for _objects_ to _object_. Modifies _object_. If you want to create a new object, use [`merge`](#merge).


### query

_query exemplar, object &rarr; object_

Returns true if _object_ matches _exemplar_, false otherwise. An exemplar matches if all of its properties are equal to the corresponding properties in the target object. Matching is done recursively, so the exemplar can contain nested values.

#### Example

```coffeescript
assert.equal true, x.query { x: {y: 2 }}, { x: { y: 2}}
assert.equal false, x.query { x: {y: 2 }}, { x: { y: 1}}

```

