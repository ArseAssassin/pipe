pipe = require "./pipe"
c = require "./core"

http = require "http"

module.exports = 
  server: ->
    s = pipe.stream()
    http.createServer(
      (req, res) ->
        s.push
          req: req
          res: pipe.consumer.fromNodeStream(res)
    ).listen(8080, "127.0.0.1")
    s

  client: (options) ->
    s = pipe.stream()

    req = http.request options, (res) ->
      res.on "data", (it) ->
        s.push(it)

    req.on "error", (e) ->
      console.error e

    pipe (it) ->
      if it == null
        req.end()
      else
        req.write(it)

      s

