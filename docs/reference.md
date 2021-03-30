# Joy API Reference


**Function**

[identity](#identity) | [wrap](#wrap) | [unary](#unary) | [binary](#binary) | [ternary](#ternary) | [arity](#arity) | [curry](#curry) | [substitute](#substitute) | [partial](#partial) | [flip](#flip) | [tee](#tee) | [rtee](#rtee) | [wait](#wait) | [pipe](#pipe) | [pipeWith](#pipewith) | [compose](#compose) | [flow](#flow) | [flowWith](#flowwith) | [apply](#apply) | [call](#call) | [spread](#spread) | [stack](#stack) | [once](#once) | [memoize](#memoize)

**Predicate**

[negate](#negate) | [any](#any) | [all](#all) | [test](#test) | [branch](#branch) | [attempt](#attempt)

**Object**

[keys](#keys) | [values](#values) | [pairs](#pairs) | [has](#has) | [get](#get) | [set](#set) | [assign](#assign) | [merge](#merge) | [query](#query)

**Metaclass**

[property](#property) | [properties](#properties) | [getter](#getter) | [getters](#getters) | [setter](#setter) | [setters](#setters) | [method](#method) | [methods](#methods) | [mixin](#mixin)

**Type**

[prototype](#prototype) | [isPrototype](#isprototype) | [isTransitivePrototype](#istransitiveprototype) | [isType](#istype) | [isKind](#iskind) | [areType](#aretype) | [areKind](#arekind) | [Type.define](#type.define) | [Type.create](#type.create) | [instanceOf](#instanceof) | [isDefined](#isdefined) | [isUndefined](#isundefined) | [isBoolean](#isboolean) | [isString](#isstring) | [isSymbol](#issymbol) | [isNumber](#isnumber) | [isNaN](#isnan) | [isFinite](#isfinite) | [isInteger](#isinteger) | [isDate](#isdate) | [isError](#iserror) | [isRegExp](#isregexp) | [isPromise](#ispromise) | [isObject](#isobject) | [isArray](#isarray) | [isBuffer](#isbuffer) | [isArrayBuffer](#isarraybuffer) | [isDataView](#isdataview) | [isTypedArray](#istypedarray) | [isMap](#ismap) | [isWeakMap](#isweakmap) | [isSet](#isset) | [isRegularFunction](#isregularfunction) | [isGeneratorFunction](#isgeneratorfunction) | [isAsyncFunction](#isasyncfunction) | [isFunction](#isfunction)

**Value**

[equal](#equal) | [clone](#clone) | [size](#size) | [isEmpty](#isempty)

**Promise**

[promise](#promise) | [resolve](#resolve) | [reject](#reject) | [all](#all) | [any](#any) | [race](#race) | [map](#map)

**Text**

[toString](#tostring) | [toUpperCase](#touppercase) | [toLowerCase](#tolowercase) | [trim](#trim) | [split](#split) | [w](#w) | [isBlank](#isblank) | [match](#match) | [isMatch](#ismatch) | [replace](#replace)

**Array**

[first](#first) | [second](#second) | [third](#third) | [fourth](#fourth) | [fifth](#fifth) | [nth](#nth) | [last](#last) | [rest](#rest) | [includes](#includes) | [findIndexOf](#findindexof) | [findLastIndexOf](#findlastindexof) | [push/enqueue](#push/enqueue) | [pop/dequeue](#pop/dequeue) | [shift](#shift) | [unshift](#unshift) | [cat](#cat) | [slice](#slice) | [splice](#splice) | [uniqueBy](#uniqueby) | [unique](#unique) | [dupes](#dupes) | [union](#union) | [intersection](#intersection) | [difference](#difference) | [complement](#complement) | [insert](#insert) | [remove](#remove) | [range](#range) | [join](#join) | [fill](#fill) | [pluck](#pluck) | [pair](#pair) | [shuffle](#shuffle)

**Math**

[gt](#gt) | [lt](#lt) | [gte](#gte) | [lte](#lte) | [add](#add) | [sub](#sub) | [mul](#mul) | [div](#div) | [mod](#mod) | [even](#even) | [odd](#odd) | [min](#min) | [max](#max) | [abs](#abs)

**Time**

[timer](#timer) | [sleep](#sleep)


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


### areType

_areType type, values &rarr; boolean_

Returns true if each element in an array of _values_ is an instance of _type_, false otherwise.


### areKind

_areKind type, values &rarr; boolean_

Returns true if each element of in an array of _values_ is an instance of _type_ or one of its descendents (as defined by the prototype chain for _value_), false otherwise.


### Type.define

_Type.define parent &rarr; class_

Creates a new type (class) that extends _parent_, if defined, or `Object` otherwise. Convenience wrapper for `class`.


### Type.create

_Type.create type &rarr; instance_

Creates a new instance of a type (class). Convenience wrapper for `new`.


### instanceOf

_instanceOf type, instance &rarr; boolean_

Returns true if `instanceof` returns true for the given instance and type, false otherwise. Convenience wrapper for `instanceof`. However, [`isKind`](#iskind) is less likely to throw.


### isDefined

_isDefined value &rarr; boolean_

Returns true if _value_ is defined, false otherwise.


### isUndefined

_isUndefined value &rarr; boolean_

Returns true if _value_ is undefined, false otherwise.


### isBoolean

_isBoolean value &rarr; boolean_

Returns true if _value_ is an instance of `Boolean`.


### isString

_isString value &rarr; boolean_

Returns true if _value_ is an instance of `String`.


### isSymbol

_isSymbol value &rarr; boolean_

Returns true if _value_ is an instance of `Symbol`.


### isNumber

_isNumber value &rarr; boolean_

Returns true if _value_ is an instance of `Number`.


### isNaN

_isNaN value &rarr; boolean_

Returns true if _value_ is not a number. Equivalent to `Number.isNaN`.


### isFinite

_isFinite value &rarr; boolean_

Returns true if _value_ is fine. Equivalent to `Number.isFinite`.


### isInteger

_isInteger value &rarr; boolean_

Returns true if _value_ is fine. Equivalent to `Number.isInteger`.


### isDate

_isDate value &rarr; boolean_

Returns true if _value_ is an instance of `Date`.


### isError

_isError value &rarr; boolean_

Returns true if _value_ is an instance of `Error`.


### isRegExp

_isRegExp value &rarr; boolean_

Returns true if _value_ is an instance of `RegExp`.


### isPromise

_isPromise value &rarr; boolean_

Returns true if _value_ is an instance of `Promise`.


### isObject

_isObject value &rarr; boolean_

Returns true if _value_ is an instance of `Object`.


### isArray

_isArray value &rarr; boolean_

Returns true if _value_ is an instance of `Array`. Equivalent to `Array.isArray`.


### isBuffer

_isBuffer value &rarr; boolean_

Returns true if _value_ is an instance of `Buffer`.


### isArrayBuffer

_isArrayBuffer value &rarr; boolean_

Returns true if _value_ is an instance of `ArrayBuffer`.


### isDataView

_isDataView value &rarr; boolean_

Returns true if _value_ is an instance of `DataView`.


### isTypedArray

_isTypedArray value &rarr; boolean_

Returns true if _value_ is an instance of `Uint8Array`.


### isMap

_isMap value &rarr; boolean_

Returns true if _value_ is an instance of `Map`.


### isWeakMap

_isWeakMap value &rarr; boolean_

Returns true if _value_ is an instance of `WeakMap`.


### isSet

_isSet value &rarr; boolean_

Returns true if _value_ is an instance of `Set`.


### isRegularFunction

_isRegularFunction value &rarr; boolean_

Returns true if _value_ is an instance of `Function`.


### isGeneratorFunction

_isGeneratorFunction value &rarr; boolean_

Returns true if _value_ is a generator function.


### isAsyncFunction

_isAsyncFunction value &rarr; boolean_

Returns true if _value_ is an asynchronous function.


### isFunction

_isFunction value &rarr; boolean_

Returns true if _value_ is a function.



## Value

_@dashkite/joy/value_


### equal

_equal a, b &rarr; boolean_

Returns true if the given values are equal, false otherwise. Performs a deep comparison.


### clone

_clone value &rarr; value_

Returns a deep clone of the given value.


### size

_size value &rarr; integer_

Returns the size of _value_, if possible. A value is considered to have a size is it has a `length`, `size`, or `byteLength` property, or if it is an object, in which case we use the length of the array returned by [`Object.keys`][mdn].
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/keys


### isEmpty

_isEmpty value &rarr; boolean_

Returns true if the size of _value_ is zero, false otherwise.



## Promise

_@dashkite/joy/promise_


### promise

_promise function &rarr; promise_

Convenience wrapper for the [`Promise` constructor][mdn].
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/Promise


### resolve

_resolve value &rarr; promise_

Returns a promise that resolve to _value_. Convenience wrapper for [`Promise.resolve`][mdn].
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/resolve


### reject

_reject error &rarr; promise_

Returns a promise that rejects with _error_. Convenience wrapper for [`Promise.reject`][mdn].
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/reject


### all

_all iterable &rarr; promise_

Returns a promise that resolve to an array of the values of of the resolved promises. Rejects if any of the promises are rejected. Convenience wrapper for [`Promise.all`][mdn].
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/all


### any

_any iterable &rarr; promise_

Returns a promise that resolves to the values of the first resolved promise of the _iterable_. If none of the promises resolve, the promise rejects. Convenience wrapper for [`Promise.any`][mdn].
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/any


### race

_race iterable &rarr; promise_

Returns a promise that resolves or rejects as soon as one of the promises in an iterable resolves or rejects, with the value or reason from that promise. Convenience wrapper for [`Promise.race`][mdn].
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/race


### map

_map iterable &rarr; promise_

Returns a promise that resolves after all of the given promises have either resolved or rejected, with an array of objects that each describes the outcome of each promise. Effectively maps an iterable of promises to an array of results. Convenience wrapper for [`Promise.allSettled`][mdn]:
> For each outcome object, a status string is present. If the status is fulfilled, then a value is present. If the status is rejected, then a reason is present. The value (or reason) reflects what value each promise was fulfilled (or rejected) with.
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise/allSettled



## Text

_@dashkite/joy/text_


### toString

_toString value &rarr; string_

Returns a string representation of _value_. Convenience wrapper for the [`toString`][mdn] method.
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/toString


### toUpperCase

_toUpperCase string &rarr; string_

Returns a the given string in upper case. Convenience wrapper for the [`toUpperCase`][mdn] method.
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/toUpperCase


### toLowerCase

_toLowerCase string &rarr; string_

Returns a the given string in lower case. Convenience wrapper for the [`toLowerCase`][mdn] method.
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/toLowerCase


### trim

_trim string &rarr; string_

Returns a the given string with leading and trailing whitespace removed. Convenience wrapper for the [`trim`][mdn] method.
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/trim


### split

_split pattern, string &rarr; array_

Returns an array obtained by splitting _string_ using the given Regular Expression _pattern_. Convenience wrapper for the [`split`][mdn] method.
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/split


### w

_w string &rarr; array_

Returns an array obtained by splitting _string_ on whitespace.


### isBlank

_isBlank string &rarr; boolean_

Returns true if the string is empty, false otherwise.


### match

_match pattern, string &rarr; match_

Returns the [match data][mdn-a] for the given Regular Expression _pattern_ or undefined if the pattern doesn't match. Convenience wrapper for the [`match`][mdn-b] method.
[mdn-a]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/match#return_value [mdn-b]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/match


### isMatch

_isMatch pattern, string &rarr; boolean_

Returns true if the given Regular Expression _pattern_ matches, false otherwise. Convenience wrapper for the [`RegExp::test`][mdn] method.
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RegExp/test


### replace

_replace pattern, replacement, string &rarr; string_

Returns the string resulting from replacing matches of the Regular Expression _pattern_ using _replacement_, which may be a string or function returning a string. Convenience wrapper for [`replace`][mdn].
[mdn]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/replace



## Array

_@dashkite/joy/array_


### first

_first  &rarr; _




### second

_second  &rarr; _




### third

_third  &rarr; _




### fourth

_fourth  &rarr; _




### fifth

_fifth  &rarr; _




### nth

_nth  &rarr; _




### last

_last  &rarr; _




### rest

_rest  &rarr; _




### includes

_includes  &rarr; _




### findIndexOf

_findIndexOf  &rarr; _




### findLastIndexOf

_findLastIndexOf  &rarr; _




### push/enqueue

_push/enqueue  &rarr; _




### pop/dequeue

_pop/dequeue  &rarr; _




### shift

_shift  &rarr; _




### unshift

_unshift  &rarr; _




### cat

_cat  &rarr; _




### slice

_slice  &rarr; _




### splice

_splice  &rarr; _




### uniqueBy

_uniqueBy  &rarr; _




### unique

_unique  &rarr; _




### dupes

_dupes  &rarr; _




### union

_union  &rarr; _




### intersection

_intersection  &rarr; _




### difference

_difference  &rarr; _




### complement

_complement  &rarr; _




### insert

_insert  &rarr; _




### remove

_remove  &rarr; _




### range

_range  &rarr; _




### join

_join  &rarr; _




### fill

_fill  &rarr; _




### pluck

_pluck  &rarr; _




### pair

_pair  &rarr; _




### shuffle

_shuffle  &rarr; _





## Math

_@dashkite/joy/math_


### gt

_gt  &rarr; _




### lt

_lt  &rarr; _




### gte

_gte  &rarr; _




### lte

_lte  &rarr; _




### add

_add  &rarr; _




### sub

_sub  &rarr; _




### mul

_mul  &rarr; _




### div

_div  &rarr; _




### mod

_mod  &rarr; _




### even

_even  &rarr; _




### odd

_odd  &rarr; _




### min

_min  &rarr; _




### max

_max  &rarr; _




### abs

_abs  &rarr; _





## Time

_@dashkite/joy/time_


### timer

_timer  &rarr; _




### sleep

_sleep  &rarr; _




