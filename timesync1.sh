#!/bin/bash

# Get the remote time in UTC from the "curl" command
remote_time=$(curl -I https://google.com/ | grep Date | awk '{print $3,$4,$5,$6}')

# Get the local timezone from timedatectl
local_timezone=$(timedatectl | grep "Time zone:" | awk '{print $3}')

# Convert the remote time to the local timezone
changed_remote_time=$(date -d "$remote_time UTC" +"%F %T %Z" | TZ="$local_timezone" date +"%F %T %Z")

# Echo the changed remote time
#echo "Changed remote time: $changed_remote_time"

#time only
time=$(echo  $changed_remote_time | cut -d' ' -f2)

timedatectl set-time $time
