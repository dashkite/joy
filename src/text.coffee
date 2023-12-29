import {curry, pipe, detach} from "./function"
import { isString, isNumber, isBigInt } from "./type"
import {isEmpty} from "./value"

toString = (x) -> x.toString()

toBase = curry (radix, number) ->
  if (isNumber radix) && ((isNumber number) || isBigInt number)
    if 2 <= radix <= 36
      number.toString radix
    else
      throw new TypeError "toBase: radix must between 2 and 36"
  else
    throw new TypeError "toBase: arguments must be numbers"

fromBase = curry (radix, string) -> Number.parseInt string, radix

parseNumber = (string) -> Number string

match = curry (pattern, string) -> string.match pattern

isMatch = curry (pattern, string) -> pattern.test string

replace = curry (pattern, replacement, string) ->
  string.replace pattern, replacement

toUpperCase = toUpper = detach String::toUpperCase

toLowerCase = toLower = detach String::toLowerCase

trim = detach String::trim

trimStart = detach String::trimStart

trimEnd = detach String::trimEnd

collapse = (s) -> replace /\s+/g, " ", trim s

# adapted from https://github.com/VitorLuizC/normalize-text
normalize = (string) ->
  string
  .normalize "NFKD"
  .replace /[\u0300-\u036F]/g, ""

uncase = pipe [
  replace /^[A-Z]/g, (c) -> R.toLowerCase()
  replace /[A-Z]/g, (c) -> " #{c.toLowerCase()}"
  replace /[_-]/g, " "
]

gloss = pipe [
  normalize
  collapse
  toLowerCase
  replace /[^A-Za-z0-9 ]+/g, ""
]

camelCase = pipe [
  uncase
  gloss
  replace /\s\w/g, pipe [
    trim
    toUpperCase
  ]
]

dashed = dashes = dash = pipe [
  uncase
  gloss
  replace /\s/g, (s) -> "-"
]

underscored = underscores = underscore = snakeCase = pipe [
  uncase
  gloss
  replace /\s/g, (s) -> "_"
]

capitalize = (string) -> (toUpperCase string[0]) + string[1..]

titleCase = replace /\b\w/g, toUpperCase

startsWith = curry (target, string) -> string.startsWith target

endsWith = curry (target, string) -> string.endsWith target

padEnd = curry (n, padding, string) -> string.padEnd n, padding

padStart = curry (n, padding, string) -> string.padStart n, padding

pad = curry (n, padding, string) ->
  padStart n, padding,
    padEnd (Math.ceil (n - string.length)/2) + string.length, padding, string

repeat = curry (n, string) -> string.repeat n

enclose = curry (delimiter, string) ->
  do ({start, end} = {}) ->
    if delimiter.length > 1
      [ start, end ] = delimiter
    else
      start = end = delimiter
    start + string + end

quote = dquote = enclose '"'

squote = enclose "'"

truncate = curry (n, string) -> string[0...n]

elide = curry (n, end, string) ->
  if string.length > n
    replace /\W+\w*$/, end, truncate n - end.length + 1, string
  else
    string

split = curry (re, s) -> s.split re

w = words = pipe [
  trim
  split /\s+/
]

isBlank = (s) -> (isString s) && (isEmpty s)

template = (string, filters = {}) ->
  do ({ key, apply } = {}) ->
    filters = Object.assign {},
      {toString, toUpperCase, toLowerCase, trim},
      filters
    apply = (string, name) -> filters[name] string
    (context) ->
      string.replace /\{\{([^}]+)\}\}/g, (_, target) ->
        [key, names...] = target.split("|").map trim
        names.reduce apply, context[key]

export {
  toString
  toBase
  fromBase
  parseNumber
  toUpperCase
  toLowerCase
  collapse
  normalize
  uncase
  gloss
  camelCase
  dashed
  dashes
  dash
  underscored
  underscores
  underscore
  snakeCase
  capitalize
  titleCase
  trim
  truncate
  elide
  enclose
  quote
  dquote
  squote
  startsWith
  endsWith
  pad
  padEnd
  padStart
  repeat
  split
  w
  words
  isBlank
  match
  isMatch
  replace
  template
}
