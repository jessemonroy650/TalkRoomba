#
# pg 418-426
#
roi['start']   = 128
roi['baud']    = 129
roi['control'] = 130
roi['safe']    = 131
roi['full']    = 132
roi['power']   = 133
roi['spot']    = 134
roi['clean']   = 135
roi['max']     = 136
roi['drive']   = 137
roi['motors']  = 138
roi['leds']    = 139
roi['song']    = 140
roi['play']    = 141
roi['sensors'] = 142
roi['force_seeking_dock'] = 143

#
roi_baud_0300 = 0
roi_baud_0600 = 1
roi_baud_1200 = 2
roi_baud_2400 = 3
roi_baud_4800 = 4
roi_baud_9600 = 5
roi_baud_14400 = 6
roi_baud_19200 = 7
roi_baud_28800 = 8
roi_baud_38400 = 9
roi_baud_57600 = 10
roi_baud_115200 = 11

#
roi_drive_velocity['min'] = -500
roi_drive_velocity['max'] = 500
roi_drive_radius['min']   = -2000
roi_drive_radius['max']   = 2000

#
roi_motor['bits']['side_brush'] = 0x01
roi_motor['bits']['vacumn']     = 0x02
roi_motor['bits']['main_brush'] = 0x04

#
roi_leds['bits']['dirt_detect'] = 0x01
roi_leds['bits']['max']         = 0x02
roi_leds['bits']['clean']       = 0x04
roi_leds['bits']['spot']        = 0x08
roi_leds['bits']['status']      = 0xa0 // 2 bits; low of upper nibble
roi_leds['power_color']         = 
roi_leds['power_intensity']     = 




