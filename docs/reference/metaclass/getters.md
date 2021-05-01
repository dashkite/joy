# getters

_Function_

Defines getters on _target_ using the given _dictionary_ of keys and getter functions. Convenience wrapper for [&#x60;getter&#x60;](#getter). Like most Joy functions, &#x60;getters&#x60; is curryable, so you can define a function that will define a property on any object. Use in combination with [&#x60;mixin&#x60;](#mixin) to create reusable mixins.

<pre><code>getters dictionary, target &rarr; object</code></pre>
<br>

| name | type | description |
|------|------|-------------|
|dictionary|any||
|target|any||
|object|||


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

