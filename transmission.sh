#!/usr/bin/env bash

LOGFILE="/customscripts/c2pp.log"
SBWATCH="/sbwatch"
SEED="/downloads/finished"
BTN="xxxxxxxxxxx.net"

TR_HOST="localhost"
TR_USERNAME="username"
TR_PASSWORD="password"

echo "" >> "$LOGFILE"
echo c2pp.sh running on `date` >> "$LOGFILE"
echo Directory is "$TR_TORRENT_DIR" >> "$LOGFILE"
echo Torrent Name is "$TR_TORRENT_NAME" >> "$LOGFILE"
echo Torrent ID is "$TR_TORRENT_ID" >> "$LOGFILE"
echo Torrent Hash is "$TR_TORRENT_HASH" >> "$LOGFILE"

TR_DOWNLOADED_PATH="$TR_TORRENT_DIR/$TR_TORRENT_NAME"

if [ "$(transmission-remote $TR_HOST -n $TR_USERNAME:$TR_PASSWORD -t $TR_TORRENT_ID -it|grep $BTN)" ]; then
#echo "$TR_DOWNLOADED_PATH" >> "$SBWATCH/$TR_TORRENT_NAME.path"
#echo "$TR_TORRENT_ID" >> "$SBWATCH/$TR_TORRENT_NAME.id"
cp -vR "$TR_DOWNLOADED_PATH" "$SBWATCH" >> "$LOGFILE"
fi