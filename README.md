radiooooo-cli
=============

http://radiooooo.com command line player

usage
-----
```
>./player.sh
radiooooo-cli 1.1.0 - command line player for http://radiooooo.com

Usage: player.sh [decade] [moods] [country]
    decade: can be from 1910 to 2010 in 10 increments
    moods: contains comma-separated mood list: eg: SLOW,FAST,WEIRD
    country: 3 letters country identification eg: FRA (if not supplied, all countries available for the first 2 args will be shown)

example: player.sh 1960 SLOW,FAST FRA

system commands needed: curl, mpv (or builtin play for osx)
```