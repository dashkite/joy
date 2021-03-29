# Joy API Reference


**Function**

[identity](#identity) | [wrap](#wrap) | [unary](#unary) | [binary](#binary) | [ternary](#ternary) | [arity](#arity) | [curry](#curry) | [substitute](#substitute) | [partial](#partial) | [flip](#flip) | [tee](#tee) | [rtee](#rtee) | [wait](#wait) | [pipe](#pipe) | [pipeWith](#pipeWith) | [compose](#compose) | [flow](#flow) | [flowWith](#flowWith) | [apply](#apply) | [call](#call) | [spread](#spread) | [stack](#stack) | [once](#once) | [memoize](#memoize)

**Predicate**

[negate](#negate) | [any](#any) | [all](#all) | [test](#test) | [branch](#branch) | [attempt](#attempt)

**Object**

[keys](#keys) | [values](#values) | [pairs](#pairs) | [has](#has) | [get](#get) | [set](#set) | [assign](#assign) | [merge](#merge) | [query](#query)

**Metaclass**

[property](#property) | [properties](#properties) | [getter](#getter) | [getters](#getters) | [setter](#setter) | [setters](#setters) | [method](#method) | [methods](#methods) | [mixin](#mixin)

**Type**

[prototype](#prototype) | [isPrototype](#isPrototype) | [isTransitivePrototype](#isTransitivePrototype) | [isType](#isType) | [isKind](#isKind) | [Type.define](#Type.define) | [Type.create](#Type.create) | [instanceOf](#instanceOf) | [isDefined](#isDefined) | [isUndefined](#isUndefined) | [isBoolean](#isBoolean) | [isString](#isString) | [isSymbol](#isSymbol) | [isNumber](#isNumber) | [isNaN](#isNaN) | [isFinite](#isFinite) | [isInteger](#isInteger) | [isFloat](#isFloat) | [isDate](#isDate) | [isError](#isError) | [isRegExp](#isRegExp) | [isPromise](#isPromise) | [isObject](#isObject) | [isArray](#isArray) | [isMap](#isMap) | [isWeakMap](#isWeakMap) | [isSet](#isSet) | [isRegularFunction](#isRegularFunction) | [isGeneratorFunction](#isGeneratorFunction) | [isAsyncFunction](#isAsyncFunction) | [isFunction](#isFunction) | [size](#size) | [length](#length) | [isEmpty](#isEmpty) | [isBuffer](#isBuffer) | [isArrayBuffer](#isArrayBuffer) | [isDataView](#isDataView) | [isTypedArray](#isTypedArray) | [areType](#areType) | [areKind](#areKind)


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


## Metaclass

_@dashkite/joy/metaclass_


### property

_property key, description, target &rarr; object_

Defines a property on _target_ using the given _key_ (the property name) and _description_. Convenience for [`Object.defineProperty`][mdn]. Like most Joy functions, `property` is curryable, so you can define a function that will define a property on any object. Use in combination with [`mixin`](#mixin) to create reusable mixins.
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperty


### properties

_properties dictionary, target &rarr; object_

Defines properties on _target_ using the given _dictionary_ of keys and property names. Convenience wrapper for [`property`](#property). Like most Joy functions, `properties` is curryable, so you can define a function that will define a property on any object. Use in combination with [`mixin`](#mixin) to create reusable mixins.
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperty


### getter

_getter key, function, target &rarr; object_

Defines a getter on _target_ using the given _key_ (the property name) and _description_. Convenience for [`Object.defineProperty`][mdn]. Like most Joy functions, `getter` is curryable, so you can define a function that will define a property on any object. Use in combination with [`mixin`](#mixin) to create reusable mixins.
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperty


### getters

_getters dictionary, target &rarr; object_

Defines getters on _target_ using the given _dictionary_ of keys and getter functions. Convenience wrapper for [`getter`](#getter). Like most Joy functions, `getters` is curryable, so you can define a function that will define a property on any object. Use in combination with [`mixin`](#mixin) to create reusable mixins.
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperty

#### Example

```coffeescript
class Foo
  mixin @::, [
    getters
      bar: -> "bar"
  ]
assert.equal "bar", (new Foo).bar

```

### setter

_setter key, function, target &rarr; object_

Defines a setter on _target_ using the given _key_ (the property name) and _description_. Convenience for [`Object.defineProperty`][mdn]. Like most Joy functions, `setter` is curryable, so you can define a function that will define a property on any object. Use in combination with [`mixin`](#mixin) to create reusable mixins.
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperty


### setters

_setters dictionary, target &rarr; object_

Defines setters on _target_ using the given _dictionary_ of keys and setter functions. Convenience wrapper for [`setter`](#setter). Like most Joy functions, `setters` is curryable, so you can define a function that will define a property on any object. Use in combination with [`mixin`](#mixin) to create reusable mixins.
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperty


### method

_method key, function, target &rarr; object_

Defines a method on _target_ using the given _key_ (the property name) and _description_. Convenience for [`Object.defineProperty`][mdn]. Like most Joy functions, `method` is curryable, so you can define a function that will define a property on any object. Use in combination with [`mixin`](#mixin) to create reusable mixins.
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperty


### methods

_methods dictionary, target &rarr; object_

Defines methods on _target_ using the given _dictionary_ of keys and methods. Convenience wrapper for [`method`](#method). Like most Joy functions, `methods` is curryable, so you can define a function that will define a property on any object. Use in combination with [`mixin`](#mixin) to create reusable mixins.
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperty


### mixin

_mixin target, functions &rarr; object_

Applies each function to the given target. See [`getters`](#getters) for an example of how to use it with object modifiers like `getters` or `methods` to create reusable mixins.



## Type

_@dashkite/joy/type_


### prototype

_prototype value &rarr; prototype_

Returns the prototype of the given _value_.


### isPrototype

_isPrototype prototype, value &rarr; boolean_

Returns true if _prototype_ is the prototype for _value_, false otherwise.


### isTransitivePrototype

_isTransitivePrototype prototype, value &rarr; boolean_

Returns true if _prototype_ is a transitive prototype of _value_, false otherwise.


### isType

_isType type, value &rarr; boolean_

Returns true if _value_ is an instance of _type_, false otherwise.


### isKind

_isKind type, value &rarr; boolean_

Returns true if _value_ is an instance of _type_ or one of its descendents (as defined by the prototype chain for _value_), false otherwise.


### Type.define

_Type.define parent &rarr; class_

Creates a new type (class) that extends _parent_, if defined, or `Object` otherwise. Convenience wrapper for `class`.


### Type.create

_Type.create type &rarr; instance_

Creates a new instance of a type (class). Convenience wrapper for `new`.


### instanceOf

_instanceOf type, instance &rarr; boolean_

Returns true if `instanceof` returns true for the given instance and type, false otherwise. Convenience wrapper for `instanceof`. However, [`isKind`](#isKind) is less likely to throw.


### isDefined

_isDefined value &rarr; boolean_

Returns true if _value_ is defined, false otherwise.


### isUndefined

_isUndefined  &rarr; _




### isBoolean

_isBoolean  &rarr; _




### isString

_isString  &rarr; _




### isSymbol

_isSymbol  &rarr; _




### isNumber

_isNumber  &rarr; _




### isNaN

_isNaN  &rarr; _




### isFinite

_isFinite  &rarr; _




### isInteger

_isInteger  &rarr; _




### isFloat

_isFloat  &rarr; _




### isDate

_isDate  &rarr; _




### isError

_isError  &rarr; _




### isRegExp

_isRegExp  &rarr; _




### isPromise

_isPromise  &rarr; _




### isObject

_isObject  &rarr; _




### isArray

_isArray  &rarr; _




### isMap

_isMap  &rarr; _




### isWeakMap

_isWeakMap  &rarr; _




### isSet

_isSet  &rarr; _




### isRegularFunction

_isRegularFunction  &rarr; _




### isGeneratorFunction

_isGeneratorFunction  &rarr; _




### isAsyncFunction

_isAsyncFunction  &rarr; _




### isFunction

_isFunction  &rarr; _




### size

_size  &rarr; _




### length

_length  &rarr; _




### isEmpty

_isEmpty  &rarr; _




### isBuffer

_isBuffer  &rarr; _




### isArrayBuffer

_isArrayBuffer  &rarr; _




### isDataView

_isDataView  &rarr; _




### isTypedArray

_isTypedArray  &rarr; _




### areType

_areType  &rarr; _




### areKind

_areKind  &rarr; _




