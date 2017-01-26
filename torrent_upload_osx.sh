#!/bin/bash

PATH=$PATH:/usr/local/bin:/opt/local/bin
tracker="other"
folder="/Users/adam/Downloads"
if [ -n "$(find $folder -name "*.torrent")" ]; then
    for t in $folder/*.torrent; do
        echo $t
        if [ -n "$(grep tracker.what.cd "$t")" ]; then
            tracker="what.cd"
        elif [ -n "$(grep -E 'tracker.\.tvtorrents\.com' "$t")" ]; then
            tracker="tvt"
        elif [ -n "$(grep -E 'tracker\.torrentleech\.org' "$t")" ]; then
            tracker="couchpotato"
        fi
        if [ -n $tracker ]; then
            alerter -timeout 2 -title "$0" -message "Uploading $t to $tracker"
            cp  "$t" /Volumes/dl/watch/$tracker
            if [ $? -ne 0 ]; then
                alterter -title "$0" -message "Failed to move torrent"
            fi
            mv "$t" ~/.Trash/
        fi
done
fi
