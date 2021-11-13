---
order: 1
---
# exclude

_Function_ &bull; Returns a new object with all the keys from the original except those specified.


==- <pre><code>exclude keys, original &rarr; excludedObject</code></pre>
<hr>

[!badge size="xl" variant="primary" text="Arguments"]

| name | type | description |
|------|------|-------------|
|keys|[`Array`][Array]|The list of object keys to exclude from `original`|
|original|[`Iterable`][Iterable]|The object `exclude` uses as the basis of its copy.|

<br>

[!badge size="xl" variant="success" text="Returns"]

| name | type | description |
|------|------|-------------|
|excludedObject|[`Object`][Object]|A new object with all the keys and values of `original` save those excluded in `keys`.|



===


## Description

`keys` specifies the subset of keys to select for exclusion in the output. `excludedObject` is a new object with a subset of `original`'s values. `original` is unalerted. `exclude` does not clone non-primitive values, similar to behavior from [`merge`][merge], so use caution. 



[Array]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array
[Iterable]: #
[Object]: #
[merge]: /reference/object/merge.md