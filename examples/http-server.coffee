# creates a http server at localhost:8080 that returns the contents
# of the README file

c = require "../core"
http = require "../http"
file = require "../file"

http.server()
  .pipe (it) ->
    file.read("README")
      .pipe(it.res)

