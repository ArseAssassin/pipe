events = require "events"

module.exports = 
stream = ->
  emitter = new events.EventEmitter()
  o = 
    push: (value) ->
      emitter.emit("value", value)
      if value == null
        close()

    pipe: (transducer) ->
      if transducer.push
        transducer = transducer.push
      pipe(emitter, transducer)

    close: ->
      emitter.removeAllListeners()

  o


pipe = (parent, transducer) ->
  emitter = new events.EventEmitter()
  parent.on "value", (value) ->
    if value == null
      push value
    else
      value = transducer(value)
      push value
    
  close = ->
    emitter.removeAllListeners()

  push = (value) ->
    if value == null
      close()
      emitter.emit("value", value)
    else if value.pipe
      value.pipe (x) -> push(x)
    else
      emitter.emit("value", value)

  pipe: (transducer) ->
    if transducer.push
      transducer = transducer.push
    pipe(emitter, transducer)


signal = (value) ->
  emitter = new events.EventEmitter()

  self = 
    merge: (transducer, stream) ->
      stream.pipe (x) ->
        value = transducer(x)
        emitter.emit "value", value

      self

    value: ->
      value

    pipe: (transducer) ->
      value: -> transducer(value)

  self





generator = (cb) ->
  s = stream()
  cb(s)
  s

stream.fromNode = (s) ->
  _s = stream()

  s.on "readable", ->
    if line = s.read()
      _s.push(line)

  _s

module.exports = 
  stream: stream
  pipe: pipe
  signal: signal
  generator: generator
