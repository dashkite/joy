# pairs

_Function_ &bull; Returns the properties for the given object as an associative array (an array of two-element arrays).

<pre><code>pairs object &rarr; array</code></pre>
<br>

| name | type | description |
|------|------|-------------|
|object|any||
|array|any||


## Examples


 ||| CoffeeScript 
```coffeescript 
assert.deepEqual (x.pairs {a: 1, b: 2, c: 3}),
  [["a", 1], ["b", 2], ["c", 3]]
```

