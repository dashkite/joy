import {curry} from "panda-garden"
import Method from "panda-generics"
import {
  isSymbol, isRegExp,
  isBuffer, isArrayBuffer, isTypedArray, isDataView,
  isMap, isArray, isObject, isSet,
  isBoolean, isDate, isNumber, isString,
  isFunction, isWeakMap, isError
} from "./type"

{create, define} = Method

equal = create
  name: "equal"
  description: "Performs a deep comparison of two entities."
  default: (a, b) -> a == b

define equal, isObject, isObject, (a, b) ->
  return true if a == b
  return false if !equal (Object.keys a), (Object.keys b)
  for k, v in a when !(equal v, b[k])
    return false
  true

define equal, isTypedArray, isTypedArray, (a, b) ->
  if (a.length != b.length) || (a.name != b.name)
    return false
  for i in [0..a.length]
    if a[i] != b[i]
      return false
  true

define equal, isArrayBuffer, isArrayBuffer, (a, b) ->
  if a.byteLength != b.byteLength
    return false
  equal (new Uint8Array a), (new Uint8Array b)

define equal, isDataView, isDataView, (a, b) ->
  if (a.byteLength != b.byteLength) || (a.byteOffset != b.byteOffset)
    return false
  equal a.buffer, b.buffer

define equal, isBuffer, isBuffer, (a, b) ->
  a.equals b


isPrimitive = (x) -> (isBoolean x) || (isNumber x) || (isString x)

define equal, isPrimitive, isPrimitive, (a, b) ->
  a == b

define equal, isDate, isDate, (a, b) ->
  a.getTime() == b.getTime()

define equal, isRegExp, isRegExp, (a, b) ->
  a.toString() == b.toString()

define equal, isError, isError, (a, b) ->
  (equal a.name, b.name) && (equal a.message, b.message)

define equal, isSymbol, isSymbol, (a, b) ->
  a.valueOf() == b.valueOf()

define equal, isArray, isArray, (a, b) ->
  if a.length != b.length
    return false
  for i in [0..a.length]
    if ! equal a[i], b[i]
      return false
  true

define equal, isMap, isMap, (a, b) ->
  if a.size != b.size
    return false
  for [key, value] from a
    if ! equal value, (b.get key)
      return false
  true



define equal, isSet, isSet, (a, b) ->
  throw new Error "equal: Comparing Sets is potentially costly in terms of memory or computation, so implementation is left to the developer."

define equal, isWeakMap, isWeakMap, (a, b) ->
  throw new Error "equal: does not compare WeakMap."


export {equal}

clone = create
  name: "clone"
  description: "Creates a deep clone of an entity."
  # When no match, throw to alert that we cannot deliver a deep clone.
  default: (entity) ->
    throw new Error "clone: no match on entity #{JSON.stringify entity}"

define clone, isObject, (original) ->
  copy = new original.constructor()
  for key, value of original
    copy[clone key] = clone value
  copy


define clone, isArrayBuffer, (original) ->
  copy = new original.constructor original.byteLength
  new Uint8Array(copy).set new Uint8Array original
  copy

define clone, isTypedArray, (original) ->
  new original.constructor (clone original.buffer),
    original.byteOffset, original.length

define clone, isDataView, (original) ->
  new original.constructor (clone original.buffer),
    original.byteOffset, original.byteLength

# Only available within Node.js API. isBuffer will only match when Buffer is
# available on global. Otherwise, it returns false.
define clone, isBuffer, (original) ->
  Buffer.from original



cloneIterator = (original, add) ->
  copy = new original.constructor()
  add copy, entry for entry from original
  copy

define clone, isMap, (original) ->
  cloneIterator original, (copy, [key, value]) ->
    copy.set (clone key), (clone value)

define clone, isArray, (original) ->
  cloneIterator original, (copy, entry) -> copy.push clone entry

define clone, isSet, (original) ->
  cloneIterator original, (copy, entry) -> copy.add clone entry



isPrimitive = (x) -> (isBoolean x) || (isNumber x) || (isString x)

define clone, isPrimitive, identity

define clone, isDate, (original) ->
  new original.constructor original

define clone, isSymbol, (original) ->
  original.valueOf()

define clone, isRegExp, do (flags=/\w*$/) ->
  (original) ->
    copy = new original.constructor original.source, (flags.exec original)
    copy.lastIndex = original.lastIndex
    copy


define clone, isFunction, (original) ->
  throw new Error "clone: does not clone Function"

define clone, isWeakMap, (original) ->
  throw new Error "clone: does not clone WeakMap"

define clone, isError, (original) ->
  throw new Error "clone: does not clone Error"

export {clone}
