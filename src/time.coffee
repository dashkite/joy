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

frame = ->
  new Promise ( resolve ) ->
    queueMicrotask resolve

# we're forced to use Date.now below
# because Node doesn't include it as a global
expect = ->
  args = arguments
  do ({ options, predicate, start, result, done } = {}) ->

    [ options, predicate ] = switch args.length
      when 1 then [{ timeout: 1000 }, args... ]
      when 2 then args
      else throw new Error "expect: invalid arguments"

    start = Date.now()

    done = ->
      ( result = predicate()) ||
        (( Date.now() - start ) > options.timeout )

    result = false

    new Promise ( resolve ) ->
      ( await sleep 1) while !done()
      resolve result

export {
  sleep
  timer
  milliseconds
  benchmark
  debounce
  frame
  expect
}

export default {
  sleep
  timer
  milliseconds
  benchmark
  debounce
  frame
  expect
}
