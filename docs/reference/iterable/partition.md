---
order: 1
---
# partition

_Function_ &bull; Returns the products of an _iterable_ unchanged, but grouped into partitions. Each partition is an array with a length of at least 1 and at most _size_.
`partition` produces these partitions until the _iterable_ is exhausted, at which point the final partition may have some length less than _size_, but it will never be empty.
`partition` is suitable for both synchronous iterators and asynchronous iterators. `partition` returns a generator with synchronicity matching _iterable_. In both cases, the resultant products are arrays of the underlying products.

<pre><code>partition size, iterable &rarr; generator</code></pre>
<br>

| name | type | description |
|------|------|-------------|
|size|[`Number`][Number]|The maximum length of the arrays that make up each partition of products.|
|iterable|[`Iterable`][Iterable]|The iterable from which to consume products.|
|&rarr; generator|[`Generator`][Generator]|Generates products that are arrays of length _size_, listing otherwise unaltered products from the source _iterable_. This generator has a synchronicity matching _iterable_.|




[Number]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number
[Iterable]: #
[Generator]: #