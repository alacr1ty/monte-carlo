#!/bin/bash

echo "preparing to push to git repo..."
echo "commit message:"
read message

echo "pushing to repo..."

if [ ! -z "$message" ]
then
	rm -f ./monte-carlo
	
	git add .
	git commit -m "$message"
	git push
	
	if [ $? == 0 ]
	then
		echo push complete.
	fi
fi