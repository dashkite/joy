import {arity, unary, binary, ternary, flip} from "./arity"

identity = (x) -> x

wrap = (x) -> -> x

curry = (f) ->
  arity f.length, (ax...) ->
    if ax.length >= f.length
      f ax...
    else
      length = f.length - ax.length
      if length == 1
        (x) -> f ax..., x
      else
        curry arity length, (bx...) -> f ax..., bx...

_ = {}

substitute = curry (ax, bx) ->
  i = 0
  for a in ax
    if a == _
      bx[i++]
    else
      a

partial = (f, ax) ->
  arity (f.length - ax.length),
    (bx...) -> f (substitute ax, bx)...

spread = (f) -> (ax) -> f ax...

variadic = (f) -> (ax...) -> f ax

# Inspired by Rambda: https://ramdajs.com/docs/#pipeWith
pipeWith = curry (c, fx) ->
  (ax...) ->
    for f, i in fx
      try
        ax = [ (c f) ax... ]
      catch error
        report f, i, error
    return ax[0]


pipe = pipeWith identity

compose = flip pipe

wait = (f) ->
  arity f.length, (ax...) ->
    Promise.all ax
      .then (ax) -> f ax...

flow = pipeWith wait

tee = (f) ->
  arity (Math.max f.length, 1), (a, bx...) ->
    if (k = (f a, bx...))?.then?
      k.then -> a
    else
      a

rtee = (f) ->
  arity (Math.max f.length, 1), (ax..., b) ->
    if (k = (f ax..., b))?.then?
      k.then -> b
    else
      b

negate = (f) -> (ax...) -> !(f ax...)

once = (f) ->
  do (k=undefined) ->
    -> if k? then k else (k = f())

memoize = (f) ->
  do (cache={}) -> (args...) -> cache[args] ?= f args...

call = (f, ax...) -> (f ax...)

apply = (f, ax) -> (f ax...)

export {identity, wrap, curry,
  arity, unary, binary, ternary,
  _, substitute, partial,
  spread, variadic, flip,
  pipeWith, pipe, compose, wait, flow,
  tee, rtee,
  negate,
  once, memoize,
  call, apply}
