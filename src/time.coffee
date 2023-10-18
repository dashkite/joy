import {curry} from "./function"

timer = curry (interval, action) ->
  id = setTimeout(action, interval)
  -> clearTimeout( id )

sleep = (interval) ->
  new Promise (resolve) -> setTimeout resolve, interval


milliseconds =
  if performance?
    -> performance.now()
  else
    -> Date.now()

benchmark = (f) ->
  start = milliseconds()
  if (r = f())?.then?
    r.then -> milliseconds() - start
  else
    milliseconds() - start

debounce = do ( last = 0 ) ->
  ( interval, f ) -> ->
    now = Date.now()
    if ( now - last ) > interval
      last = now
      do f

export {
  sleep
  timer
  milliseconds
  benchmark
  debounce
}

export default {
  sleep
  timer
  milliseconds
  benchmark
  debounce
}
