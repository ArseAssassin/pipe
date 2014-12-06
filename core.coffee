tap = (f, it) -> f(it); it

take = (n) -> 
    i = 0
    (value) ->
      i++
      if i <= n
        value
      else
        null

drop = (n) ->
  i = 0
  (value) ->
    if i++ >= n
      value
    else
      module.exports.nothing()

split = (separator) -> (it) -> it.split(separator)

module.exports = 
  id: (it) -> it

  unpack: (value) ->
    pipe: (cb) ->
      for v in value
        cb(v)

  nothing: ->
    pipe: ->



  every: (interval) -> generator (s) ->
    i = 0
    setInterval((->
      s.push(i++)
    ), interval)



  take: take
  drop: drop

  head: take 1
  tail: drop 1

  split: split
  lines: split("\n")

  zip: (data) ->
    (value) ->
      [value, data.value()]

  flip: (value) -> [value[1], value[0]]

  map: (f) -> (value) ->
    value.map f

  toObject: (value) ->
    o = {}
    for [k, v] in value
      o[k] = v
    o

  str: (it) -> it.toString()

  tap: tap
  log: tap.bind(null, console.log)
