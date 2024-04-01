#!/bin/bash

version='2.0.0'
player='mpv --no-video'
unamestr=`uname`
song_curl='https://radiooooo.com/play'
format='mpeg'
mode='explore'

# for osx, use play
if [[ "$unamestr" == 'Darwin' ]]; then
    player='play'
fi

trap "echo Exited!; exit;" SIGINT SIGTERM

echo -e "radiooooo-cli $version - command line player for https://radiooooo.com\n"

if [ $# -lt 2 ]; then
    echo "Usage: player.sh [decades] [moods] [countries]"
    echo -e "    - decades: contains comma-separated decade list: eg: 1920,1950,1990\n    (decade can be from 1910 to 2020 in 10 year increments)"
    echo -e "    - moods: contains comma-separated mood list: eg: SLOW,FAST,WEIRD"
    echo -e "    - countries: contains comma-separated country list: eg: FRA,USA,ITA.\n    (3 letters country isocode eg: FRA)"
    echo -e "\nexample: player.sh 1960,1980 SLOW,FAST FRA,ITA"
    echo -e "\nsystem commands needed: curl, jq, mpv"
    exit
fi

decades=$1
moods=$2
country=$3

q_moods=`echo \"$moods\" | sed 's/,/","/'`
q_countries=`echo \"$country\" | sed 's/,/","/'`

echo -e "Using '$player' system command\n"

while true; do
    echo "Fetching a new song for $decades - $moods - $country"
    song_json=`curl -s -X POST ${song_curl} -H "Content-Type: application/json" -d "{\"mode\":\"${mode}\",\"moods\":[${q_moods}],\"decades\":[${decades}],\"isocodes\":[$q_countries]}"`
    song_url=`echo $song_json | jq -r ".links.${format}"`
    ${player} $song_url
done
