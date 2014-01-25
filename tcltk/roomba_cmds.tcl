#
#	Roomba Macros for command execution
#
#	Date: 2014-01-19
#
#=======================================================
# This may or may not help. If it wedges, 'battery tango'.
set roomba_reset		[ list 0x80 0x80 0x80 0x80 0x80 0x80 0x80 ]
set roomba_passive_mode	[ list 0x80 0x80 ]
# opcode 130
set roomba_old_mode		[ list 0x80 0x82 ]
# opcode 131
set roomba_safe_mode	[ list 0x80 0x83 ]
# aka Full Mode
set roomba_blindly_obey	[ list 0x80 0x84 ]

#=======================================================
#	The nine (9) Demo commands
#	cover, coverdock, spotcover, mouse, eight, wimp, home, pachelbel, banjo, abort
set roomba_demo_cover		 [ list 0x88 0 ]
set roomba_demo_coverdock	 [ list 0x88 1 ]
set roomba_demo_spotcover	 [ list 0x88 2 ]
# actually wall follows
set roomba_demo_mouse		 [ list 0x88 3 ]
# drives figure eight (8)
set roomba_demo_eight		 [ list 0x88 4 ]
# drives away from obstacles hit
set roomba_demo_wimp		 [ list 0x88 5 ]
# home - cover back and side with black tape. 
# Then moves toward virtual wall, then stops when it hits an obstacle.
set roomba_demo_home		 [ list 0x88 6 ]

# tag - confines itself within virtual walls.
set roomba_demo_tag		     [ list 0x88 7 ]
# plays sound of
set roomba_demo_pachelbel	 [ list 0x88 8 ]
# plays sound
set roomba_demo_banjo		 [ list 0x88 9 ]
set roomba_demo_abort		 [ list 0x88 255 ]

#=======================================================
# The last for bytes can be changed 1,2= speed; 3,4=direction
#=======================================================
set roomba_drive_straight    [ list 0x89 0x01 0x90 0x7f 0xff ]
set roomba_drive_inplace_cw  [ list 0x89 0x01 0x90 0xff 0xff ]
set roomba_drive_inplace_ccw [ list 0x89 0x01 0x90 0x00 0x01 ]

#=======================================================
#
# REQUIRES USE OF 'Script' (OpCode #152), pg 15 of ROI reference (v2)
# Also REQUIRES that 'Play Script' (OpCode #153), pg 15 of ROI reference (v2)
# To be clear:
# 1) load with (Opcode #152)
# 2) then start with (Opcode #153)
#=======================================================
set roomba_script_do [ list 153 ]
set roomba_script_drive_in_square [ list 0x98 0x11 0x89 0x01 0x2c 0x80 0x00 \
											0x9c 0x01 0x90 \
											0x89 0x01 0x2c 0x00 0x01 \
											0x9d 0x00 0x5a 0x99 ]
		#list 
		#152 17 // Script command follows 17 chars long
		#137 1 44 128 0 // Drive Straight at high speed
		#156 1 144      // Wait Distance
		#137 1 44 0 1   // Turn Counter-clockwise
		#157 0 90       // Wait Angle 90degrees
		#153 	// REPEAT

set roomba_script_drive_40 [ list 152 13 137 1 44 128 0 156 1 144 137 0 0 0 0 ]

#=======================================================
# $LED_bits, $LED_power, $LED_intensity = @_;
# byte1 ($valid_bits = 2 + 8]; byte2 = $LED_power (or color); byte3=$LED_intensity
set roomba_led               [ list 0x8b 10 0 0xff ]
# 0x8e = 142
set roomba_get_sensors_all			[ list 0x8e 0x00 ]
set roomba_get_packet1              [ list 0x8e 0x01 ]
set roomba_get_packet2              [ list 0x8e 0x02 ]
set roomba_get_sensors_electrical	[ list 0x8e 0x03 ]
set roomba_get_packet4              [ list 0x8e 0x04 ]
set roomba_get_packet5              [ list 0x8e 0x05 ]

