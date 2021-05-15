---
order: 1
---
# select

_Function_ &bull; Calls _predicate_ for each product from _iterable_, generating products that return true.

<pre><code>select predicate, iterable &rarr; generator</code></pre>
<br>

| name | type | description |
|------|------|-------------|
|predicate|[`Function`][Function]|The function to call for each product.|
|iterable|[`Iterable`][Iterable]|The iterable from which to consume products.|
|&rarr; generator|[`Generator`][Generator]|Generates the products satisfying _predicate_.|




[Function]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function
[Iterable]: #
[Generator]: #