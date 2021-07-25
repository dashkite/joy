---
order: 1
---
# project

_Function_ &bull; Returns the value of the property matching the given _property_ for each product from _iterable_.


==- <pre><code>project property, iterable &rarr; generator</code></pre>
<hr>

[!badge size="xl" variant="primary" text="Arguments"]

| name | type | description |
|------|------|-------------|
|property|[`String`][String]|The name of the object property to project from each product.|
|iterable|[`Iterable`][Iterable]|The iterable from which to consume products.|

<br>

[!badge size="xl" variant="success" text="Returns"]

| name | type | description |
|------|------|-------------|
|generator|[`Generator`][Global]|Generates the value of the _property_ from each product from _iterable_ with a synchronicity matching _iterable_.|


==- <pre><code>project property, array &rarr; array</code></pre>
<hr>

[!badge size="xl" variant="primary" text="Arguments"]

| name | type | description |
|------|------|-------------|
|property|[`String`][String]|The name of the object property to project from each item.|
|array|[`Array`][Array]|The array from which to consume items.|

<br>

[!badge size="xl" variant="success" text="Returns"]

| name | type | description |
|------|------|-------------|
|array|[`Array`][Global]|Lists the value of the _property_ from each item in _array_.|



===


## Description

Returns the value of the property matching the given _property_ for each product from _iterable_. That is, it is the composition of [`get`][get] with [`map`][map].

Like most Joy functions, `project` is curryable, so `project` can be used like Ramda's [`pluck`][ramda].

However, because `project` relies on `map`, `project` is suitable for both synchronous and asynchronous iterables. Note that `project` uses Array::map when specifically passed an array.

[get]: https://dashkite.github.io/joy/reference/object/get/
[map]: https://dashkite.github.io/joy/reference/iterable/map/
[ramda]: https://ramdajs.com/docs/#pluck


[String]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String
[Iterable]: #
[Global]: #
[Array]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array