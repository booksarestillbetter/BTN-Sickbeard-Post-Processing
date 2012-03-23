#!/usr/bin/env bash
# Transmission script to move files to a Sick-Beard
# directory to be processed.

# IF YOUR SBWATCH DIR, AND SEED DIR ARE ON
# DIFFERENT FILE SYSTEMS THEN YOU MUST SET 
# THIS OPTION TO false
USEHARDLINKS=true

# Please do not use the Slickbeard.sh script if
# the above option is set to true. As it creates
# hard links thats can be modified without affecting
# the original file.

# path to a directory that is writable by the tranmission user
LOGFILE="/customscripts/transmission2sb.log"

# Folder that SB processes
SBWATCH="/sbwatch"

# Location where transmission seeds from; download-dir
SEED="/downloads/finished"

# Transmission remote login details.
# Leave username, and password blank for no authenticaiton
TR_HOST="localhost"
TR_USERNAME="username"
TR_PASSWORD="password"

# Tracker for TV
TVTR="xxxxxxxxxxx.net"

# Turn on to get a more detailed output for commands
DEBUG=false 

########################################################
# do not edit below, unless you know what you are doing.
DATE=`date`
TR_DOWNLOADED_PATH="$TR_TORRENT_DIR/$TR_TORRENT_NAME"

echo "" >> "$LOGFILE"
echo "transmission.sh running on $DATE" >> "$LOGFILE"
echo "Directory is $TR_TORRENT_DIR" >> "$LOGFILE"
echo "Torrent Name is $TR_TORRENT_NAME" >> "$LOGFILE"
echo "Torrent ID is $TR_TORRENT_ID" >> "$LOGFILE"
echo "Torrent Hash is $TR_TORRENT_HASH" >> "$LOGFILE"
echo "Working on $TR_DOWNLOADED_PATH" >> "$LOGFILE"

# What to do if tracker matches TVTR
if [ "$(transmission-remote $TR_HOST -n $TR_USERNAME:$TR_PASSWORD -t $TR_TORRENT_ID -it|grep $TVTR)" ]; then
echo "Copying file to SB process directory" >> "$LOGFILE"
if [ "$DEBUG" == "true" ]; then echo "cp -vR $TR_DOWNLOADED_PATH $SBWATCH" >> "$LOGFILE" fi
if [ "$USEHARDLINKS" == "true" ]; then cp -val "$TR_DOWNLOADED_PATH" "$SBWATCH" >> "$LOGFILE" >> "$LOGFILE" fi
if [ "$USEHARDLINKS" == "false" ]; then cp -vR "$TR_DOWNLOADED_PATH" "$SBWATCH" >> "$LOGFILE" >> "$LOGFILE" fi
fi
