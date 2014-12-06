pipe = require "./pipe"
c = require "./core"
streams = require "./streams"




# header = signal(Date())
# 	.merge id, every(1000)


# every(40)
# 	.pipe zip header
# 	.pipe log


header = pipe.signal([])
	.merge c.id, 
		streams.stdin
			.pipe c.lines
			.pipe c.unpack
			.pipe c.head
			.pipe c.split ","
			.pipe c.unpack
  .pipe c.split ","

streams.stdin
	.pipe c.lines
	.pipe c.unpack
	.pipe c.tail
	.pipe c.split ","
	.pipe c.map c.zip header
	# .pipe map flip
	# .pipe toObject
	.pipe c.log
