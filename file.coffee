pipe = require "./pipe"

fs = require "fs"

module.exports = 
  read: (file, options) ->
    pipe.stream.fromNodeStream(fs.createReadStream(file, options))

