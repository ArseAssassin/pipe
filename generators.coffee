generator = (f) ->
  pull: f

module.exports =
  generator: generator

  random: -> generator ->
    Math.random()

  range: (n=0, step=1) ->
    generator -> 
      r = n
      n += step
      r


