import {curry, flip, compose, partial, _, identity,
  unary, binary, ternary, detach} from "./function"
import {equal} from "./value"

nth = curry (i, ax) -> ax[i - 1]
first  = nth 1
second = nth 2
third  = nth 3
fourth = nth 4
fifth  = nth 5
last = ([rest..., last]) -> last
rest = ([first, rest...]) -> rest

# curryable index variations that can use ? operator or equivalent
# ex: if (i = findIndexOf ax, a)? then ...
findIndexOf = curry (a, ax) -> if (i = ax.indexOf a) != -1 then i
findLastIndexOf = curry (a, ax) -> if (i = ax.lastIndexOf a) != -1 then i

# Array mutators
push = curry (ax, a...) -> ax.push a...; ax
pop = detach Array::pop
shift = detach Array::shift
unshift = detach Array::unshift
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

remove = curry (ax, a) ->
  (ax.splice i, 1) if (i = ax.indexOf( a )) != -1
  ax

cat = detach Array::concat

slice = curry (i, j, ax) -> ax[i...j]

sort = curry binary detach Array::sort
join = curry binary detach Array::join
fill = curry (ax, a) -> ax.fill a

range = curry (start, finish) -> [start..finish]

{random, round} = Math
pluck = (ax) -> ax[(round random() * (ax.length - 1))]

pair = curry (a, b) -> [a, b]

# https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle
#
{floor, random} = Math
shuffle = (ax) ->
  bx = cat ax
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
  findIndexOf
  findLastIndexOf
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
  join
  fill
  range
  pluck
  pair
  shuffle
}
