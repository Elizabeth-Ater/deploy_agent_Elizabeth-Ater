#!/bin/bash
set -e

read -r -p "enter your project name: " name
trap 'zip -r "attendance_tracker_${name}_archive.zip" "attendance_tracker_${name}" && rm -rf attendance_tracker_${name}; exit' SIGINT

mkdir -p attendance_tracker_"$name"
cp attendance_checker.py "attendance_tracker_$name"
mkdir -p "attendance_tracker_$name/Helpers" "attendance_tracker_$name/reports"
cp assets.csv config.json "attendance_tracker_$name/Helpers/"
cp reports.log "attendance_tracker_$name/reports"

read -r -p "Do you want to update the attendance threshold? (y/n): " choice

if [ "$choice" = "y" ]; then
    read -r -p "Enter warning threshold: " warning
    read -r -p "Enter failure threshold: " failure

    sed -i "s/75/$warning/g" "attendance_tracker_$name/Helpers/config.json"
    sed -i "s/50/$failure/g" "attendance_tracker_$name/Helpers/config.json"
else
    echo "Keeping the default attendance threshold."    
fi

if python3 --version; then
	echo "Success"
else
   echo "Warning, Python missing"
fi   
