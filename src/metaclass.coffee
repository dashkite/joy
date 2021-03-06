import {curry} from "./function"
import {merge} from "./object"

property = curry (key, description, target) ->
  Object.defineProperty target, key,
    merge { enumerable: true, configurable: true }, description

getter = curry (key, f, target) -> property key, {get: f}, target
setter = curry (key, f, target) -> property key, {set: f}, target
method = curry (key, f, target) ->
  property key, {value: f, configurable: true, writeable: true}, target

properties = curry (dictionary, target) ->
  for key, description of dictionary
    property key, description, target

getters = curry (dictionary, target) ->
  for key, f of dictionary
    getter key, f, target

setters = curry (dictionary, target) ->
  for key, f of dictionary
    setter key, f, target

methods = curry (dictionary, target) ->
  for key, f of dictionary
    method key, f, target

mixin = curry (target, fx) -> f target for f in fx ; target

export {
  property
  getter
  setter
  method
  properties
  getters
  setters
  methods
  mixin
}
