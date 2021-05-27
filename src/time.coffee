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

export {
  sleep
  timer
  milliseconds
  benchmark
}
