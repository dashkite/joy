import {curry, pipe, detach} from "./function"
import { isString, isNumber } from "./type"
import {isEmpty} from "./value"

toString = (x) -> x.toString()

toBase = curry (radix, number) ->
  if (isNumber radix) && (isNumber number)
    if 2 <= radix <= 36
      number.toString radix
    else
      throw new TypeError "toBase: radix must between 2 and 36"
  else
    throw new TypeError "toBase: arguments must be numbers"

toUpperCase = toUpper = detach String::toUpperCase

toLowerCase = toLower = detach String::toLowerCase

trim = detach String::trim

trimStart = detach String::trimStart

trimEnd = detach String::trimEnd

replace = curry (pattern, replacement, string) ->
  string.replace pattern, replacement

collapse = (s) -> replace /\s+/g, " ", trim s

# adapted from https://github.com/VitorLuizC/normalize-text
normalize = (string) ->
  string
  .normalize "NFKD"
  .replace /[\u0300-\u036F]/g, ""

uncase = (string) ->
  string
    .replace /^[A-Z]/g, (c) -> c.toLowerCase()
    .replace /[A-Z]/g, (c) -> " #{c.toLowerCase()}"
    .replace /[_-]/g, " "

gloss = (string) ->
  (toLowerCase collapse normalize string).replace( /[^A-Za-z0-9 ]+/g, "" )


# camelCase
#
# capitalize


# startsWith
#
# endsWith
#
# dashed
#
# pad
#
# padStart
#
# padEnd
#
# parseInt
#
# repeat
#
# underscored
#
# titleCase

# trimStart
#
# trimEnd
#
# truncate



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

template = (string, filters = {}) ->
  do ({ key, apply } = {}) ->
    filters = Object.assign {},
      {toString, toUpperCase, toLowerCase, trim},
      filters
    apply = (string, name) -> filters[name] string
    (context) ->
      string.replace /\{\{([\s\S]+)\}\}/g, (_, target) ->
        [key, names...] = target.split("|").map trim
        names.reduce apply, context[key]

export {
  toString
  toBase
  toUpperCase
  toLowerCase
  collapse
  normalize
  uncase
  gloss
  trim
  split
  w
  isBlank
  match
  isMatch
  replace
  template
}
