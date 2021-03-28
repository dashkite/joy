# Joy API Reference


**Function**

[identity](#identity) | [wrap](#wrap) | [unary](#unary) | [binary](#binary) | [ternary](#ternary) | [arity](#arity) | [curry](#curry) | [substitute](#substitute) | [partial](#partial) | [flip](#flip) | [tee](#tee) | [rtee](#rtee) | [wait](#wait) | [pipe](#pipe) | [pipeWith](#pipeWith) | [compose](#compose) | [flow](#flow) | [apply](#apply) | [call](#call) | [spread](#spread) | [stack](#stack) | [once](#once) | [memoize](#memoize)

**Object**

[keys](#keys)


## Function


### identity

_identity value &rarr; value_

Returns its argument.


### wrap

_wrap value &rarr; function_

Returns a function that returns its argument.


### unary

_unary function &rarr; function_

Returns a unary function that passes its argument to the given function.


### binary

_binary function &rarr; function_

Returns a binary function that passes its arguments to the given function.


### ternary

_ternary function &rarr; function_

Returns a ternary function that passes its arguments to the given function.


### arity

_arity n, function &rarr; function_

Returns an n-ary function that passes its arguments to the given function.


### curry

_curry function &rarr; function_

Returns a curryable function that passes its arguments to the given function.


### substitute

_substitute pattern, values &rarr; array_

Given a pattern array and an array of values, returns an array with the values substited for the special value \_ in the pattern array.


### partial

_partial function, pattern &rarr; function_

Returns a function that substitutes arguments using the given pattern array before passing them to the given function.


### flip

_flip function &rarr; function_

Returns a function that reverses its arguments before passing them to the given function.


### tee

_tee function &rarr; function_

Returns a function that calls the given function but always returns its first argument.


### rtee

_rtee function &rarr; function_

Returns a function that calls the given function but always returns its last argument.


### wait

_wait function &rarr; function_

Returns a function that awaits on its arguments before passing it to the given function.


### pipe

_pipe function &rarr; function_

Returns a function that composes the given functions, calling them in the order given.


### pipeWith

_pipeWith  &rarr; _




### compose

_compose  &rarr; _




### flow

_flow  &rarr; _




### apply

_apply  &rarr; _




### call

_call  &rarr; _




### spread

_spread  &rarr; _




### stack

_stack  &rarr; _




### once

_once  &rarr; _




### memoize

_memoize  &rarr; _





## Object


### keys

_keys object &rarr; array_

Returns the property names for the given object.


