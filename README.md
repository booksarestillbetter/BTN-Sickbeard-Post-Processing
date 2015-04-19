# BTN-Sickbeard-Post-Processing

## sickbeard.sh
kind of a legacy script to copy files and the symlink them back, useful if you can't use hardlinks.

## syncQueue.pl
a script to mv, or cp with hardlinks to another folder, mainly used for a btsync type setup where you have a shared folder that one host is putting files in and they are getting synced to various processors such as sickbeard or couchpotato

## transmission.sh
transmission can execute a script whenever a file is completed, this script can be ran by transmission to put files in an outgoing folder, or copy to sickbeard directly.
