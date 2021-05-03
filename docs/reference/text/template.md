# template

_Function_ &bull; Returns a function that will substitute the properties of its argument into the given string, processing it using the optional filters.
Lightweight but relatively limited and slow. Uses regexp substitution and does not support common templating features, such as control flow, iteration, or escaping.

<pre><code>template string[, filters] &rarr; function</code></pre>
<br>

| name | type | description |
|------|------|-------------|
|string[|any||
|filters]|any||
|function|any||


## Examples


 ||| CoffeeScript 
```coffeescript 
f = template "foo {{ bar | reverse }} baz",
  reverse: (s) -> s.split("").reverse().join("")
assert.equal "foo xuaf baz", f bar: "faux"
```

