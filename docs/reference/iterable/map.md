---
order: 1
---
# map

_Function_ &bull; Calls _function_ with each product from _iterable_.
`map` is suitable for use with both synchronous iterables and asynchronous iterables, and will return a generator producing the resulting products with matching synchronicity.
`map` uses Array::map when specifically passed an array, so in that case it returns a new array.

<pre><code>map function, iterable &rarr; generator</code></pre>
<br>
<pre><code>map function, array &rarr; array</code></pre>
<br>

| name | type | description |
|------|------|-------------|
|function|[`Function`][Function]|The function to apply to each product.|
|iterable|[`Iterable`][Iterable]|The iterable from which to consume products.|
|&rarr; generator|[`Generator`][Generator]|Generates the result of applying _function_ to products from _iterable_ with a synchronicity matching _iterable_.|
|array|[`Array`][Array]|The iterable from which to consume products.|
|&rarr; array|[`Array`][Array]|Lists the result of applying _function_ to items from _array_.|




[Function]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function
[Iterable]: #
[Generator]: #
[Array]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array