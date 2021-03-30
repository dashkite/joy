import {arity, curry, tee, apply} from "./function"

negate = (f) -> arity f.length, (ax...) ->
  if (r = apply f, ax)?.then?
    r.then (x) -> !x
  else
    !r

# We don't use Promise.all and Promise.any here because we want
# to 'short-circuit' execution as soon as the predicate fails

_distribute = curry (c, [f, fx...]) ->
  (ax...) ->
    g = c fx, ax
    r = apply f, ax
    if fx.length > 0
      if r?.then? then (r.then g) else g r
    else
      r

_all = curry (px, ax, r) -> unless r then false else apply (all px), ax
all = _distribute _all

_any = curry (px, ax, r) -> if r then true else apply (any px), ax
any = _distribute _any

test = (f, g, h) ->
  arity g.length, (ax...) ->
    _f = (r) ->
      if r == true
        apply g, ax
      else if h?
        h ax...
    if (r = apply f, ax).then? then (r.then _f) else (_f r)

attempt = (f) ->
  arity f.length, (ax...) ->
    try
      if (r = f ax...).then?
        r
          .then -> true
          .catch -> false
      else
        true
    catch
      false

branch = (fx) -> any ((test f, g) for [f, g] in fx)

export {
  negate
  any
  all
  test
  branch
  attempt
}
