# Joy API Reference


**Function**

[identity](#identity) | [wrap](#wrap) | [unary](#unary) | [binary](#binary) | [ternary](#ternary) | [arity](#arity) | [curry](#curry) | [substitute](#substitute) | [partial](#partial) | [flip](#flip) | [tee](#tee) | [rtee](#rtee) | [wait](#wait) | [pipe](#pipe) | [pipeWith](#pipeWith) | [compose](#compose) | [flow](#flow) | [apply](#apply) | [call](#call) | [spread](#spread) | [stack](#stack) | [once](#once) | [memoize](#memoize)

**Object**

[keys](#keys)


## Function


### identity _value_ &rarr; _value_

Returns its argument.


### wrap _value_ &rarr; _function_

Returns a function that returns its argument.


### unary _function_ &rarr; _function_

Returns a unary function that passes its argument to the given function.


### binary _function_ &rarr; _function_

Returns a binary function that passes its arguments to the given function.


### ternary _function_ &rarr; _function_

Returns a ternary function that passes its arguments to the given function.


### arity _n, function_ &rarr; _function_

Returns an n-ary function that passes its arguments to the given function.


### curry _function_ &rarr; _function_

Returns a curryable function that passes its arguments to the given function.


### substitute _pattern, values_ &rarr; _array_

Given a pattern array and an array of values, returns an array with the values substited for the special value \_ in the pattern array.


### partial _function, pattern_ &rarr; _function_

Returns a function that substitutes arguments using the given pattern array before passing them to the given function.


### flip _function_ &rarr; _function_

Returns a function that reverses its arguments before passing them to the given function.


### tee _function_ &rarr; _function_

Returns a function that calls the given function but always returns its first argument.


### rtee _function_ &rarr; _function_

Returns a function that calls the given function but always returns its last argument.


### wait _function_ &rarr; _function_

Returns a function that awaits on its arguments before passing it to the given function.


### pipe _function_ &rarr; _function_

Returns a function that composes the given functions, calling them in the order given.


### pipeWith __ &rarr; __




### compose __ &rarr; __




### flow __ &rarr; __




### apply __ &rarr; __




### call __ &rarr; __




### spread __ &rarr; __




### stack __ &rarr; __




### once __ &rarr; __




### memoize __ &rarr; __





## Object


### keys _object_ &rarr; _array_

Returns the property names for the given object.


