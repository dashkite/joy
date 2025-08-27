import {curry} from "./function"

union = ( ax, bx ) ->
  ( new Set ax ).union ( new Set bx )

intersection = curry ( ax, bx ) ->
  ( new Set ax ).intersection ( new Set bx )

symmetricDifference = ( ax, bx ) ->  
  ( new Set ax ).symmetricDifference ( new Set bx )

difference = ( ax, bx ) ->
  ( new Set ax ).difference ( new Set bx )

unique = ( ax ) -> new Set ax

duplicates = ( ax ) ->
  bx = new Set # items we've seen at least once
  cx = new Set # items we've seen at least twice
  for a from ax
    if bx.has a then cx.add a else bx.add a
  cx

export {
  union
  intersection
  symmetricDifference
  difference
  unique
  duplicates
}
