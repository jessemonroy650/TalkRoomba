#!/bin/sh
#
#	2014-01-11 - 
# \
exec wish8.4 $0 "$@"

#============================================#
# Set Program Internal Information
#============================================#
set	DEBUG		0
set	Version		"0.9.1";
set	AppName		"Talk Roomba"
set	VersionInfo	"$AppName v$Version";
set	MyName		[ file normalize [ info script ] ]
set	Author		"Jesus Monroy, Jr."
set	Position	"+50+50"
if [ expr $DEBUG == 0 ] {}

#============================================#
# Set Internal Parameters
#============================================#
#if { [ info exists env(AMORHOME) ] } {
#	set	MyHome		$DefaultHome
#} else {
	set	MyHome		"."
#}
set	PenTools	$env(PENTOOLS)
set	Lib			$env(TCLLIB)
set	Include		$env(TCLINC)
set	HelpFile	$MyHome/xssplck.amr

#============================================#
# Libraries
#============================================#
# Common Window Defaults
source $Lib/cwindef.tcl
#source $Lib/clstload2.tcl
source $Lib/cvarload.tcl
#source $Lib/ctimew.tcl

source roomba_cmds.tcl
source roomba_decode.tcl
source talkroomba.tcl

#============================================#

# Set the window title
wm title . "$VersionInfo"
# Set the window Height and Width
wm geometry . $Position

if [ expr $argc > 0 ] {
	#puts [ lindex $argv 0 ]
	set	MyHome [ lindex $argv 0 ]
}
set X ""
set sets "" 

tk appname $AppName
commonWindowDefaultsBind

if { [file exists $HelpFile] } {
	commonVarFile Usage $HelpFile
}

#============================================#
# Drive logic
#============================================#

if { 0 } {
set errorState [ catch { [glob -type c "/dev/ttyUSB0" ] } devState ]
if { $errorState != "" } {
	puts "\n\tERROR: $devState\n"
	# 
	set reply [ tk_messageBox -icon error -title "ERROR"  -message "ERROR: $devState\n\nEXIT?" -type yesno ]
	switch -- $reply {
		no {}
		yes { exit }
	}
} else {
	puts "devState=$devState"
}
}

#
#	Should start on first available USB, if none is defined
#
if { [ info exists env(ROOMDEV) ] } {
	set roombaPort $env(ROOMDEV)
	puts "ROOMDEV=$roombaPort"
} else {
	puts "\n\tERROR: Can't find environment variable ROOMDEV\n"
	#
	set reply [ tk_messageBox -icon error -title "ERROR"  -message "Can't find environment variable ROOMDEV\n\nEXIT?" -type yesno ]
	switch -- $reply {
		no {}
		yes { exit }
	}
}



set Label	[ label .l -text $VersionInfo -bg orchid2 ]

set drive_straight		[ concat $roomba_safe_mode $roomba_drive_straight ]
set drive_inplace_cw	[ concat $roomba_safe_mode $roomba_drive_inplace_cw ]
set drive_inplace_ccw	[ concat $roomba_safe_mode $roomba_drive_inplace_ccw ]

set script_do              [ concat $roomba_safe_mode $roomba_script_do ]
set script_drive_in_square [ concat $roomba_safe_mode $roomba_script_drive_in_square ]
set script_drive_40        [ concat $roomba_safe_mode $roomba_script_drive_40 ]


set demo_cover		 [ concat $roomba_safe_mode $roomba_demo_cover ]
set demo_coverdock	 [ concat $roomba_safe_mode $roomba_demo_coverdock ]
set demo_spotcover	 [ concat $roomba_safe_mode $roomba_demo_spotcover ]
set demo_mouse		 [ concat $roomba_safe_mode $roomba_demo_mouse ]
set demo_eight		 [ concat $roomba_safe_mode $roomba_demo_eight ]
set demo_wimp		 [ concat $roomba_safe_mode $roomba_demo_wimp ]
set demo_home		 [ concat $roomba_safe_mode $roomba_demo_home ]
set demo_tag		 [ concat $roomba_safe_mode $roomba_demo_tag ]
set demo_pachelbel   [ concat $roomba_safe_mode $roomba_demo_pachelbel ]
set demo_banjo       [ concat $roomba_safe_mode $roomba_demo_banjo ]
set demo_abort		 [ concat $roomba_safe_mode $roomba_demo_abort ]

