#!/usr/bin/env perl
#
#	Date: 2014-01-04
#	REwrite: 2014-01-11
#
require "roomba_cmds.pl";

sub do_cmd {
	my ($dev, @cmdstring) = @_;

	open(F, "+>$dev");
	$handle = select(F);
	$| = 1;		# non-blocking
	$, = ''; 	# ouput record seperator
	$\ = ''; 	# ouput field seperator 
	select(F);

	#	op is the 8-bit op code you want to send
	#	default delay is 0.01 second - see 'select' in the Camel book
	foreach $op (@cmdstring) {
		print F pack("c", $op);
		select undef, undef, undef, 0.01;
	}

	close(F);
}
$device   = "/dev/ttyUSB0";
#@cmd_strg = (0x80, 0x83, 0x89, 0x01, 0x90, 0x7f, 0xff);
@cmd_strg = (@roomba_safe_mode, @roomba_drive_straight);
do_cmd($device, @cmd_strg);
