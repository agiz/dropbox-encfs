#!/bin/sh

# This script is syncs dropbox folder
# as per cron settings as opposed to
# dropbox listening and running all
# the time. To sync once every day
# crontab -e
# 35   5    *   *   * /home/dropbox/dropbox-cron.sh >/dev/null 2>&1
# # This command will execute at 5:35am every day.
# http://www.cronchecker.net/

set -e

# update soft link when upgrading dropbox
# ln -s nautilus-dropbox-x.x.x dropbox-current

dropbox=/home/dropbox/dropbox-current/dropbox

$dropbox start
# start dropbox

sleep 20
# give some time

# Possible outputs of dropbox status:
#Dropbox isn't running!
#Connecting...
#Starting...
#Indexing...
#Downloading file list...
#Up to date

i=0

while [ $i -lt 10 ]
do
  X=`$dropbox status`
  if [ "$X" = "Up to date" ]; then
    break
  fi
  sleep 10
  i=`expr $i + 1`
done

$dropbox stop

