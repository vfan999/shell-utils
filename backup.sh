#!/bin/bash

DATE=$(date "+%Y-%m-%d")
NEWFILE=$(ls -lt backup | grep "[0-9]\{4\}\(-[0-9]\{2\}\)\{2\}" | head -n 1 | awk '{print $9}')

cd ~
[[ $(ls backup) == "" ]] && cp -r shell backup/$DATE
if [[ shell -nt backup/$NEWFILE ]];then
	[[ -d backup/$DATE ]] && rm -rf backup/$DATE
	cp -r shell/ backup/$DATE
fi
cd backup
ls -lt | grep "[0-9]\{4\}\(-[0-9]\{2\}\)\{2\}" | sed '1,16d' | awk '{print $9}' | xargs rm -rf
