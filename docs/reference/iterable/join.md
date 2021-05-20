---
order: 1
---
# join

_Function_ &bull; Like reduce, except for joining products with a join function.

<pre><code>join append, iterable &rarr; result</code></pre>
<br>
<pre><code>join delimiter, iterable &rarr; string</code></pre>
<br>

| name | type | description |
|------|------|-------------|
|append|[`Function`][Function]|The join function.|
|iterable|[`Iterator`][Iterator]|The iterable whose products will be joined.|
|&rarr; result|any|The value resulting from joining the products.|
|delimiter|[`String`][String]|The delimeter separating products of the iterable.|
|&rarr; string|[`String`][String]|The resulting string.|


## Description

Accepts a join function and a producer. Specialized for joining products with a string and for arrays.


[Function]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function
[Iterator]: #
[String]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String