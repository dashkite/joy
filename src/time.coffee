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

benchmark = ( task ) ->
  ( await measure "anonymous", task )
    .duration

measure = ( name, task ) ->
  do ({ finish, measure, result } = {}) ->
    performance.mark "#{ name }-start"
    finish = ->
      performance.mark "#{ name }-finish"
      measure = performance.measure "#{ name }", 
        "#{ name }-start", "#{ name }-finish"
      measure
    result = task()
    if result.then? then ( result.then finish ) else finish()

debounce = do ( last = 0 ) ->
  ( interval, f ) -> ->
    now = Date.now()
    if ( now - last ) > interval
      last = now
      do f

# from Wayland

frame = ->
  new Promise ( resolve ) ->
    queueMicrotask resolve

# we're forced to use Date.now below
# because Node doesn't include it as a global
expect = ->
  args = arguments
  do ({ options, predicate, start, result, done } = {}) ->

    [ options, predicate ] = switch args.length
      when 1 then [{}, args... ]
      when 2 then args
      else throw new Error "expect: invalid arguments"

    options.timeout ?= 1000
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
  measure
  debounce
  frame
  expect
}

export default {
  sleep
  timer
  milliseconds
  benchmark
  measure
  debounce
  frame
  expect
}
