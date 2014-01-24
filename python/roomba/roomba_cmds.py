#
#	Roomba Macros for command execution
#
ROOMBA_DEBUG = 1
#	Date: 2014-01-11
#	It took some experimentation to get this to work correctly.
#	The was copied from the PERL version and edited with sed(1).
#=======================================================
# This may or may not help. If it wedges, 'battery tango'.
roomba_reset        = [0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80]
roomba_passive_mode = [0x80, 0x80]
roomba_safe_mode    = [0x80, 0x83]
roomba_blindly_obey = [0x80, 0x84] # aka Full Mode
# The last for bytes can be changed 1,2= speed; 3,4=direction
roomba_drive_straight    = [0x89, 0x01, 0x90, 0x7f, 0xff]
roomba_drive_inplace_cw  = [0x89, 0x01, 0x90, 0xff, 0xff]
roomba_drive_inplace_ccw = [0x89, 0x01, 0x90, 0x00, 0x01]

#=======================================================
# $LED_bits, $LED_power, $LED_intensity = @_;
# byte1 ($valid_bits = 2 + 8]; byte2 = $LED_power (or color); byte3=$LED_intensity
roomba_led              = [0x8b, 0x20, 0x80, 0x80]
roomba_get_sensors      = [0x8e, 0x03]
#=======================================================
#	The nine (9) Demo commands
#	cover, coverdock, spotcover, mouse, eight, wimp, home, pachelbel, banjo, abort
roomba_demo_cover		= [0x88, 0]
roomba_demo_coverdock	= [0x88, 1]
roomba_demo_spotcover	= [0x88, 2]
roomba_demo_mouse		= [0x88, 3] # actually wall follows
roomba_demo_eight		= [0x88, 4] # drives figure eight (8)
roomba_demo_wimp		= [0x88, 5] # drives away from obstacles hit
roomba_demo_home		= [0x88, 6] # home - cover back and side with black tape. 
		# Then moves toward virtual wall, then stops when it hits an obstacle.
roomba_demo_tag		    = [0x88, 7] # tag - confines itself within virtual walls.
roomba_demo_pachelbel	= [0x88, 8] # plays sound of
roomba_demo_banjo		= [0x88, 9] # plays sound
roomba_demo_abort		= [0x88, 255]

def roomba_sensors_power_decode(data):
    if (data == 0):
        chargeState = "Not charging"
    elif (data == 1):
        chargeState = "Reconditioning charging"
    elif (data == 2):
        chargeState = "Full charge"
    elif (data == 3):
        chargeState = "Trickle charge"
    elif (data == 4):
        chargeState = "Waiting"
    elif (data == 5):
        chargeState = "Charging Fault"
    else:
        chargeState = "Unknown Error" 

	return chargeState;

#if __name__ == "__main__":
    #import sys
    #fib(int(sys.argv[1]))
