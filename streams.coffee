pipe = require "./pipe"
core = require "./core"

stdin = pipe.stream.fromNode(process.stdin).pipe (it) -> it.toString()

error = pipe.stream()
error
  .pipe core.log
  .pipe ->
    terminate.push 1


terminate = pipe.stream()
terminate.pipe (it) -> process.exit(it)
module.exports = 
  error: error
  stdin: stdin
  terminate: terminate
