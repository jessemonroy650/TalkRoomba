xcd #!/usr/bin/env python
#
#	Date: 2014-01-04
#	REwrite: 2014-01-11
#
import io
import select
import roomba.roomba_cmds as rc

def do_cmd(dev, cmdstring):
    f = io.open(dev, 'w+b', 0)
    for oper in (cmdstring):
        #print '%c' % oper
        f.write( '%c' % oper )
        select.select('', '',  '', 0.01) # delay 0.01 sec
    f.close()

device   = "/dev/ttyUSB0"
cmd_strg = []
#cmd_strg = [0x80, 0x82, 0x88, 9] # banjo sound
#cmd_strg = [0x80, 0x83, 0x89, 0x01, 0x90, 0x7f, 0xff] # drive forward

cmd_strg.extend(rc.roomba_safe_mode)
cmd_strg.extend(rc.roomba_drive_straight)
do_cmd(device, cmd_strg);
