---
order: 1
---
# join

_Function_ &bull; Like reduce, except for joining products with a join function.


==- <pre><code>join append, iterable &rarr; result</code></pre>
<hr>

[!badge size="xl" variant="primary" text="Arguments"]

| name | type | description |
|------|------|-------------|
|append|[`Function`][Function]|The join function.|
|iterable|[`Iterator`][Iterator]|The iterable whose products will be joined.|

<br>

[!badge size="xl" variant="success" text="Returns"]

| name | type | description |
|------|------|-------------|
|result|Any|The value resulting from joining the products.|


==- <pre><code>join delimiter, iterable &rarr; string</code></pre>
<hr>

[!badge size="xl" variant="primary" text="Arguments"]

| name | type | description |
|------|------|-------------|
|delimiter|[`String`][String]|The delimeter separating products of the iterable.|
|iterable|[`Iterator`][Iterator]|The iterable whose products will be joined.|

<br>

[!badge size="xl" variant="success" text="Returns"]

| name | type | description |
|------|------|-------------|
|string|[`String`][String]|The resulting string.|



===


## Description

Accepts a join function and a producer. Specialized for joining products with a string and for arrays.


[Function]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function
[Iterator]: #
[String]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String