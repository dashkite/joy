---
order: 1
---
# uncase

_Function_ &bull; Removes case and replaces delimiters with spaces.

<pre><code>uncase string &rarr; string</code></pre>
<br>

| name | type | description |
|------|------|-------------|
|string|[`String`][String]|The string to convert.|
|&rarr; string|[`String`][String]|The modified string.|



## Examples


 ||| CoffeeScript 
```coffeescript Scenarios for using &#x60;uncase&#x60;.
assert.equal "foo bar", uncase "foo-bar"
assert.equal "foo bar", uncase "fooBar"
assert.equal "foo bar", uncase "Foo Bar"
```


[String]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String