set light_leds		 [ concat $roomba_safe_mode $roomba_led ]
set get_sensors_all	 [ concat $roomba_safe_mode $roomba_get_sensors_all ]
set get_packet1      [ concat $roomba_safe_mode $roomba_get_packet1 ]
set get_packet2      [ concat $roomba_safe_mode $roomba_get_packet2 ]
set get_sensors_electrical [ concat $roomba_safe_mode $roomba_get_sensors_electrical ]
set get_packet4      [ concat $roomba_safe_mode $roomba_get_packet4 ]
set get_packet5      [ concat $roomba_safe_mode $roomba_get_packet5 ]

###
set Pachelbel		[ button .pachelbell -text "Pachelbel" -bg PeachPuff  \
						-command { do_cmd $roombaPort $demo_pachelbel } ]

set Banjo			[ button .banjo -text "banjo"     -bg PeachPuff2 \
						-command { do_cmd $roombaPort $demo_banjo } ]
###
set Cover			[ button .cover -text "Cover" -bg azure3  \
						-command { do_cmd $roombaPort $demo_cover } ]

set CoverNDock		[ button .coverndock -text "Cover N Dock" -bg azure3  \
						-command { do_cmd $roombaPort $demo_coverdock } ]

set SpotCover		[ button .spotcover -text "Spot Cover" -bg azure3  \
						-command { do_cmd $roombaPort $demo_spotcover } ]

set WallFollow		[ button .wallfollow -text "Wall Follow" -bg azure3  \
						-command { do_cmd $roombaPort $demo_mouse } ]
###
set Eight			[ button .eight -text "Eight" -bg azure3  \
						-command { do_cmd $roombaPort $demo_eight } ]

set Wimp			[ button .wimp -text "Wimp" -bg azure3  \
						-command { do_cmd $roombaPort $demo_wimp } ]

set Home			[ button .home -text "Home" -bg azure3  \
						-command { do_cmd $roombaPort $demo_home } ]

set Tag				[ button .tag -text "Tag" -bg azure3  \
						-command { do_cmd $roombaPort $demo_tag } ]


set DriveStraight	[ button .drive_straight -text "drive_straight" -bg azure3  \
						-command { do_cmd $roombaPort $drive_straight } ]

set DriveInplaceCw	[ button .drive_inplace_cw -text "In-place CW" -bg azure3  \
						-command { do_cmd $roombaPort $drive_inplace_cw } ]

set DriveInplaceCcw	[ button .drive_inplace_ccw -text "In-place CCW" -bg azure3  \
						-command { do_cmd $roombaPort $drive_inplace_ccw } ]

set DriveInSquare	[ button .drive_in_square -text "Drive in A Square" -bg azure3  \
						-command {
		do_cmd $roombaPort $script_drive_in_square
		after 1500
		do_cmd $roombaPort $script_do
	} ]

set Drive40	[ button .drive_40 -text "Drive 40 cm" -bg azure3  \
						-command { 
		do_cmd $roombaPort $script_drive_40
		after 1500
		do_cmd $roombaPort $script_do
	} ]


set GetSensorsAll	[ button .get_sensors_all -text "Get All Sensors" -bg azure3  \
						-command {
		set no_chars 26
		set data ""
		set data [ do_rw $roombaPort $get_sensors_all $no_chars  ]
		set slen [ string length $data ]
		puts "slen $slen"
		#foreach opcode $data {
		#	puts d=[format %d $opcode]
		#}
	}]

set GetPacket1	[ button .get_packet1 -text "GetPacket1" -bg azure3  \
						-command {
		set no_chars 10
		set data ""
		set data [ do_rw $roombaPort $get_packet1 $no_chars  ]

		set slen [ string length $data ]
		puts "== $slen bytes == "
		#puts $data
		if { $slen == $no_chars } {
			binary scan $data cccccccccc \
				bumpWheelDrops wall cliffLeft cliffFrontLeft \
				cliffFrontRight cliffRight \
				virtualWall overCurrents unused01 unused02

			puts bumpWheelDrops=$bumpWheelDrops
			puts wall=$wall
			puts cliffLeft=$cliffLeft
			puts cliffFrontLeft=$cliffFrontLeft
			puts cliffFrontRight=$cliffFrontRight
			puts cliffRight=$cliffRight
			puts virtualWall=$virtualWall
			puts overCurrents=$overCurrents
			puts unused01=$unused01
			puts unused02=$unused02

		} else {
			puts "Failed read."
		}
	} ]



