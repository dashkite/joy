import {curry, negate} from "panda-garden"
import {isObject, isArray, isFunction, isRegExp} from "./type"
import {equal} from "./equal"

bind = curry (f, x) -> f.bind x

detach = (f) -> curry (x, args...) -> f.apply x, args

keys = Object.keys

values = (x) -> v for k, v of x

pairs = (x) -> [k, v] for k, v of x

get = curry (key, object) -> object[key]

set = curry (key, value, object) ->
  object[key] = value
  object

has = curry (p, x) -> x[p]?

include = (target, sources...) -> Object.assign target, sources...

merge = (objects...) -> Object.assign {}, objects...

query = curry (example, target) ->
  if (isObject example) && (isObject target)
    for k, v of example when !query v, target[k]
      return false
    true
  else
    equal example, target

export {
  bind
  detach
  keys
  values
  pairs
  get
  set
  has
  include
  merge
  query
}
