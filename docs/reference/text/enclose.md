---
order: 1
---
# enclose

_Function_ &bull; Enclose a string with delimeters.

<pre><code>enclose delimiter-string, string &rarr; string</code></pre>
<br>
<pre><code>enclose delimiter-array, string &rarr; string</code></pre>
<br>

| name | type | description |
|------|------|-------------|
|delimiter-string|[`String`][String]|The delimiter(s).|
|string|[`String`][String]|The string to delimit.|
|&rarr; string|[`String`][String]|The enclosed string.|
|delimiter-array|[`Array`][Array]|The delimiter(s).|


## Description

Enclose a string with a delimeters. The delimeters may be specified by a [String][String] or an [Array][Array]. The first character or array element is the start delimeter. The second character or array element is the end delimeter. If no end delimiter is specified, the start and end delimiters are the same.

## Examples


 ||| CoffeeScript 
```coffeescript Enclosing a string within parenthesis.
assert.equal "( hello )", enclose [ "( ", " )" ], "hello"

```


[String]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String
[Array]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array