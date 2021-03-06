---
order: 1
---
# map

_Function_ &bull; Returns a promise that resolves after all of the given promises have either resolved or rejected, with an array of objects that each describes the outcome of each promise. Effectively maps an iterable of promises to an array of results.
For each outcome object, a status string is present. If the status is fulfilled, then a value is present. If the status is rejected, then a reason is present. The value (or reason) reflects what value each promise was fulfilled (or rejected) with.


==- <pre><code>map iterable &rarr; promise</code></pre>
<hr>

[!badge size="xl" variant="primary" text="Arguments"]

| name | type | description |
|------|------|-------------|
|iterable|Any||

<br>

[!badge size="xl" variant="success" text="Returns"]

| name | type | description |
|------|------|-------------|
|promise|Any||



===



