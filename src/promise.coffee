
promise = (f) -> new Promise f
reject = (x) -> Promise.reject x
resolve = (x) -> Promise.resolve x
all = (px) -> Promise.all px
any = (px) -> Promise.any px
race = (px) -> Promise.race px
map = (px) -> Promise.allSettled px
# TODO withResolvers

export {promise, resolve, reject, all, any, race, map}
