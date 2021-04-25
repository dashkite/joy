import {curry} from "./function"
import Method from "panda-generics"

{create, define} = Method

prototype = (value) -> if value? then Object.getPrototypeOf value

isPrototype = curry (p, value) -> p? && p == prototype value

isType = curry (type, value) -> isPrototype type?.prototype, value

isTransitivePrototype = curry (p, value) ->
  p? && (p == (q = prototype value) || (q? && isTransitivePrototype p, q))

# we don't use instanceof because it throws if the type argument is not a type
isKind = curry (type, value) -> isTransitivePrototype type?.prototype, value

# TODO: is this correct? to check generally for a derived type
# needs tests ....
# isDerived = curry (type, value) -> isKind type, value::

isNumber = isType Number

isNaN = Number.isNaN

isFinite = Number.isFinite

isInteger = Number.isInteger

isBoolean = isType Boolean

isSymbol = isType Symbol

isDate = isType Date

isRegExp = isType RegExp

isString = isType String

isRegularFunction = isType Function

isObject = isType Object

isArray = Array.isArray

isMap = isType Map

isWeakMap = isType WeakMap

isSet = isType Set

isError = isType Error

isDefined = (x) -> x?

isUndefined = (x) -> !x?

GeneratorFunction = (-> yield null).constructor

isGeneratorFunction = isType GeneratorFunction

isPromise = isType Promise

isAsyncFunction = isType (-> await null).constructor

isFunction = isKind Function

instanceOf = curry (t, x) -> x instanceof t

Type =
  create: (type) -> new type
  define: (parent = Object) -> class extends parent

if Buffer?
  isBuffer = isType Buffer
else
  isBuffer = (x) -> false

isArrayBuffer = isType ArrayBuffer
isDataView = isType DataView
isTypedArray = isKind prototype Uint8Array

isIterable = (x) ->
  (isFunction x?[Symbol.iterator]) || (isGeneratorFunction x)

isIterator = (x) -> (isFunction x?.next) && (isIterable x)

isReagent = isAsyncIterable = (x) ->
  (isFunction x?[Symbol.asyncIterator]) || (isAsyncGeneratorFunction x)

isReactor = isAsyncIterator = (x) -> (isFunction x?.next) && (isReagent x)

areType = curry (type, array) ->
  return false unless isArray array
  for item in array
    return false unless isType type, item
  true

areKind = curry (kind, array) ->
  return false unless isArray array
  for item in array
    return false unless isKind kind, item
  true

export {
  prototype
  isPrototype
  isTransitivePrototype
  isType
  isKind
  Type
  instanceOf
  isDefined
  isUndefined
  isBoolean
  isString
  isSymbol
  isNumber
  isNaN
  isFinite
  isInteger
  isDate
  isError
  isRegExp
  isPromise
  isObject
  isArray
  isMap
  isWeakMap
  isSet
  isRegularFunction
  isGeneratorFunction
  isAsyncFunction
  isFunction
  isBuffer
  isArrayBuffer
  isDataView
  isTypedArray
  isIterable
  isIterator
  isReagent
  isAsyncIterable
  isReactor
  isAsyncIterator
  areType
  areKind
}
