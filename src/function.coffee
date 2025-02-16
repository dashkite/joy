identity = (x) -> x

wrap = (x) -> -> x

# Based on _arity from Rambda:
# https://github.com/ramda/ramda/blob/v0.26.1/source/internal/_arity.js
arity  = (N, f) ->
  switch N
    when 0
      (ax...) -> f.apply @, ax
    when 1
      (a0) -> f.apply @, arguments
    when 2
      (a0, a1)  -> f.apply @, arguments
    when 3
      (a0, a1, a2) -> f.apply @, arguments
    when 4
      (a0, a1, a2, a3) -> f.apply @, arguments
    when 5
      (a0, a1, a2, a3, a4) -> f.apply @, arguments
    when 6
      (a0, a1, a2, a3, a4, a5) -> f.apply @, arguments
    when 7
      (a0, a1, a2, a3, a4, a5, a6) -> f.apply @, arguments
    when 8
      (a0, a1, a2, a3, a4, a5, a6, a7) -> f.apply @, arguments
    when 9
      (a0, a1, a2, a3, a4, a5, a6, a7, a8) -> f.apply @, arguments
    when 10
      (a0, a1, a2, a3, a4, a5, a6, a7, a8, a9) -> f.apply @, arguments
    else
      throw new Error "First argument to arity must be an integer between 0 and 10, inclusive."

unary = (f) -> arity 1, f

binary = (f) -> arity 2, f

ternary = (f) -> arity 3, f

flip = (f) ->
  switch f.length
    when 0
      f
    when 1
      (a0) -> f.call @, a0
    when 2
      (a0, a1)  -> f.call @, a1, a0
    when 3
      (a0, a1, a2) -> f.call @, a2, a1, a0
    when 4
      (a0, a1, a2, a3) -> f.call @, a3, a2, a1, a0
    when 5
      (a0, a1, a2, a3, a4) -> f.call @, a4, a3, a2, a1, a0
    when 6
      (a0, a1, a2, a3, a4, a5) -> f.call @, a5, a4, a3, a2, a1, a0
    when 7
      (a0, a1, a2, a3, a4, a5, a6) -> f.call @, a6, a4, a3, a2, a1, a0
    when 8
      (a0, a1, a2, a3, a4, a5, a6, a7) ->
        f.call @, a7, a6, a5, a4, a3, a2, a1, a0
    when 9
      (a0, a1, a2, a3, a4, a5, a6, a7, a8) ->
        f.call @, a8, a7, a6, a5, a4, a3, a2, a1, a0
    when 10
      (a0, a1, a2, a3, a4, a5, a6, a7, a8, a9) ->
        f.call @, a9, a8, a7, a6, a5, a4, a3, a2, a1, a0
    else
      (ax...) -> f.apply @, ax.reverse()

curry = (f) ->
  if f.length > 1
    arity f.length, (ax...) ->
      self = @
      if ax.length >= f.length
        f.apply self, ax
      else
        length = f.length - ax.length
        if length == 1
          (x) -> f.apply self, [ ax..., x ]
        else
          curry arity length, (bx...) -> f.apply self, [ ax..., bx... ]
  else f

_ = {}

substitute = curry (ax, bx) ->
  i = 0
  for a in ax
    if a == _
      bx[i++]
    else
      a

partial = (f, ax) ->
  n = 0
  for a in ax when a == _
    n++
  arity n, (bx...) -> f (substitute ax, bx)...

spread = (f) -> (ax) -> f ax...

stack = (f) -> (ax...) -> f ax

pipe = ( fx ) ->
  do ( n = fx[ 0 ].length ) ->    
    arity n, ( args... ) ->
      for f in fx
        args = [ f args... ]
      args[ 0 ]

flow = ( fx ) ->
  do ( n = fx[ 0 ].length ) ->    
    arity n, ( args... ) ->
      for f in fx
        args = [ await f args... ]
      args[ 0 ]

compose = (fx) -> pipe fx.reverse()

wait = (f) ->
  arity f.length, (ax...) ->
    Promise.all ax
      .then (ax) -> f ax...

tee = (f) ->
  arity (Math.max f.length, 1), (a, bx...) ->
    self = @
    if (k = (f.apply self, [ a, bx... ]))?.then?
      k.then -> a
    else
      a

rtee = (f) ->
  arity (Math.max f.length, 1), (ax..., b) ->
    self = @
    if (k = (f.apply self, [ ax..., b ]))?.then?
      k.then -> b
    else
      b

once = (f) ->
  do (k=undefined) ->
    arity f.length,
      (ax...) -> if k? then k else (k = apply f, ax)

memoize = (f) ->
  do (cache = {}) ->
    arity f.length, (ax...) ->
      cache[ JSON.stringify ax ] ?= apply f, ax

apply = curry (f, ax) -> f.apply null, ax

bind = curry (f, x) -> f.bind x

detach = (f) ->
  curry arity (f.length + 1), 
    (x, args...) -> f.apply x, args

send = curry (name, ax, object) -> object[name].apply object, ax

isPromise = (k) -> k instanceof Promise

chain = (f) ->
  arity (Math.max f.length, 1), (ax...) ->
    self = @
    if (isPromise (k = (f.apply self, ax)))
      k.then -> self
    else
      self

map = ( fx ) ->
  do ({ lengths, length } = {}) ->
    lengths = fx.map ( f ) -> f.length
    length = Math.max lengths...
    arity length, ( args... ) ->
      ( f args... ) for f in fx

proxy = curry (name, ax) ->
  (bx...) -> @[name].apply @, [ ax..., bx... ]

export {
  identity
  wrap
  arity
  unary
  binary
  ternary
  flip
  curry
  _
  substitute
  partial
  spread
  stack
  pipe
  compose
  wait
  flow
  tee
  rtee
  once
  memoize
  apply
  bind
  detach
  send
  chain
  map
  proxy
}

export default {
  identity
  wrap
  arity
  unary
  binary
  ternary
  flip
  curry
  _
  substitute
  partial
  spread
  stack
  pipe
  compose
  wait
  flow
  tee
  rtee
  once
  memoize
  apply
  bind
  detach
  send
  chain
  map
  proxy
}
