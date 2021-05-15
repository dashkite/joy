---
order: 1
---
# reduce

_Function_ &bull; Reduces _iterable_ to _value_ by combining its products using a _reducer_.

<pre><code>reduce reducer, initial, iterable &rarr; value</code></pre>
<br>

| name | type | description |
|------|------|-------------|
|reducer|[`Function`][Function]|The function to use to combine a product and a value.|
|initial|any|The the initial value of the reduction.|
|iterable|[`Iterable`][Iterable]|The iterable to reduce.|
|&rarr; value|any|The resulting value.|



## Examples


 ||| CoffeeScript 
```coffeescript Adding a sequence of numbers.
assert.equal 15, reduce add, 0, [1..5]
```


[Function]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function
[Iterable]: #