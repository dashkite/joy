import {arity, curry, tee, apply} from "./function"

negate = (f) -> arity f.length, (ax...) ->
  if (r = apply f, ax)?.then?
    r.then (x) -> !x
  else
    !r

# We don't use Promise.all and Promise.any here because we want
# to 'short-circuit' execution as soon as the predicate fails

isPromise = (value) -> value instanceof Promise

all = (px) ->
  arity px[0].length, (ax...) ->
    for p, i in px
      r = apply p, ax
      if isPromise r
        return r.then (r) ->
          if r == true
            if i == px.length - 1
              true
            else
              apply (all px[(i + 1)..]), ax
          else
            false
      else
        if r == false then return false
    true

any = (px) ->
  arity px[0].length, (ax...) ->
    for p, i in px
      r = apply p, ax
      if isPromise r
        return r.then (r) ->
          if r == true
            true
          else if i == px.length - 1
            false
          else
            apply (any px[(i + 1)..]), ax
      else
        if r == true then return true
    false

test = (f, g) ->
  arity g.length, (ax...) ->
    _f = (r) ->
      if r == true
        apply g, ax
        true
      else
        false
    if (r = apply f, ax).then? then (r.then _f) else (_f r)

branch = (fx) -> any ((test f, g) for [f, g] in fx)

_attempt = (f) ->
  (ax...) ->
    try
      r = apply f, ax
      if isPromise r
        r
          .then -> true
          .catch -> false
      else
        true
    catch
      false
      
attempt = (fx) ->
  any (_attempt f for f in fx)


export {
  negate
  any
  all
  test
  branch
  attempt
}
