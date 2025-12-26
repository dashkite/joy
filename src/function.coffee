identity = (x) -> x

wrap = (x) -> -> x

arity  = ( n, f ) ->
  Object.defineProperty f, "length", value: n, configurable: true
  f

unary = (f) -> arity 1, f

binary = (f) -> arity 2, f

ternary = (f) -> arity 3, f

flip = (f) ->
  arity f.length, ( args... ) -> 
    f.apply @, args.reverse()

curry = ( f ) ->
  k = f.length
  if k > 1
    arity k, ( ax... ) ->
      if ax.length >= k
        f.apply @, ax
      else
        curry arity ( k - ax.length ), ( bx... ) ->
          f.apply @, [ ax..., bx... ]
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

pipe = ([ f, gx... ]) ->
  if gx.length == 0
    f ? identity
  else
    do ({ g } = {}) ->
      g = pipe gx
      arity ( f.length ? 0 ), ( args... ) ->
        do ({ self, x } = { self: @ }) ->
          x = f.apply self, args
          if x?.then?
            x.then ( x ) ->
              g.apply self, [ x ]
          else
            g.apply self, [ x ]

flow = pipe

compose = (fx) -> pipe fx.reverse()

bpipe = pipe

bflow = pipe

bcompose = (fx) -> bpipe fx.reverse()

wait = (f) ->
  arity f.length, (ax...) ->
    Promise.all ax
      .then (ax) -> f ax...

tee = (f) ->
  arity (Math.max f.length, 1), (a, bx...) ->
    if (k = (f.apply @, [ a, bx... ]))?.then?
      k.then -> a
    else
      a

rtee = (f) ->
  arity (Math.max f.length, 1), (ax..., b) ->
    if (k = (f.apply @, [ ax..., b ]))?.then?
      k.then -> b
    else
      b

once = (f) ->
  do (k=undefined) ->
    arity f.length,
      (ax...) -> if k? then k else (k = f.apply @, ax)

memoize = (f) ->
  do (cache = {}) ->
    arity f.length, (ax...) ->
      cache[ JSON.stringify ax ] ?= f.apply @, ax

apply = curry (f, ax) -> f.apply null, ax

bind = curry (f, x) -> f.bind x

detach = (f) ->
  curry arity (f.length + 1), 
    (x, args...) -> f.apply x, args

send = curry (name, ax, object) -> object[name].apply object, ax

isPromise = (k) -> k instanceof Promise

chain = (f) ->
  arity (Math.max f.length, 1), (ax...) ->
    if (isPromise (k = (f.apply @, ax)))
      k.then => @
    else
      @

map = ( fx ) ->
  do ({ lengths, length } = {}) ->
    lengths = fx.map ( f ) -> f.length
    length = Math.max lengths...
    arity length, ( args... ) ->
      ( f.apply @, args ) for f in fx

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
  bpipe
  bcompose
  bflow
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
  bpipe
  bcompose
  bflow
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
