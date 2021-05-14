---
order: 1
---
# parseNumber

_Function_ &bull; Parses a string representation of a number.

<pre><code>parseNumber strig &rarr; number</code></pre>
<br>

| name | type | description |
|------|------|-------------|
|strig|[`String`][String]|The string to parse.|
|&rarr; number|[`Number`][Number]|The number parsed from the string.|


## Description

Returns a number parsed from a string.

!!!warning Warning
If the number being parsed is larger than may be safely represented in JavaScript (that is, larger than [`Number.MAX_SAFE_INTEGER`][NumberMAX_SAFE_INTEGER]), the parsed number will lose precision. If you may be parsing extremely large numbers, use [`BigInt`][BigInt] instead.
!!!


[String]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String
[Number]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number
[NumberMAX_SAFE_INTEGER]: #
[BigInt]: #