#!/bin/bash #tells the os which program to use to interpert this script

ls -lR $1 > raw.temp

awk ' 

BEGIN { RS = "" } ;

{
  split($0, x, ":\n");
  if (x[2] !~ /\nd|\.srt\n/) {
    print x[1];
  }
} 

' raw.temp > folders.temp #Thing long command sequence goes though and looks for all movies to find what you want awk is a language that is used to look though large amounts of data at once

rm raw.temp #Removes the temporary folder

CURL_VERSION=$ #Defines the curlversion used 

while read FOLDER; do #When the code is being read do the following 
  VID_EXT_RE="\.(mpg|MPG|flv|FLV|wmv|WMV|avi|AVI|mkv|MKV|mov|MOV|mp4|MP4)$"
  for FILE in "$FOLDER"/*.*; do
    if [[ "$FILE" =~ $VID_EXT_RE ]]; then
      MD5=$(./md5ex.sh "$FILE") #Uses the code written in the other script and defenes MD5 as the list MD5 file that is created from the other program
      echo $FILE " " $MD5
      #curl -A "SubDB/1.0 (curl/7.35.0 https://curl.haxx.se)" "http://api.thesubdb.com/?action=download&hash=$MD5&language=en" -o "$FOLDER/engsub.srt" This is the link to the website with   the subtitles 
    fi 
  done
done < folders.temp #Tells you if it is ok to remove the folders.temp file:

rm folders.temp #Removes the folder used to holt the moves without subtitles 
