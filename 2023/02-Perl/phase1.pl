#!/usr/bin/perl -w

use warnings;
use strict;
use v5.10;

my $sum = 0;
my $gameNum;
my (@linesplit, @subset, @throw);

my ($maxred, $maxgreen, $maxblue);
my $invalidGame = 0;


$maxred = 12;
$maxgreen = 13;
$maxblue = 14;

while (<>) {
    if (/Game (\d*):/) {
	# print $1;
	$gameNum = $1;
    }
    chomp;
    @linesplit = split ":", $_;
    @subset = split ";", $linesplit[1];
    foreach (@subset) {
	@throw = split ",", $_;
	foreach (@throw) {
	    if (/(\d*) red/) {
		if ($1 > $maxred) {
		    $invalidGame = 1;
		}
	    }
	    if (/(\d*) green/) {
		if ($1 > $maxgreen) {
		    $invalidGame = 1;
		}
	    }
	    if (/(\d*) blue/) {
		if ($1 > $maxblue) {
		    $invalidGame = 1;
		}
	    }
	}
    }
    if (!$invalidGame) {
	$sum += $gameNum;
    }
    $invalidGame = 0;
    # print $subset[1];
}

print "\nSUM: $sum";
