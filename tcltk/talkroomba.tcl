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
	#fconfigure $fl -blocking false -buffering none -translation binary
	fconfigure $fl -mode 56000,n,8,1  -blocking false -buffering none -translation binary

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
	#fconfigure $fl -blocking false -buffering none -translation binary
	fconfigure $fl -mode 56000,n,8,1  -blocking false -buffering none -translation binary

	foreach opcode $cmd_list {
		puts -nonewline $fl [binary format c $opcode]
		# for whatever reason 10 milliseconds seems to be the same
		after 10
	}

	close $fl
}

proc do_rw { dev cmd_list no_chars } {
	set fl [ open $dev RDWR ]

	fconfigure $fl -mode 57600,n,8,1 -handshake none -blocking false -buffering none -translation binary
	#puts queue=[ fconfigure $fl -queue ]
	#puts ttystatus=[ fconfigure $fl -ttystatus ]

	foreach opcode $cmd_list {
		after 200
		puts -nonewline $fl [binary format c $opcode]
		# for whatever reason 
	}

	fconfigure $fl -mode 57600,n,8,1 -handshake none -buffering none -translation binary

	after 100
	set dat [ read $fl $no_chars ]
	#set slen [ string length $dat ]
	#puts slen=$slen

	close $fl

	return $dat
}
