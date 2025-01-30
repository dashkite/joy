import { curry } from "./function"
import { isObject, isArray, isFunction, isRegExp } from "./type"
import { equal, clone } from "./value"

keys = Object.keys

values = ( x ) -> v for k, v of x

pairs = ( x ) -> [ k, v ] for k, v of x

get = curry ( key, object ) -> object[ key ]

getx = curry 

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

collapse = curry ({ prefix, delimiter }, object ) ->
  delimiter ?= "."
  result = {}
  for key, value of object
    qkey = if prefix? then "#{ prefix }#{ delimiter }#{ key }" else key
    if isObject value
      Object.assign result, 
        collapse { prefix: qkey, delimiter }, value
    else
      result[ qkey ] = value
  result

expand = curry ({ delimiter }, object ) ->
  delimiter ?= "."
  result = {}
  for key, value of object
    [ keys..., last ] = key.split delimiter
    current = result
    for subkey in keys
      current = ( current[ subkey ] ?= {} )
    current[ last ] = value
  result

getx = curry ( key, object ) ->
  if object?
    if ( isArray key )
      do ({ first, rest } = {}) ->
        [ first, rest... ] = key
        if rest.length > 0
          if object[ first ]?
            getx rest, object[ first ]
        else
          object[ first ]
    else
      getx ( key.split "." ), object

setx = curry ( key, value, object ) ->
  if object?
    if ( isArray key )
      do ({ first, last, target } = {}) ->
        [ first, rest... ] = key
        if rest.length > 0
          object[ first ] ?= {}
          setx rest, value, object[ first ]
        else
          object[ first ] = value
    else
      setx ( key.split "." ), value, object

hasx = curry ( key, target ) ->
  ( getx key, target )?

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
  expand
  collapse
  getx
  setx
  hasx
}
