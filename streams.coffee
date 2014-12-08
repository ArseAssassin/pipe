pipe = require "./pipe"
core = require "./core"

generators = require "./generators"

module.exports = 
  error: pipe.error
  stdin: pipe.stream.fromNodeStream(process.stdin).pipe core.str()
  stdout: pipe.consumer.fromNodeStream(process.stdout)
  every: (interval, generator=null) -> 
    if !generator
      generator = generators.range()

    pipe.producer (s) ->
      setInterval (->
        s.push generator.pull()
      ), interval


