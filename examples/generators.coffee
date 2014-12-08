# generates line numbers from stdin

core = require "../core"
generators = require "../generators"
streams = require "../streams"

streams.stdin 
  .inherit(core)
  .lines()
  .unpack()
  .zip generators.range(1)
  .flip()
  .join(" ")
  .log()
