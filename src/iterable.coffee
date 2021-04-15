import {generic} from "./generic"
import {wrap, curry, binary} from "./function"
import {isArray} from "./type"

_includes = generic
  default: (a, ax) ->
    for _a from ax when a == _a
      return true

generic _includes, (wrap true), isArray, (a, ax) -> ax.includes a

includes = curry binary _includes

uniqueBy = (f, ax) ->
  bx = []
  (bx.push a) for a from ax when !(bx.find (b) -> f a, b)?
  bx

export {
  includes
  uniqueBy
}
