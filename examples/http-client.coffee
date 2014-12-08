c = require "../core"
streams = require "../streams"
http = require "../http"

streams.stdin
  .pipe http.client(
    hostname: 'nodejs.org',
    port: 80,
    path: '/api/http.html#http_http_request_options_callback',
    method: 'GET'
  )
  .pipe c.str()
  .pipe c.log()
