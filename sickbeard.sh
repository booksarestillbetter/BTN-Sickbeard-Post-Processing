#!/usr/bin/env bash
# Script that removes the file from tranmission
# and sym links it back from the new renamed version

# path to a directory that is writable by the tranmission user
LOGFILE="/customscripts/sb2transmission.log"

# Folder that SB processes
SBWATCH="/sbwatch"

# Location where transmission seeds from; download-dir
SEED="/downloads/finished"

# Turn on to get a more detailed output for commands
DEBUG=true

########################################################
# do not edit below, unless you know what you are doing.
TFILE="default-file-so-we-do-not-remove-the-hole-seed-dir-if-error.txt"
DATE=`date`

echo "" >> "$LOGFILE"
echo "sickbeard.sh running on $DATE" >> "$LOGFILE"
echo "Sick-Beard Watch dir $SBWATCH" >> "$LOGFILE"
echo "Seed folder $SEED" >> "$LOGFILE"
echo "Final location: $1" >> "$LOGFILE"
echo "Sourced from: $2" >> "$LOGFILE"

TFILE="${2##$SBWATCH}"
echo "$TFILE" >> "$LOGFILE"

# remove the file transmission is seeding from 
echo "Removing $SEED" >> "$LOGFILE"
if [ "$DEBUG" == "true" ]; then
	echo "rm -rf $SEED$TFILE" >> "$LOGFILE"
fi
rm -rf "$SEED$TFILE"

# Create Symlinks back to the seed folder
echo "Creating symlink to $SEED" >> "$LOGFILE"
if [ "$DEBUG" == "true" ]; then
	echo "ln -s $1 $SEED$TFILE" >> "$LOGFILE"
fi
ln -s "$1" "$SEED$TFILE"
