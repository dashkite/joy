---
order: 1
---
# project

_Function_ &bull; Returns the value of the property matching the given _property_ for each product from _iterable_. That is, it is the composition of [`get`][get] with [`map`][map].
Like most Joy functions, `project` is curryable, so `project` can be used like Ramda's [`pluck`][ramda].
However, because `project` relies on `map`, `project` is suitable for both synchronous and asynchronous iterables. Note that `project` uses Array::map when specifically passed an array.
[get]: https://dashkite.github.io/joy/reference/object/get/ [map]: https://dashkite.github.io/joy/reference/iterable/map/ [ramda]: https://ramdajs.com/docs/#pluck

Projects

<pre><code>project property, iterable &rarr; generator</code></pre>
<br>
<pre><code>project property, array &rarr; array</code></pre>
<br>

| name | type | description |
|------|------|-------------|
|property|[`String`][String]|The name of the object property to project from each product.|
|iterable|[`Iterable`][Iterable]|The iterable from which to consume products.|
|&rarr; generator|[`Generator`][Generator]|Generates the value of the _property_ from each product from _iterable_ with a synchronicity matching _iterable_.|
|array|[`Array`][Array]|The array from which to consume items.|
|&rarr; array|[`Array`][Array]|Lists the value of the _property_ from each item in _array_.|




[map]: /reference/promise/map.md
[ramda]: #
[String]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String
[Iterable]: #
[Generator]: #
[Array]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array