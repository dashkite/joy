# query

_Function_ &bull; Returns true if _object_ matches _exemplar_, false otherwise. An exemplar matches if all of its properties are equal to the corresponding properties in the target object. Matching is done recursively, so the exemplar can contain nested values.

<pre><code>query exemplar, object &rarr; object</code></pre>
<br>

| name | type | description |
|------|------|-------------|
|exemplar|any||
|object|any||
|object|any||



## Examples


 ||| CoffeeScript 
```coffeescript 
assert.equal true, x.query { x: {y: 2 }}, { x: { y: 2}}
assert.equal false, x.query { x: {y: 2 }}, { x: { y: 1}}
```

