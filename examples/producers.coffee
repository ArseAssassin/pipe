generators = require "../generators"
streams = require "../streams"
core = require "../core"

streams.every(100, generators.random())
  .pipe core.log()
