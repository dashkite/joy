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

xget = curry ( key, value ) ->
  if value?
    if ( isArray key )
      if ( key.length > 0 )
        do ({ first, rest } = {}) ->
          [ first, rest... ] = key
          xget rest, value[ first ]
      else value
    else
      xget ( key.split "." ), value

xset = curry ( key, value, object ) ->
  if ( isArray key )
    do ({ rest, last, target } = {}) ->
      [ rest..., last ] = key
      ( xget rest, object )?[ last ] = value
  else
    xset ( key.split "." ), value, object

xhas = curry ( key, target ) ->
  ( xget key, target )?

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
  xget
  xset
  xhas
}
