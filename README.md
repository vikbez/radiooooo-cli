radiooooo-cli
=============

https://radiooooo.com command line player

usage
-----
```
>./player.sh
radiooooo-cli 2.0.0 - command line player for https://radiooooo.com

Usage: player.sh [decades] [moods] [countries]
    - decades: contains comma-separated decade list: eg: 1920,1950,1990
      (decade can be from 1910 to 2020 in 10 year increments)
    - moods: contains comma-separated mood list: eg: SLOW,FAST,WEIRD
    - countries: contains comma-separated country list: eg: FRA,USA,ITA
      (3 letters country isocode eg: FRA)

example: player.sh 1960,1980 SLOW,FAST FRA,ITA

system commands needed: curl, jq, mpv
```
