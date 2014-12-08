c = require "../core"
file = require "../file"

file.read("README")
  .pipe c.str()
  .pipe c.log()