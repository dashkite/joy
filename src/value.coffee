import { identity, curry, binary } from "./function"
import { any, negate } from "./predicate"
import { generic } from "./generic"

import {
  isUndefined, isAny
  isSymbol, isRegExp,
  isBuffer, isArrayBuffer, isTypedArray, isDataView,
  isMap, isArray, isObject, isSet,
  isBoolean, isDate, isNumber, isString,
  isFunction, isWeakMap, isError
} from "./type"

hasEqual = (a) => a?.equal?
isNot = (a, b) -> !Object.is a, b
isPrimitive = (x) -> (isBoolean x) || (isNumber x) || (isString x)

equal = generic
  name: "equal"
  description: "Performs a deep comparison of two entities."
  default: (a, b) -> Object.is a, b

generic equal, isAny, hasEqual, (a, b) ->
  b.equal a

generic equal, hasEqual, isAny, (a, b) ->
  a.equal b

generic equal, isTypedArray, isTypedArray, (a, b) ->
  if (isNot a.length, b.length) || (isNot a.name, b.name)
    return false
  for i in [0..a.length]
    if isNot a[i], b[i]
      return false
  true

generic equal, isArrayBuffer, isArrayBuffer, (a, b) ->
  if isNot a.byteLength, b.byteLength
    return false
  equal (new Uint8Array a), (new Uint8Array b)

generic equal, isDataView, isDataView, (a, b) ->
  if (isNot a.byteLength, b.byteLength) || (isNot a.byteOffset, b.byteOffset)
    return false
  equal a.buffer, b.buffer

generic equal, isBuffer, isBuffer, (a, b) ->
  a.equals b

generic equal, isDate, isDate, (a, b) ->
  Object.is a.getTime(), b.getTime()

generic equal, isRegExp, isRegExp, (a, b) ->
  Object.is a.toString(), b.toString()

generic equal, isError, isError, (a, b) ->
  (equal a.name, b.name) && (equal a.message, b.message)

generic equal, isSymbol, isSymbol, (a, b) ->
  Object.is a.valueOf(), b.valueOf()

generic equal, isMap, isMap, (a, b) ->
  if isNot a.size, b.size
    return false
  for [key, value] from a
    if ! equal value, (b.get key)
      return false
  true

generic equal, isSet, isSet, (a, b) ->
  if isNot a.size, b.size
    return false
  for value from a
    if ! b.has value
      return false
  true

generic equal, isArray, isArray, (a, b) ->
  if isNot a.length, b.length
    return false
  for i in [0..a.length]
    if ! equal a[i], b[i]
      return false
  true

generic equal, isObject, isObject, (a, b) ->
  return true if Object.is a, b
  akeys = Object.keys a
  bkeys = Object.keys b
  return false if isNot akeys.length, bkeys.length
  for k in akeys when !(k in bkeys && equal a[k], b[k])
    return false
  true

generic equal, isPrimitive, isPrimitive, (a, b) ->
  Object.is a, b

equal = curry binary equal

notEqual = curry negate equal

eq = curry (a, b) -> Object.is a, b

neq = curry negate eq

clone = generic
  name: "clone"
  description: "Creates a deep clone of an entity."
  # When no match, throw to alert that we cannot deliver a deep clone.
  default: (entity) ->
    throw new Error "clone: no match on entity #{entity?.constructor?.name}"

isPrimitive = any [
  isUndefined
  isNumber
  isString
  isBoolean
]

generic clone, isPrimitive, identity

generic clone, isObject, (original) ->
  copy = new original.constructor()
  for key, value of original
    copy[key] = clone value
  copy

generic clone, isArrayBuffer, (original) ->
  copy = new original.constructor original.byteLength
  new Uint8Array(copy).set new Uint8Array original
  copy

generic clone, isTypedArray, (original) ->
  new original.constructor (clone original.buffer),
    original.byteOffset, original.length

generic clone, isDataView, (original) ->
  new original.constructor (clone original.buffer),
    original.byteOffset, original.byteLength

# Only available within Node.js API. isBuffer will only match when Buffer is
# available on global. Otherwise, it returns false.
generic clone, isBuffer, (original) ->
  Buffer.from original

cloneIterator = (original, add) ->
  copy = new original.constructor()
  add copy, entry for entry from original
  copy

generic clone, isMap, (original) ->
  cloneIterator original, (copy, [key, value]) ->
    copy.set (clone key), (clone value)

generic clone, isArray, (original) ->
  cloneIterator original, (copy, entry) -> copy.push clone entry

generic clone, isSet, (original) ->
  cloneIterator original, (copy, entry) -> copy.add clone entry

generic clone, isDate, (original) ->
  new original.constructor original

generic clone, isSymbol, (original) ->
  original.valueOf()

generic clone, isRegExp, do (flags=/\w*$/) ->
  (original) ->
    copy = new original.constructor original.source, (flags.exec original)
    copy.lastIndex = original.lastIndex
    copy

generic clone, isFunction, (original) ->
  throw new Error "clone: does not clone Function"

generic clone, isWeakMap, (original) ->
  throw new Error "clone: does not clone WeakMap"

generic clone, isError, (original) ->
  throw new Error "clone: does not clone Error"

size = generic
  name: "size"
  description: "Returns the size of a given entity, if it has one."
  default: (x) ->
    throw new TypeError "size: not valid for type #{x.constructor}"

hasLength = (x) -> x.length?
hasByteLength = (x) -> x.byteLength?
hasSize = (x) -> x.size?

generic size, hasByteLength, (x) -> x.byteLength
generic size, isObject, (x) -> (Object.keys x).length
generic size, hasSize, (x) -> x.size
generic size, hasLength, (x) -> x.length

isEmpty = (x) -> Object.is (size x), 0

export {
  equal
  notEqual
  eq
  neq
  clone
  size
  isEmpty
}
