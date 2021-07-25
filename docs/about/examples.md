# Examples

Examples are an important part of our documentation. This page lays out some conventions to let you know what to expect when you read something we've written.

## Assume Context

We like to avoid repetition while writing these examples. But more importantly, we aim to keep laser-focused in each example snippet. Therefore, when you see example code, assume the following lines are above it:

+++ CoffeeScript
```coffeescript
import * as _ from "@dashkite/joy"
import assert from "@dashkite/assert"
```
+++ Javascript
```javascript
import * as _ from "@dashkite/joy"
import assert from "@dashkite/assert"
```
+++


That way, we can write `_` and `assert` in each example and you know exactly what they reference in that context.

## What Is `assert`?

`@dashkite/assert` is our assertion library, since JavaScript does not have a standard module for that purpose.

There are two contenders:

- `console.assert`, but it isn't as flexible as `@dashkite/assert`.
- `assert` from Node.js. It has more flexibility, but it doesn't work in the browser and its acceptance of truthy values is imprecise.

We wrote `@dashkite/assert` to avoid these drawbacks, giving you a flexible, powerful assertion tool written in universal JavaScript.

## Assertion Ordering

Whenever we use DashKite's `assert` in example code, we like to write it in the following order:

+++ CoffeeScript
```coffeescript
assert.equal 4,
  add 2, 2
```
+++ Javascript
```javascript
assert.equal(4,
  add(2, 2));
```
+++

The invocation of assert and the expected value go on the first line. On the following lines, the example expression is allowed to unfurl.

We like that this "expected value first" style expresses the intention of our example by telling you what to expect up front.

## Conversational Examples

We usually build examples with sub-sections, each with its code snippet. Each section comes with a header and, optionally, some companion prose. The goal of the examples section is to snowball a concept. The sub-sections start with the most basic application of a function and then layout edge cases or areas of interest.

As a collection, the sub-sections build a guide. While the code examples might not be directly related, conceptually, we aim for a flow that creates a common understanding.
