import {curry, flip, compose, partial, _, identity,
  unary, binary, ternary, detach} from "./function"
import {equal} from "./value"
import * as Se from "./set"

nth = curry (i, ax) -> ax[i - 1]
first  = nth 1
second = nth 2
third  = nth 3
fourth = nth 4
fifth  = nth 5
last = ([rest..., last]) -> last
rest = ([first, rest...]) -> rest

# Array mutators
push = curry (ax, a) -> ax.push a; ax
pop = detach Array::pop
shift = detach Array::shift
unshift = curry (a, ax) -> ax.unshift a; ax
enqueue = unshift
dequeue = pop

# true splice without weird insertion option
# or compose-breaking return value
splice = curry (i, n, ax) ->
  ax.splice i, n
  ax

insert = curry (i, a, ax) ->
  ax.splice i, 0, a
  ax

remove = curry (a, ax) ->
  (ax.splice i, 1) if (i = ax.indexOf( a )) != -1
  ax

cat = detach Array::concat

slice = curry (i, j, ax) -> ax[i...j]

fill = curry (a, ax) -> ax.fill a

range = curry (start, finish) -> [start..finish]

{random, round} = Math
pluck = (ax) -> ax[(round random() * (ax.length - 1))]

pair = curry (a, b) -> [a, b]

sort = curry (f, ax) -> ax.toSorted f, ax

compact = curry ( ax ) -> ax.filter ( a ) -> a?

union = compose [
  Array.from
  Se.union
]

intersection = compose [
  Array.from
  Se.intersection
]

complement = compose [
  Array.from
  Se.complement
]

difference = compose [
  Array.from
  Se.difference
]

unique = compose [
  Array.from
  Se.unique
]

dupes = compose [
  Array.from
  Se.dupes
]


# https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle
#
{ floor, random } = Math
shuffle = ( ax ) ->
  bx = [ ax... ]
  i = bx.length
  unless i <= 1
    while --i > 0
      # the distinguishing characteristic of fisher-yates is that the random
      # value generated is bounded by the iterator index (Math.random() * i)
      # instead of the size of the array (Math.random() * bx.length)
      j = floor random() * (i + 1)
      [bx[i], bx[j]] = [bx[j], bx[i]]
    if equal ax, bx then shuffle ax else bx
  else
    bx

export {
  first
  second
  third
  fourth
  fifth
  nth
  last
  rest
  push
  pop
  shift
  unshift
  enqueue
  dequeue
  splice
  insert
  remove
  cat
  slice
  fill
  range
  pluck
  pair
  sort
  compact
  union
  intersection
  complement
  difference
  unique
  dupes
  shuffle
}
