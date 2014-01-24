#
# pg 418-426
#
array set roi {
  start   128
  baud    129
  control 130
  safe    131
  full    132
  power   133
  spot    134
  clean   135
  max     136
  drive   137
  motors  138
  leds    139
  song    140
  play    141
  sensors 142
  force_seeking_dock 143
}

#
array set roiBaud {
  baud_0300  0
  baud_0600  1
  baud_1200  2
  baud_2400  3
  baud_4800  4
  baud_9600  5
  baud_14400  6
  baud_19200  7
  baud_28800  8
  baud_38400  9
  baud_57600  10
  baud_115200  11
}

#
array set roiDrive {
  velocity_min  -500
  velocity_max  500
  radius_min  -2000
  radius_max  2000
}
#
array set roiMotorBits {
  side_brush  0x01
  vacumn      0x02
  main_brush  0x04
}
#
array set roiLEDsBits {
  dirt_detect  0x01
  max          0x02
  clean        0x04
  spot         0x08
  status       0xa0 // 2 bits; low of upper nibble
}

#array set roiLEDsBits
#  power_color']         = 
#  power_intensity']     = 


