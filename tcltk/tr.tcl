#!/bin/sh
#
#	2014-01-11 - 
# \
exec wish8.4 $0 "$@"

#============================================#
# Set Program Internal Information
#============================================#
set	DEBUG		0
set	Version		"0.8.5";
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

set errorState [ catch { [glob -type c /dev/ttyU*] } devState ]
if { $errorState } {
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
# set get_sensors_electrical [ concat $roomba_safe_mode $roomba_get_sensors_electrical ]
set get_packet4		 [ concat $roomba_safe_mode $roomba_get_packet4 ]

set get_sensors_all	 [ concat $roomba_safe_mode $roomba_get_sensors_all ]

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

set GetPacket4	[ button .get_sensors -text "get_packet4" -bg azure3  \
						-command {
		set no_chars 14
		set data ""
		#do_cmd $roombaPort $get_packet4;
		do_cmd $roombaPort $get_sensors_all
		set data [ read_data $roombaPort $no_chars $data]
		set slen [ string length $data ]
		puts $slen

		if { $slen == $no_chars } {
			binary scan $dat ssssscsc \
			valWall valCLeft valCFLeft valCFRight valCRight valUDIn valUAIn valCSA

			puts "== $slen bytes == "
			puts [ format %s $valWall]
			puts [ format %s $valCLeft]
			puts [ format %i $valCFLeft]
			puts [ format %i $valCFRight]
			puts [ format %s $valCRight]

			puts [ format %c $valUDIn]
			puts [ format %s $valUAIn]
			puts [ format %c $valCSA]
		} else {
			puts "Failed read."
		}
	} ]


set GetSensorsAll	[ button .get_sensors_all -text "get_sensors_all" -bg azure3  \
						-command {
		set no_chars 26
		set data ""
		do_cmd $roombaPort $get_sensors_all
		after 200
		set data [ read_data $roombaPort $no_chars $data]
		set slen [ string length $data ]
		puts "slen $slen"
		foreach opcode $data {
			puts d=[format %d $opcode]
		}
	}]


# NOT WORKING - 2014-01-17T09:29:10
#set GetElectricalState	[ button .getElectricalState -text "get_sensors_electrical" -bg azure3  \
#		-command { 
#		set data [get_electrical_state $roombaPort $get_sensors_electrical ]
#		#puts [ format "%d"  [ lindex $data 0 ] ]
#} ]

set LightLEDS	[ button .lightLEDS -text "LightLEDS" -bg azure3  \
						-command { do_cmd $roombaPort $light_leds } ]

#########
grid $Help -row 0 -column 0 -sticky w
grid $Label -row 0 -column 1 -sticky w
grid $About -row 0 -column 3 -sticky e

grid $Pachelbel $Banjo   -row 1  -padx 10 -pady 10

grid $Cover $CoverNDock $SpotCover $WallFollow    -row 2  -padx 10 -pady 10

grid $Eight $Wimp $Home $Tag    -row 3  -padx 10 -pady 10

grid $DriveStraight $DriveInplaceCw $DriveInplaceCcw  $DriveInSquare  -row 4  -padx 10 -pady 10

#grid $Drive40 $GetElectricalState $LightLEDS  -row 5  -padx 10 -pady 10

grid $Drive40 $GetPacket4 $GetSensorsAll $LightLEDS  -row 5  -padx 10 -pady 10

grid $Exit  -row 7 -column 3 -sticky e


bind $Label <1> { exit }
focus -f $Label





