---
order: 1
---
# elide

_Function_ &bull; Elides a string so that it is no longer than a specified length, appending a terminating string.


==- <pre><code>elide length, string &rarr; string</code></pre>
<hr>

[!badge size="xl" variant="primary" text="Arguments"]

| name | type | description |
|------|------|-------------|
|length|[`Number`][Number]|The target string length.|
|string|[`String`][String]|The string to elide.|

<br>

[!badge size="xl" variant="success" text="Returns"]

| name | type | description |
|------|------|-------------|
|string|[`String`][Global]|The modified string.|



===


## Description

Elides a string so that it is no longer than a specified length, appending a terminating string. Avoids truncating in the middle of a word.


[Number]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number
[String]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String
[Global]: #