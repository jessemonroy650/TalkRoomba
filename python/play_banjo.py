#!/usr/bin/env python
#
#	Date: 2014-01-11
#
import io
import select

f = io.open('/dev/ttyUSB0', 'w+b', 0)

f.write( '%c' % 0x80 )
select.select('', '',  '', 0.01)

f.write( '%c' % 0x82 )
select.select('', '',  '', 0.01)

f.write( '%c' % 0x88 )
select.select('', '',  '', 0.01)

f.write( '%c' % 9 )
select.select('', '',  '', 0.01)

f.close()
