import {curry} from "panda-garden"
import Method from "panda-generics"
import {promise} from "./promise"
import {isFunction, isAsyncFunction} from "./type"

{create, define} = Method

timer = (wait, action) ->
  id = setTimeout(action, wait)
  -> clearTimeout( id )

sleep = (interval) ->
  promise (resolve, reject) ->
    timer interval, -> resolve()

# benchmark = create
#   name: "benchmark"
#   description: "Time a function's execution with up to microsecond resolution"
#
# define benchmark, isFunction, (fn) ->
#   start = microseconds()
#   fn()
#   microseconds() - start
#
# define benchmark, isAsyncFunction, (fn) ->
#   start = microseconds()
#   await fn()
#   microseconds() - start

export {
  sleep
  timer
  # benchmark
}
