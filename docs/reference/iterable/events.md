---
order: 1
---
# events

_Function_ &bull; Converts an event source into an asynchronous iterator.

<pre><code>events name, source &rarr; iterator</code></pre>
<br>

| name | type | description |
|------|------|-------------|
|name|[`String`][String]|The name of the event to listen for.|
|source|[`EventEmitter | EventTarget`][EventEmitter  EventTarget]|The event source.|
|&rarr; iterator|[`Iterable`][Iterable]|The asynchronous iterator.|




[String]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String
[EventEmitter  EventTarget]: #
[Iterable]: #