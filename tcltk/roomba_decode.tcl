#!/bin/sh
#
#	2014-01-25 - Decode roomba codes
# \
exec tclsh8.5 $0 "$@"

proc  roomba_decode_oimode { data mode } {
	set mode ""

	switch $data {
		0 { set mode "off" }
		1 { set mode "passive" }
		2 { set mode "safe" }
		3 { set mode "full" }
		default { set mode "Unknown Error" }
	}
	return $mode;
}

proc  roomba_decode_sensors_power { data chargeState } {
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
	return $chargeState;
}

