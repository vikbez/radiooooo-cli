#!/bin/bash

version='1.0.0'
player='mpv'
unamestr=`uname`
moods_curl='http://radiooooo.com/api/playlist/countriesByTempos/'
song_curl='http://radiooooo.com/api/playlist/next'

# for osx, use play
if [[ "$unamestr" == 'Darwin' ]]; then
    player='play'
fi

trap "echo Exited!; exit;" SIGINT SIGTERM

echo -e "radiooooo-cli $version - command line player for http://radiooooo.com\n"

if [ $# -lt 2 ]; then
    echo "Usage: player.sh [decade] [moods] [country]"
    echo "    decade: can be from 1910 to 2010 in 10 increments"
    echo "    moods: contains comma-separated mood list: eg: SLOW,FAST,WEIRD"
    echo "    country: 3 letters country identification eg: FRA (if not supplied, all countries available for the first 2 args will be shown)"
    echo -e "\nexample: player.sh 1960 SLOW,FAST FRA"
    echo -e "\nsystem commands needed: curl, mpv (or builtin play for osx)"
    exit
fi

decade=$1
moods=$2
country=$3
q_moods=`echo \"$moods\" | sed 's/,/","/'`

echo -e "Using '$player' system command\n"

avail_moods=`curl -s ${moods_curl}${decade}?moods=${moods} | grep -Eoh "[A-Z]{3}|," | tr -d "\n"`

if [ $# -eq 2 ]; then
    echo -e "Available countries for ${decade} - ${moods}:\n$avail_moods"
    exit
fi

while true; do
    echo "Fetching a new song for $decade - $moods - $country"
    next_song=`curl -s ${song_curl} -H "Content-Type: application/json" --data-binary "{\"decade\":\"${decade}\",\"country\":\"${country}\",\"moods\":[${q_moods}]}" | grep -Eoh "http://[^\"]+" | head -n 1`
    ${player} $next_song
done
