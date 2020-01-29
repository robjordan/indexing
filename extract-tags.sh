#! /bin/bash

sed 's/<START/\n/g' | sed s'/<END>/\n/g' | grep "^:" | sort -u
