import {
  isKind
  isFunction
  isString
  isObject
} from "./type"

class GenericFunction

  @create: (options = {}) -> new @ options

  constructor: ({@name, @description, @default}) ->
    @name ?= "anonymous-generic"
    @entries = []
    @default ?= (args...) =>
      error = new TypeError "#{@name}: invalid arguments."
      error.arguments = args
      throw error

  define: (terms..., f) -> @entries.unshift [terms, f] ; @

  lookup: (args) ->

    # go through each definition in our lookup 'table'
    for [terms, f] in @entries

      # there must be at least one argument per term
      # (variadic terms can consume multiple arguments,
      # so the converse is not true)
      continue if terms.length > args.length

      # allow for the nullary function
      return f if terms.length == 0 && args.length == 0

      # we can't have a match if we don't match any terms
      match = false

      # each argument must be consumed
      i = 0
      while i < args.length

        # if there's no corresponding term, we have leftover
        # arguments with no term to consume them, so move on
        if !(term = terms[i])?
          match = false
          break

        # if the term may be variadic (indicated by taking 0 arguments)
        # try the term with the remaining arguments
        if term.length == 0
          match = term args[i..]...
          break

        # otherwise, we have the default case, where we try to match
        # the next argument with the next term
        break if !(match = term args[i++])

      # if we ended up with a match, just return the corresponding fn
      return f if match

    # if exit the loop without returning a match, return the default
    @default

  dispatch: (args) ->
    f = @lookup args
    f args...

lookup = ({_}, args) -> _.lookup args
define = ({_}, args...) -> _.define args...
create = (options) ->
  f = (args...) -> f._.dispatch args
  f._ = GenericFunction.create options
  f

isGeneric = (f) ->
  (isFunction f) && (f._?) && (isKind GenericFunction, f._)

generic = create
  name: "generic"
  description: "Create or extend a generic function."

define generic, create

define generic, isObject, create

define generic, isString, isObject, (name, description) ->
  create {description..., name}

define generic, isGeneric, (-> true), (f, ax...) -> define f, ax...

Generic = {create, define, lookup}

export {Generic, generic}
