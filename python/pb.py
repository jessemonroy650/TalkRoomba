#!/usr/bin/env python
#
#	Date: 2014-01-11
#
#import io
#import select
import serial
import time

delay=0.1

#f = io.open('/dev/ttyUSB0', 'w+b', 0)
f = serial.Serial('/dev/ttyUSB0', baudrate=57600, timeout=0.1)


f.write( '%c' % 0x80 )
time.sleep(delay)

f.write( '%c' % 0x82 )
time.sleep(delay)

f.write( '%c' % 0x88 )
time.sleep(delay)

f.write( '%c' % 9 )
time.sleep(delay)

f.close()
