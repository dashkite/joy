import {_, curry, partial, apply} from "./function"
import {negate} from "./predicate"

# `eq` and `neq` were here, but I moved them to the value module. 
# TODO: How do we deal with naming overlap? 

gte = curry (x, y) -> y >= x
lte = curry (x, y) -> y <= x
gt = curry (x, y) -> y > x
lt = curry (x, y) -> y < x

add = curry (x, y) -> x + y
sub = curry (x, y) -> y - x
mul = curry (x, y) -> x * y
div = curry (x, y) -> y / x
mod = curry (x, y) -> y % x

isModulo = curry (x, y) -> y % x == 0
even = isModulo 2
odd = negate even

min = (ax) -> apply Math.min, ax
max = (ax) -> apply Math.max, ax

{abs} = Math

pow = curry (x, y) -> x ** y

square = partial pow, [ _, 2 ]
cube = partial pow, [ _, 3 ]

export {gt, lt, gte, lte, add, sub, mul, div, mod,
  isModulo, even, odd, min, max, abs, pow, square, cube}
