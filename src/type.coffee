import { curry } from "./function"
import { any } from "./predicate"

prototype = (value) -> if value? then Object.getPrototypeOf value

isPrototype = curry (p, value) -> p? && p == prototype value

isType = curry (type, value) -> isPrototype type?.prototype, value

isSynonymousType = curry (type, value) ->
  type?.name == value.constructor.name

isKind = curry (type, value) ->
  try
    value instanceof type
  catch
    false

isSynonymousKind = curry (type, value) ->
  value? && ((isSynonymousType type, value) ||
    (isSynonymousKind type, (prototype value)))

# TODO: is this correct? to check generally for a derived type
# needs tests ....
# isDerived = curry (type, value) -> isKind type, value::

isNumber = any [
  isType Number
  isType BigInt
]

isNaN = Number.isNaN

isFinite = Number.isFinite

isInteger = Number.isInteger

isBigInt = isType BigInt

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

isError = isKind Error

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

isIterable = (x) -> isFunction x?[Symbol.iterator]

isIterator = (x) -> (isFunction x?.next) && (isIterable x)

isReagent = isAsyncIterable = (x) -> isFunction x?[Symbol.asyncIterator]

isReactor = isAsyncIterator = (x) -> (isFunction x?.next) && (isReagent x)

export {
  prototype
  isPrototype
  isType
  isKind
  isSynonymousType
  isSynonymousKind
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
  isBigInt
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
}
