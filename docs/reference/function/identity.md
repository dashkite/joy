---
order: 1
---
# identity

_Function_ &bull; Returns its argument.


==- <pre><code>identity value &rarr; value</code></pre>
<hr>

[!badge size="xl" variant="primary" text="Arguments"]

| name | type | description |
|------|------|-------------|
|value|Any|Any JavaScript value.|

<br>

[!badge size="xl" variant="success" text="Returns"]

| name | type | description |
|------|------|-------------|
|value|Any|The unaltered argument `value`.|



===


## Description

Named for the mathematical concept of [identity][identity]. `identity` returns the first argument you provide it, unaltered. This is the functional version of a [no operation][no operation]. Use it as a default, a fallback, or even just as a placeholder for in-progress code.

!!! Primary Point of Interest
The return `value` is the arugment `value`. That is, even when passing an object to `identity`, the return `value` is [strictly equal][strictly equal] to the argument `value`.
!!!

[identity]: https://en.wikipedia.org/wiki/Identity_(mathematics)
[no operation]: https://en.wikipedia.org/wiki/NOP_(code)


## Examples



#### Returns its argument.

+++ CoffeeScript
```coffeescript #
assert.equal 1,
  _.identity 1
```

+++ JavaScript
```javascript #
assert.equal(1,
  _.identity(1));
```

+++


#### Returns only its first argument.

+++ CoffeeScript
```coffeescript #
assert.equal 1,
  _.identity 1, 2, 3
```

+++ JavaScript
```javascript #
assert.equal(1,
  _.identity(1, 2, 3));
```

+++


#### Returns the exact argument. Even objects are strictly equal.

+++ CoffeeScript
```coffeescript #
a = company: "Delos"

assert.equal a,
  _.identity a
```

+++ JavaScript
```javascript #
const a = { company: "Delos" };

assert.equal(a,
  _.identity(a));
```

+++



[strictly equal]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Strict_equality