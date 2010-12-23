#!/usr/bin/env ruby

require 'drb'

logger = DRbObject.new nil, 'druby://:9000'

logger.save(1, "msg 1 for 1")

time_1 = Time.now

logger.save(2, "msg 1 for 2")
logger.save(1, "msg 2 for 1")
logger.save(2, "msg 2 for 1")

time_2 = Time.now

logger.save(1, "msg 3 for 1")

puts logger.raport(time_1, time_2, 2, /msg 1/)
