c = require "../core"
pipe = require "../pipe"
http = require "../http"
file = require "../file"

server = http.server()

requests = pipe.signal(0)
  .merge server, (it, req) -> it + 1

server
  .pipe (it) ->
    it.res.push(requests.pull().toString())
    it.res.push(null)
