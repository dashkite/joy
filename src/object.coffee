import { curry } from "./function"
import { isObject, isArray, isFunction, isRegExp } from "./type"
import { equal, clone } from "./value"

keys = Object.keys

values = ( x ) -> v for k, v of x

pairs = ( x ) -> [ k, v ] for k, v of x

get = curry ( key, object ) -> object[ key ]

set = curry ( key, value, object ) ->
  object[ key ] = value
  object

has = curry (p, x) -> x?[ p ]?

mask = curry ( keys, a ) ->
  b = {}
  b[ key ] = a[ key ] for key in keys when a[ key ]?
  b

exclude = curry ( keys, a ) ->
  b = {}
  b[ key ] = value for key, value of a when key not in keys
  b

assign = ( target, source ) -> Object.assign target, source

merge = ( target, source ) -> Object.assign {}, target, source

query = curry ( example, target ) ->
  if (isObject example) && (isObject target)
    for k, v of example when !query v, target[k]
      return false
    true
  else
    equal example, target

tag = curry ( key, value ) -> [ key ]: value

foo = "bar"

export {
  keys
  values
  pairs
  get
  set
  has
  mask
  exclude
  assign
  merge
  query
  tag
}
