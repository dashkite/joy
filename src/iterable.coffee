import {generic} from "./generic"
import {wrap, curry, binary, ternary, tee, apply} from "./function"
import {negate} from "./predicate"
import {isString, isNumber, isArray, isFunction,
  isIterable, isReagent} from "./type"
import {get} from "./object"
isAny = wrap true

_includes = generic
  name: "includes"

generic _includes, (wrap true), isReagent, (a, ax) ->
  for await _a from ax
    return true if Object.is a, _a
  false

generic _includes, (wrap true), isIterable, (a, ax) ->
  for _a from ax
    return true if Object.is a, _a
  false

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
generic map, isFunction, isArray, (f, ax) -> ax.map (x) -> f x
map = curry binary map

project = curry (p, i) -> map (get p), i

find = generic name: "find"
generic find, isFunction, isIterable, (f, i) ->
  for x from i
    return x if (await f x) == true
  undefined
generic find, isFunction, isReagent, (f, r) ->
  for await x from r
    return x if (await f x) == true
  undefined
generic find, isFunction, isArray, (f, ax) -> ax.find (x) -> f x
find = curry binary find

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


partition = generic name: "partition"
generic partition, isNumber, isIterable, (n, i) ->
  batch = []
  for x from i
    batch.push x
    if batch.length == n
      yield batch
      batch = []
  if batch.length > 0
    yield batch

generic partition, isNumber, isReagent, (n, r) ->
  batch = []
  for await x from r
    batch.push x
    if batch.length == n
      yield batch
      batch = []
  if batch.length > 0
    yield batch


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
  project
  find
  tap
  select
  reject
  resolve
  collect
  start
  each
  reduce
  join
  partition
  Queue
  events
}
