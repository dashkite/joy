import {generic} from "./generic"
import {wrap, curry, binary, ternary, tee, apply} from "./function"
import {isString, isArray, isFunction, isIterable, isReagent} from "./type"
isAny = wrap true

_includes = generic
  name: "includes"

generic _includes, (wrap true), isIterable, (a, ax) ->
  for _a from ax when a == _a
    return true

generic _includes, (wrap true), isArray, (a, ax) ->
  ax.includes a

includes = curry binary _includes

uniqueBy = (f, ax) ->
  bx = []
  (bx.push a) for a from ax when !(bx.find (b) -> f a, b)?
  bx

map = generic name: "map"
generic map, isFunction, isIterable, (f, i) -> yield (f x) for x from i
generic map, isFunction, isReagent, (f, r) -> yield (f x) for await x from r
generic map, isFunction, isArray, (f, ax) -> ax.map f
map = curry binary map

tap = generic name: "tap"
generic tap, isFunction, isIterable,
  (f, i) -> yield ((tee f) x) for x from i
generic tap, isFunction, isReagent,
  (f, r) -> yield ((tee f) x) for await x from r
tap = curry binary tap

select = generic name: "select"
generic select, isFunction, isIterable,
  (f, i) -> yield x for x from i when f x
generic select, isFunction, isReagent,
  (f, r) -> yield x for await x from r when f x
generic select, isFunction, isArray,
  (f, ax) -> ax.filter f
select = curry binary select

reject = curry (f, i) -> select (negate f), i

resolve = curry (filter, producer) ->
  yield await x for await x from filter producer

collect = generic name: "start"
generic collect, isIterable, (i) -> Array.from i
generic collect, isReagent, (r) -> x for await x from r

start = generic name: "start"
generic start, isIterable, (i) -> undefined for x from i ; undefined
generic start, isReagent, (r) -> undefined for await x from r ; undefined

each = generic name: "each"
generic each, isFunction, isIterable,
  (f, i) -> f x for x from i ; undefined
generic each, isFunction, isReagent,
  (f, r) -> f x for await x from r ; undefined
generic each, isFunction, isArray,
  (f, ax) -> ax.forEach f
each = curry binary each

reduce = generic name: "fold/reduce"
generic reduce, isFunction, isAny, isIterable,
  (f, k, i) -> (k = f k, x) for x from i ; k
generic reduce, isFunction, isAny, isReagent,
  (f, k, r) -> (k = f k, x) for await x from r ; k
generic reduce, isFunction, isAny, isArray,
  (f, k, ax) -> ax.reduce f, k
reduce = fold = curry ternary reduce

join = generic name: "join"
generic join, isFunction, isIterable, (f, i) ->
  n = 0
  for x from i
    r = if n++ > 0 then f r, x else x
  r

generic join, isFunction, isReagent, (f, i) ->
  n = 0
  for await x from i
    r = if n++ > 0 then f r, x else x
  r
generic join, isString, isIterable, (a, i) ->
  join a, collect i

generic join, isString, isReagent, (a, i) ->
  join a, await collect i

generic join, isString, isArray, (a, ax) -> ax.join a

join = curry binary join

class Queue
  @create: -> new Queue
  constructor: ->
    @q = []
    @p = []
  enqueue: (value) ->
    if @p.length > 0
      apply @p.shift(), [ value ]
    else
      @q.push value
  dequeue: ->
    if @q.length > 0
      @q.shift()
    else
      new Promise (resolve) => @p.push resolve
  isIdle: -> @p.length == 0 && @q.length == 0


events = curry (name, source) ->
  q = Queue.create()
  if source.on?
    source.on name, (event) -> q.enqueue event
  else if source.addEventListener?
    source.addEventListener name, (event) -> q.enqueue event
  else throw new TypeError "events: source must support
    `on` or `addEventListener` method"
  loop yield await q.dequeue()

export {
  includes
  uniqueBy
  map
  tap
  select
  reject
  resolve
  collect
  start
  each
  reduce
  join
  Queue
  events
}
