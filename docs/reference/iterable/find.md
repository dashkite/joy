---
order: 1
---
# find

_Function_ &bull; Returns a sought value from an iterable if it can be found, otherwise `undefined`. Specialized for array.


==- <pre><code>find searchFunction, iterable &rarr; output</code></pre>
<hr>

[!badge size="xl" variant="primary" text="Arguments"]

| name | type | description |
|------|------|-------------|
|searchFunction|[`Function`][Function]|The search function that checks for a given value.|
|iterable|[`Iterable`][Iterable]|The synchronous or asynchronous iterable containing values to search through.|

<br>

[!badge size="xl" variant="success" text="Returns"]

| name | type | description |
|------|------|-------------|
|output|Any|The result of the search. Either the matching value or `undefined`.|


==- <pre><code>find searchFunction, array &rarr; output</code></pre>
<hr>

[!badge size="xl" variant="primary" text="Arguments"]

| name | type | description |
|------|------|-------------|
|searchFunction|[`Function`][Function]|The search function that checks for a given value.|
|array|[`Array`][Array]|An array of values to search through.|

<br>

[!badge size="xl" variant="success" text="Returns"]

| name | type | description |
|------|------|-------------|
|output|Any|The result of the search. Either the matching value or `undefined`.|



===


## Description

`find` processes the elements of `iterable` until it finds a value that returns `true` when passed as an arugment to `searchFunction`. If such a value cannot be found, `find` returns `undefined`.



[Function]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function
[Iterable]: #
[Array]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array