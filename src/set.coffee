import {curry} from "./function"

union = (ax, bx) ->
  cx = new Set ax
  cx.add b for b from bx
  cx

intersection = curry (ax, bx) ->
  bx = new Set bx
  cx = new Set
  cx.add a for a from ax when bx.has a
  cx

complement = (ax, bx) ->
  ax = new Set ax
  bx = new Set bx
  cx = new Set
  dx = union ax, bx
  cx.add d for d from dx when !(bx.has d) || !(ax.has d)
  cx

difference = (ax, bx) ->
  bx = new Set bx
  cx = new Set
  cx.add a for a from ax when !(bx.has a)
  cx

unique = (ax) -> new Set ax

dupes = (ax) ->
  bx = new Set # items we've seen at least once
  cx = new Set # items we've seen at least twice
  for a from ax
    if bx.has a then cx.add a else bx.add a
  cx

export {
  union
  intersection
  complement
  difference
  unique
  dupes
}
