# pipeWith

_Function_ &bull; Works like [`pipe`](#pipe), except transforms each function with the given adaper before composing them.

<pre><code>pipeWith adapter, functions &rarr; function</code></pre>
<br>

| name | type | description |
|------|------|-------------|
|adapter|any||
|functions|any||
|function|any||


## Examples


 ||| CoffeeScript 
```coffeescript 
trace = (f) ->
  (args...) ->
    console.log "function:", f.name
    console.log "-- arguments:", args
    console.log "-- returns:", r = f args...
    r

pipeWith trace, [
  # functions to trace...
]
```

