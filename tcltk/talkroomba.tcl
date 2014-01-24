#!/bin/sh
#
#	2014-01-17 - Making library for roomba
# \
exec tclsh8.5 $0 "$@"

#@dm
#@dm	Talk to the Rooomba
#@dm
#		2014-01-11T15:50:02 - Initial entry
#
#============================================#
# 
#============================================#
proc playSong { dev song } {
	set fl [ open $dev "w" ]
	fconfigure $fl -blocking false -buffering none -translation binary

	puts -nonewline $fl [binary format c 0x80]
	after 10
	puts -nonewline $fl [binary format c 0x83]
	after 10
	puts -nonewline $fl [binary format c 0x88]
	after 10
	if { $song == "pachelbel" } {
		puts -nonewline $fl [binary format c 8]
	}
	if { $song == "banjo" } {
		puts -nonewline $fl [binary format c 9]
	}
	after 10
	close $fl
}

proc do_cmd { dev cmd_list } {
	set fl [ open $dev "w" ]
	fconfigure $fl -blocking false -buffering none -translation binary

	foreach opcode $cmd_list {
		puts -nonewline $fl [binary format c $opcode]
		# for whatever reason 10 milliseconds seems to be the same
		after 10
	}

	close $fl
}

proc  roomba_sensors_power_decode { data chargeState } {

	set chargeState ""

	switch $data {
		0 { set chargeState "Not charging" }
		1 { set chargeState "Reconditioning charging" }
		2 { set chargeState "Full charge" }
		3 { set chargeState "Trickle charge" }
		4 { set chargeState "Waiting" }
		5 { set chargeState "Charging Fault" }
		default { set chargeState "Unknown Error" }
	}
	return chargeState;
}


##
# NOT WORKING BELOW HERE - 2014-01-17T09:28:49
##

proc read_data { dev no_chars dat } {
	set fl [ open $dev "r" ]
	fconfigure $fl -blocking false -buffering none -translation binary
	set dat [ read $fl $no_chars ]
	close $fl

	return $dat
}

#playSong "/dev/ttyUSB1" "banjo"


