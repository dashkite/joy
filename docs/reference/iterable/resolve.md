---
order: 1
---
# resolve

_Function_ &bull; Awaits on promises produced by _iterable_, generating the resolved values.

<pre><code>resolve iterable &rarr; generator</code></pre>
<br>

| name | type | description |
|------|------|-------------|
|iterable|[`Iterable`][Iterable]|The iterable from which to consume products.|
|&rarr; generator|[`Generator`][Generator]|Generates the resolved products of the original iterable.|



## Examples


 ||| CoffeeScript 
```coffeescript Waiting on reading a file.
load = flow [
  glob "**/*.coffee"
  resolve map partial FS.fileRead _, "utf8"
]

```


[Iterable]: #
[Generator]: #