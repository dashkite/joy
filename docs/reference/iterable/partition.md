---
order: 1
---
# partition

_Function_ &bull; Returns the products of an _iterable_ unchanged, but grouped into partitions. Each partition is an array with a length of at least 1 and at most _size_.


==- <pre><code>partition size, iterable &rarr; generator</code></pre>
<hr>

[!badge size="xl" variant="primary" text="Arguments"]

| name | type | description |
|------|------|-------------|
|size|[`Number`][Number]|The maximum length of the arrays that make up each partition of products.|
|iterable|[`Iterable`][Iterable]|The iterable from which to consume products.|

<br>

[!badge size="xl" variant="success" text="Returns"]

| name | type | description |
|------|------|-------------|
|generator|[`Generator`][Global]|Produces arrays of length _size_, listing otherwise unaltered products from the source _iterable_.|



===


## Description

Returns the products of an _iterable_ unchanged, but grouped into partitions. Each partition is an array with a length of at least 1 and at most _size_.

`partition` produces these partitions until the _iterable_ is exhausted, at which point the final partition may have some length less than _size_, but it will never be empty.

`partition` is suitable for both synchronous iterators and asynchronous iterators. `partition` returns a generator with synchronicity matching _iterable_. In both cases, the resultant products are arrays of the underlying products.


[Number]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number
[Iterable]: #
[Global]: #