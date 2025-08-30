#!/bin/bash

THRESHOLD=80

USAGE=$(/bin/df -h / | grep '/' | awk '{print $5}' | sed 's/%//')

if [ $USAGE -ge $THRESHOLD ]; then
    echo "⚠️ WARNING: Disk usage reach $USAGE%" | wall
fi
