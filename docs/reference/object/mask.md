---
order: 1
---
# mask

_Function_ &bull; Returns a new object with the specified subset of the values from the original.


==- <pre><code>mask keys, original &rarr; maskedObject</code></pre>
<hr>

[!badge size="xl" variant="primary" text="Arguments"]

| name | type | description |
|------|------|-------------|
|keys|[`Array`][Array]|The list of object keys to pull from `original`|
|original|[`Iterable`][Iterable]|The object `mask` uses as the basis of its copy.|

<br>

[!badge size="xl" variant="success" text="Returns"]

| name | type | description |
|------|------|-------------|
|maskedObject|[`Object`][Object]|The output object with a masked subset of the original keys.|



===


## Description

`keys` specifies the subset of keys to select for inclusion in the output. `maskedObject` is a new object with a subset of `original`'s values. `original` is unalerted. `mask` does not clone non-primitive values, similar to behavior from [`merge`][merge], so use caution. 



[Array]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array
[Iterable]: #
[Object]: #
[merge]: /reference/object/merge.md