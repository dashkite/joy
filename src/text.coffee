import {curry, pipe} from "./function"
import {isString} from "./type"
import {isEmpty} from "./value"

toString = (x) -> x.toString()

toUpperCase = (s) -> s.toUpperCase()

toLowerCase = (s) -> s.toLowerCase()

plainText = (string) ->
  string
    .replace( /^[A-Z]/g, (c) -> c.toLowerCase() )
    .replace( /[A-Z]/g, (c) -> " #{c.toLowerCase()}" )
    .replace( /\W+/g, " " )


trim = (s) -> s.trim()

split = curry (re, s) -> s.split re

w = pipe [
  trim
  split /\s+/
]

isBlank = (s) -> (isString s) && (isEmpty s)

match = curry (pattern, string) -> string.match pattern

isMatch = curry (pattern, string) -> pattern.test string

replace = curry (pattern, replacement, string) ->
  string.replace pattern, replacement

export {
  toString
  toUpperCase
  toLowerCase
  trim
  split
  w
  isBlank
  match
  isMatch
  replace
}
