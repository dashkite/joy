# Equality

From time to time, you'll need to compare two values. Equality comparison is a powerful operation, but there's some subtlety in the definition of _equality_. This is a primer on the kinds of equality that exist in JavaScript and how Joy approaches this question.

## Loose Equality
+++ CoffeeScript
```coffeescript #
assert.equal true,
  `1 == 1`

assert.equal true,
  `"1" == 1`
```

+++ JavaScript
```javascript #
assert.equal(true,
  1 == 1);

assert.equal(true,
  "1" == 1);
```

+++

[Loose Equality][], sometimes called abstract equality, is a legacy equality comparison dating back to the origins of JavaScript. It performs type coercion on values before comparing them. It has its uses, but it is imprecise and generally disfavored.

In the above CoffeeScript example, you can the see we use backticks, which specify literal JavaScript expressions. We needed them because CoffeeScript does not offer first-class support for loose equality.

### Joy and Loose Equality
Because of the imprecision of loose equality, we avoid its explicit use. CoffeeScript's [existential operator][] will sometimes transpile into JavaScript's `==` to provide a concise match against both `null` and `undefined`. But aside from special cases like that, Joy does not support loose equality comparison.

[Loose Equality]: https://tc39.es/ecma262/#sec-islooselyequal
[existential operator]: https://coffeescript.org/#existential-operator


## Strict Equality

+++ CoffeeScript
```coffeescript #
assert.equal true,
  1 == 1

assert.equal true,
  "1" != 1
```

+++ JavaScript
```javascript #
assert.equal(true,
  1 === 1);

assert.equal(true,
  "1" !== 1`);
```

+++

[Strict Equality][], is an equality operation that ensures its operands are _strictly equal_. Strict equality does not perform type coercion, ensuring two primitive objects are equal and congruent. It was added later in JavaScript's history to provide more rigor. JavaScript authors provided this additive solution to avoid breaking existing code out on the Web.

+++ CoffeeScript
```coffeescript #
host = name: "Dolores"

assert.equal true,
  host == host

assert.equal true,
  name: "Dolores" != name: "Dolores"
```

+++ JavaScript
```javascript #
let host = { name: "Dolores" };

assert.equal(true,
  host === host);

assert.equal(true,
  { name: "Dolores" } !== { name: "Dolores" });
```

+++

For non-primitive objects (JavaScript Objects, Arrays, Sets, Maps, etc) strict equality returns `true` if the operands are _the same object_. If two objects have the same internal structure, but are distinct, strict equality returns `false`.

Because of this behavior with non-primitive objects, we sometimes refer to this as "shallow" equality. See "Deep Equality" for more.

[Strict Equality]: https://tc39.es/ecma262/#sec-isstrictlyequal


## SameValueZero Equality

+++ CoffeeScript
```coffeescript #
host = name: "Delores"

assert.equal true,
  Object.is host, host

assert.equal false,
  Object.is { name: "Delores" }, { name: "Delores" }

assert.equal false,
  NaN == NaN

assert.equal true,
  Object.is NaN, NaN
```

+++ JavaScript
```javascript #
let host = { name: "Delores" };

assert.equal(true,
  Object.is(host, host));

assert.equal(false,
  Object.is({ name: "Delores" }, { name: "Delores" }));

assert.equal(false,
  NaN === NaN);

assert.equal(true,
  Object.is(NaN, NaN));
```

+++


A more recent addition to JavaScript is [SameValueZero Equality][]. It's nearly the same as strict equality. It provides an extra refinement to how JavaScript handles `+0`, `-0`, and `NaN` comparisons. Again, JavaScript authors chose to be additive to avoid breaking existing code.

Built-in JavaScript methods use this type of equality. For example, [`Object.is`][] or [`Array::includes`][].



### Joy and SameValueZero Equality
SameValueZero is the most refined equality comparison, and it is used in the engine internally, so we prefer it. By default, Joy compares primitive values using SameValueZero equality.

Joy's comparison functions [`equal`][], [`notEqual`][], [`eq`][], and [`neq`][] all rely on [`Object.is`][]. And elsewhere, Joy makes use of modern JavaScript built-ins where possible. Notably, this includes generic specializations, like when passing an Array to [`includes`][].

[SameValueZero Equality]: https://tc39.es/ecma262/#sec-samevaluezero
[`Object.is`]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/is
[`Array::includes`]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/includes

## Deep Equality

+++ CoffeeScript
```coffeescript #
# SameValueZero Equality
assert.equal false,
  _.eq { name: "Dolores" }, { name: "Dolores" }

# Deep Equality
assert.equal true,
  _.equal { name: "Dolores" }, { name: "Dolores" }
```

+++ JavaScript
```javascript #
// SameValueZero Equality
assert.equal(false,
  _.eq({ name: "Delores" }, { name: "Delores" }));

// Deep Equality
assert.equal(true,
  _.equal({ name: "Delores" }, { name: "Delores" }));
```

+++


Under SameValueZero equality, two distinct non-primitive objects are not equivalent. But if you look at the above example, we can see that the internal values of both objects are equivalent. So in some "deeper" sense, the objects are equal.

Deep refers metaphorically to:

1. Recursive inspection.
2. The potential computational cost of that operation.


JavaScript does not provide a built-in operator that evaluates deep equality, but we provide one in Joy via [`equal`][]. 😊 And with that metaphor established, we refer to SameValueZero (and strict) equality as shallow equality.


`equal` recursively examines the internal elements of a non-primitive object and compares them using SameValueZero equality. If all corresponding elements are SameValueZero equal, `equal` returns `true`.

Use both forms of equality with care.
