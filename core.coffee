pipe = require "./pipe"

tap = (f) ->
  (it) ->
    f(it)
    it

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

unpack = -> (it) ->
  pull: (cb) ->
    for v in it
      cb(v)

nothing = ->
  pull: ->

buffer = (f) ->
  buffer = []
  (it) ->
    if f(it)
      buffer
    else
      buffer.push it
      nothing()

bufferAll = ->
  buffer (it) ->
    it == null

module.exports = 
  id: -> (it) -> it

  unpack: unpack
  nothing: nothing

  buffer: buffer
  bufferAll: bufferAll

  take: take
  drop: drop

  head: take 1
  tail: drop 1

  split: split
  lines: -> split("\n")

  zip: (data) ->
    (it) ->
      [it, data.pull()]

  flip: -> (it) -> [it[1], it[0]]

  map: (f) -> (value) ->
    value.map f

  join: (glue) ->
    (it) -> it.join(glue)

  toObject: -> (value) ->
    o = {}
    for [k, v] in value
      o[k] = v
    o

  str: -> (it) -> it.toString()

  tap: tap
  log: ->
    tap(console.log)
