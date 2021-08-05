---
order: 1
---
# wrap

_Function_ &bull; Returns a function that returns its argument.


==- <pre><code>wrap value &rarr; function</code></pre>
<hr>

[!badge size="xl" variant="primary" text="Arguments"]

| name | type | description |
|------|------|-------------|
|value|Any|Any JavaScript value.|

<br>

[!badge size="xl" variant="success" text="Returns"]

| name | type | description |
|------|------|-------------|
|function|[`Function`][Function]|An anonymous function that returns `value` when invoked.|



===


## Description

`wrap` returns an anonymous function that, when invoked, returns the argument `value`. Use it any time you need to convert a value into a function you want to invoke later.

!!! Warning Caution
The argument `value` remains in scope between invocations. If you use `wrap` on a `value` where JavaScript applies [pass by reference][pass by reference], mutations to `value` persist. That is, the _new_ value is returned the next time you invoke `wrap`. That's probably not a good idea, so be careful.
!!!


## Examples



#### Returns a function that returns its argument.

+++ CoffeeScript
```coffeescript #
provide = _.wrap 1

assert.equal 1,
  provide()
```

+++ JavaScript
```javascript #
let provide = _.wrap(1);

assert.equal(1,
  provide());
```

+++


#### Avoid mutating wrapped values.

+++ CoffeeScript
```coffeescript #
provide = _.wrap x: 1
double = (object) ->
  object.x *= 2
  object

assert.deepEqual x: 2,
  double provide()

# With `value` mutated, provide returns the doubled value.
assert.deepEqual x: 2,
  provide()
```

+++ JavaScript
```javascript #
let provide = _.wrap({ x: 1 });
let double = (object) => {
  object.x *= 2
  return object
};

assert.deepEqual({ x: 2 },
  double(provide()));

assert.deepEqual({ x: 2 },
  provide());
```

+++

The above example defines:
  - `provide`, a function created by `wrap` that returns an object.
  - `double`, a function that mutates the object passed to it.

In the first assert, we can see that `double` successfully doubles the value returned from `provide`. However, because JavaScript applies [pass by reference][pass by reference] to regular objects, the value now returned by `provide` is also altered. We confirm that in the second assert.

Keep this in mind when using `wrap` and avoid mutating `value`.


[Function]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function
[pass by reference]: https://medium.com/nodesimplified/javascript-pass-by-value-and-pass-by-reference-in-javascript-fcf10305aa9c