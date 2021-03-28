getter = curry (key, f, type) ->
  Object.defineProperty


properties = (target, descriptions) ->
  for name, description of descriptions
    description.enumerable ?= true
    description.configurable ?= true
    Object.defineProperty target, name, description

methods = (target, definitions) ->
  for name, f of definitions
    Object.defineProperty target, name,
      value: f
      configurable: true
      writable: true
