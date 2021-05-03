# getters

_Function_ &bull; Defines getters on _target_ using the given _dictionary_ of keys and getter functions. Convenience wrapper for [`getter`](#getter). Like most Joy functions, `getters` is curryable, so you can define a function that will define a property on any object. Use in combination with [`mixin`](#mixin) to create reusable mixins.

<pre><code>getters dictionary, target &rarr; object</code></pre>
<br>

| name | type | description |
|------|------|-------------|
|dictionary|any||
|target|any||
|object|any||



## Examples


 ||| CoffeeScript 
```coffeescript 
class Foo
  mixin @::, [
    getters
      bar: -> "bar"
  ]
assert.equal "bar", (new Foo).bar
```

