---
order: 1
---
# arity

_Function_ &bull; Returns an n-ary function that passes its arguments to a target function.


==- <pre><code>arity desiredArity, target &rarr; wrapper</code></pre>
<hr>

[!badge size="xl" variant="primary" text="Arguments"]

| name | type | description |
|------|------|-------------|
|desiredArity|[`Number`][Number]|The desired arity of the returned `wrapper`. Must be an integer between 0 and 10, inclusive.|
|target|[`Function`][Function]|The target function to be wrapped. The returned `wrapper` wraps `target` and passes its arguments to `target`.|

<br>

[!badge size="xl" variant="success" text="Returns"]

| name | type | description |
|------|------|-------------|
|wrapper|[`Function`][Function]|An anonymous function with the desired arity. This function wraps `target` and passes it all arguments.|



===


## Description

A function's [arity][arity] describes how many arguments it expects. Joy provides `arity` as a means to manipulate arity, an operation that is a fundamental building block of functional composition. Rather than modifying `target` directly, `arity` shims the interface with one that has the desired arity.

`arity` wraps `target` with an anonymous function, `wrapper`. `wrapper` has an arity of `desiredArity` However, `arity` prioritizes pragmatism. `wrapper` passes the [`arguments`][arguments] object to `target`. So, _all_ arguments passed to `wrapper` are passed to `target`, regardless of `desiredArity`.

`arity` also ensures `target` runs with the current [`this`][this].

!!! Primary Point of Interest
JavaScript is somewhat lenient regarding arity. When you invoke a function, it takes a YOLO approach, running with whatever arguments are available. Strictly speaking, that's a little reckless, but it's powerful when used responsibly. `arity` preserves that flexibilty inherent to the language.

The [`Function`][Function] object provides [`Function.length`][Function.length], letting us ask a function to describe its arity. That reflective interface assists us when we build metaprogramming structures, including functional composition.
!!!

[arity]: https://en.wikipedia.org/wiki/Arity


## Examples



#### We may freely establish arity.

+++ CoffeeScript
```coffeescript #
f = ->
g = _.arity 4, f

assert.equal 0,
  f.length

assert.equal 4,
  g.length
```

+++ JavaScript
```javascript #
let f = function(){};
let g = _.arity(4, f);

assert.equal(0,
  f.length);

assert.equal(4,
  g.length);
```

+++

We may freely establish an interface of a given arity for our function. However, note that the underlying function, `f`, remains unchanged. We are shimming the interface. We are wrapping `f` with a function that:

1. Has an interface that matches our specification
2. Transparently passes the arguments along.
#### `arity` does not provide enforcement.

+++ CoffeeScript
```coffeescript #
double = (x) -> x * 2
nullaryDouble = _.arity 0, double

assert.equal 0,
  nullaryDouble.length

assert.equal 4,
  nullaryDouble 2
```

+++ JavaScript
```javascript #
let double = (x) => x * 2;
let nullaryDouble = _.arity(0, double);

assert.equal(0,
  nullaryDouble.length);

assert.equal(4,
  nullaryDouble(2));
```

+++

We can look at the arity of `nullaryDouble` and confirm that it is `0` (nullary). However, `arity` does not provide enforcemet. We can pass an argument to `nullaryDouble`. It accepts the argument and returns its double.

This example highlights the pragmatism of `arity`. The function `nullaryDouble` does present a nullary interface, but it will also pass along any arguments it receives (via the [`arguments`][arguments] object). If you're buliding a structure that depends on strict arity enforcement, you're free to inspect `Function.length` and opt into that rigor, but that's not `arity`'s design goal.

#### Use `arity` to build interfaces with intention.

+++ CoffeeScript
```coffeescript #
wait = (f) ->
  _.arity f.length, (ax...) ->
    Promise.all ax
      .then (ax) -> f ax...
```

+++ JavaScript
```javascript #
const wait = (f) => {
  return _.arity(f.length, (...ax) => {
    return Promise.all(ax)
      .then(ax => f(...ax));
  });
};
```

+++

For this example, let's take a look at the implementation of [`wait`][wait].

In summary, imagine having several arguments to pass to `f`, but some of them are promises. We would like to make sure they all resolve before we pass them to `f`.

We could write that imperatively, but Joy encourages a functional style. That involves building up interfaces that do what we need. And in this case, `wait` is an interface shim that resolves those promises for us.

But when we sat down to write `wait`, we wanted it to be as flexible as possible and to not obscure the interface it's shimming. `wait` inspects the underlying function and uses `arity` to _preserve_ its arity.

That allows `wait` to be powerful and flexible. And because it preserves the arity, we give ourselves the optionality to use that in another, higher-level interface.

Being intentional about interface optionality is a hallmark of functional composition. It's a design decision in Joy to encourage it, and it reflects the pragmatism of JavaScript itself. Having a "flexible by default" mindset makes it easy to craft and test out metaprogramming structures as you build them up.


[Number]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number
[Function]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function
[arguments]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/arguments
[this]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/this
[Function.length]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/length
[wait]: /reference/function/wait.md