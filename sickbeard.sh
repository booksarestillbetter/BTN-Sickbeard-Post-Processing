#!/usr/bin/env bash

LOGFILE="/customscripts/symlinks.log"
SBWATCH="/sbwatch"
SEED="/downloads/finished"
TFILE="default-file-so-we-do-not-remove-the-hole-seed-dir-if-error.txt"

echo "New [1]: $1" >> "$LOGFILE"
echo "old [2]: $2" >> "$LOGFILE"
echo "creating symlink" >> "$LOGFILE"

TFILE="${2##$SBWATCH}"
echo "$TFILE" >> "$LOGFILE"

#no do the removal and link
echo "rm -rf $SEED$TFILE" >> "$LOGFILE"
rm -rf "$SEED$TFILE"

echo "ln -s $1 $SEED$TFILE" >> "$LOGFILE"
ln -s "$1" "$SEED$TFILE"