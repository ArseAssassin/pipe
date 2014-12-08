transducer = (input, f) ->
  s = if f.push
    f
  else
    stream()

  input.pull (x) ->
    if x != null && f.call
      x = f(x)

    if x != null && x.pull
      x.pull s.push
    else
      s.push(x)
  s


stream = ->
  listeners = []

  o = 
    pipe: (f) ->
      transducer(o, f)

    pull: (cb) ->
      listeners.push(cb)

    push: (value) ->
      for f in listeners
        f(value)

      if value == null
        o.end()

    end: ->
      listeners = []

    inherit: (parent) ->
      setFunction = (k, v) ->
        result[k] = (args...) ->
          (o.pipe v args...).inherit(parent)

      result = {}

      for k, v of parent
        setFunction k, v

      for k, v of o
        result[k] = v

      result

  o


consumer =
  fromNodeStream: (stream) ->
    push: (value) ->
      if value == null
        stream.end()
      else
        stream.write(value)


pipe = (f) ->
  e = (it) ->
    f(it)

  e.pipe = (subroutine) ->
    pipe (it) ->
      subroutine(f(it))

  e


stream.fromNodeStream = (s) ->
  _s = stream()

  s.on "data", (it) -> 
    _s.push(it)
  s.on "end", ->
    _s.push(null)

  _s


merged = (parent, stream, f) ->
  value = parent.pull()

  stream.pull (data) ->
    value = f(value, data)

  o =
    merge: (stream, f) ->
      merged(o, stream, f)

    pull: -> value
  o


signal = (value) ->
  o = 
    merge: (stream, f) ->
      merged(o, stream, f)

    pull: -> value

  o

producer = (f) ->
  s = stream()
  f(s)
  s

pipe.stream = stream
pipe.consumer = consumer
pipe.producer = producer
pipe.signal = signal

module.exports = pipe
