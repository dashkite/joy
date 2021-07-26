---
order: 1
---
# select

_Function_ &bull; Calls _predicate_ for each product from _iterable_, generating products that return true.


==- <pre><code>select predicate, iterable &rarr; generator</code></pre>
<hr>

[!badge size="xl" variant="primary" text="Arguments"]

| name | type | description |
|------|------|-------------|
|predicate|[`Function`][Function]|The function to call for each product.|
|iterable|[`Iterable`][Iterable]|The iterable from which to consume products.|

<br>

[!badge size="xl" variant="success" text="Returns"]

| name | type | description |
|------|------|-------------|
|generator|[`Generator`][Generator]|Generates the products satisfying _predicate_.|



===




[Function]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function
[Iterable]: #
[Generator]: #