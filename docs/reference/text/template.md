---
order: 1
---
# template

_Function_ &bull; Create a template function from a templatized string.

<pre><code>template template, filters &rarr; function</code></pre>
<br>

| name | type | description |
|------|------|-------------|
|template|[`String`][String]|The template string.|
|filters|[`Object`][Object]|A dictionary of filter functions for use within the template.|
|&rarr; function|[`Function`][Function]|The template as a function, taking an object as an argument.|


## Description

Create a template function from a templatized string and an optional set of filters. Useful for simple applications, but relatively limited and slow. Uses regexp substitution and does not support common templating features, such as control flow, iteration, or escaping.

## Examples


 ||| CoffeeScript 
```coffeescript A templatized greeting.
f = template "{{salutation|capitalize}}, {{name}}!", {capitalize}
assert.equal "Hello, World!",
  f salutation: "hello", name: "World"

```


[String]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String
[Object]: #
[Function]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function