#!/usr/bin/perl
# syncQueue.pl
# this script relies on btsync
# the idea is that a seedbox downloads content
# and hardlinks it to an outgoing directory
# a processor such as SickBeard, or CouchPototo
# reads its own queue directory and this script
# copy's or moves media only after it has been synced
# btsync uses the .bts extension for files in process
#
# NOTE: if you are using an older version of btsync like > 2.0
#				then the filename will have a .!sync appended to it
#				instead of .bts

# DIRECTORY STRUCTURE:
# this relies on a directory structure as follows
# $baseProcessingDir/tvQueue
# $baseProcessingDir/movieQueue
# etc.
#
# called via
# ./syncQueue tv
# ./syncQueue movie
# should be added to cron to run every x number of minutes

use strict;
use warnings;
use Data::Dumper;
use Storable qw(nstore retrieve);

my $debug=0;

# this should be set to the directory that btsync is pulling data to
my $baseQueueDir = "/store/incoming/";

# this should be your pre-processing dir so couch or sick can process the media
my $baseProcessingDir = "/store/processing/";

# location of semi-perm synced data
# this is required for copying files with
# hardlinks as you don't want to process the same
# file over and over again
my $storeFile = '/home/btsync/synced';

# actionType is defined by how to manage media, in your case
# you may be sharing the queue dir with multiple locations
# so data has to be deleted only when everyone has synced
# otherwise you can just move it
## 1 = cp -al (with hardlinks)
## 2 = mv (move files)
my $actionType = 1;

my $synced = ();

# intialize a new storable file if one doesn't exist
if ( -f $storeFile ) {
	$synced = retrieve($storeFile);
} else {
	$synced->{'created'} = 1;
	nstore($synced, $storeFile);
}

# get args
my ($queueType) = @ARGV;

# force a type or die
if (not defined $queueType) {
  die "Need queue type\n";
}

my $queueDir = $baseQueueDir.$queueType."Queue";
my $procDir = $baseProcessingDir.$queueType."Queue";

close (LINE);
my $countDir = "find ".$queueDir." -maxdepth 3 -mindepth 1 -type f -not -name \*.bts|wc -l";
my $count = `$countDir`;
chomp $count;

if ($count) {
	if ($debug) {
		print "running $queueType queue\n";
	}

	# cycle though all the files and find the ones that are not
	# currently being synced and check to see if they have been
	# processed already
	open(LINE, "find $queueDir/ -maxdepth 3 -mindepth 1 -type f -not -name \*.bts|");
	while (<LINE>) {
		my $filename = $_;
		chomp $filename;
		if (!$synced->{$queueType}->{$filename}) {
			# hardlink copy files
			if ($actionType == 1) {
				my $command = 'cp -alv "'.$filename.'" '.$procDir.'/';
			}
			# move files
			if ($actionType == 2) {
				my $command = 'mv -v "'.$filename.'" '.$procDir.'/';
			}
			# debug or do it
			if ($debug) {
				print "FAKE running: $command\n\n";
			} else {
				my $output = system($command);
			}

			# flag this one processed
			$synced->{$queueType}->{$filename} = 1;
		}
	}

} # end count check

# store new ref
nstore($synced, $storeFile);
exit;