set GetSensorsElectrical	[ button .get_sensors -text "GetSensorsElectrical (3)" -bg azure3  \
						-command {
		set no_chars 10
		set data ""
		set data [ do_rw $roombaPort $get_sensors_electrical $no_chars  ]

		set slen [ string length $data ]
		puts "== $slen bytes == "
		#puts $data
		if { $slen == $no_chars } {
			binary scan $data csscss chargeState voltage current temperature charge capacity
			puts chargeState=$chargeState
			puts voltage=[expr {$voltage / 1000.0} ]mV
			puts current=[expr {$current / 1000.0} ]mA
			puts temperature=$temperature
			puts charge=[expr {$charge & 0xff}]mAh
			puts capacity=[expr {$capacity & 0xff}]mAh
		} else {
			puts "Failed read."
		}
	} ]


set GetPacket4	[ button .get_packet4 -text "GetPacket4" -bg azure3  \
						-command {
		set no_chars 14
		set data ""
		set data [ do_rw $roombaPort $get_packet4 $no_chars  ]

		set slen [ string length $data ]
		puts "== $slen bytes == "
		#puts $data
		if { $slen == $no_chars } {
			binary scan $data ssssscsc \
				wallSignal cliffLeftSignal cliffFrontLeftSignal \
				cliffFrontRightSignal cliffRightSignal \
				userDigitalInput userAnalogInput chargingSourceAvailable

			puts wallSignal=$wallSignal
			puts cliffLeftSignal=$cliffLeftSignal
			puts cliffFrontLeftSignal=$cliffFrontLeftSignal
			puts cliffFrontRightSignal=$cliffFrontRightSignal
			puts cliffRightSignal=$cliffRightSignal
			puts userDigitalInput=$userDigitalInput
			puts userAnalogInput=$userAnalogInput
			puts chargingSourceAvailable=$chargingSourceAvailable

		} else {
			puts "Failed read."
		}
	} ]


set GetPacket5	[ button .get_packet5 -text "GetPacket5" -bg azure3  \
						-command {
		set no_chars 12
		set data ""
		set data [ do_rw $roombaPort $get_packet5 $no_chars  ]

		set slen [ string length $data ]
		puts "== $slen bytes == "
		#puts $data
		if { $slen == $no_chars } {
			binary scan $data ccccssss \
				oiMode songNumber songPlaying \
				numberOfStreamPackets velocity \
				radius rightVelocity leftVelocity

			set dummy ""
			set dummy [roomba_decode_oimode $oiMode $dummy]
			puts "oiMode=$oiMode $dummy"
			puts songNumber=$songNumber
			puts songPlaying=$songPlaying
			puts numberOfStreamPackets=$numberOfStreamPackets
			puts velocity=$velocity
			puts radius=$radius
			puts rightVelocity=$rightVelocity
			puts leftVelocity=$leftVelocity

		} else {
			puts "Failed read."
		}
	} ]



set LightLEDS	[ button .lightLEDS -text "LightLEDS" -bg azure3  \
						-command { do_cmd $roombaPort $light_leds } ]

#########
grid $Help -row 0 -column 0 -sticky w
grid $Label -row 0 -column 1 -sticky w
grid $About -row 0 -column 4 -sticky e

grid $Pachelbel $Banjo   -row 1  -padx 10 -pady 10

grid $Cover $CoverNDock $SpotCover $WallFollow    -row 2  -padx 10 -pady 10

grid $Eight $Wimp $Home $Tag    -row 3  -padx 10 -pady 10

grid $DriveStraight $DriveInplaceCw $DriveInplaceCcw  $DriveInSquare  $Drive40  -row 4  -padx 10 -pady 10

grid $LightLEDS  -row 5  -padx 10 -pady 10

grid $GetSensorsAll -row 6  -padx 10 -pady 10

grid $GetPacket1 $GetSensorsElectrical $GetPacket4 $GetPacket5 -row 7  -padx 10 -pady 10

grid $Exit  -row 8 -column 4 -sticky e


bind $Label <1> { exit }
focus -f $Label





