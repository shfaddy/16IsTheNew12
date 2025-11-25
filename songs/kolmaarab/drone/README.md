# Drone Nota

```scenario oscilla

channel = drone

ornaments = 3

octave = 8

distance = 8

```

```scenario oscilla

+ #define thickness #64#

+ #define measure #8#

+ v $measure

+ { 128 bar

+ b [ $bar * $measure ]

+ { $thickness beat

* $beat/$thickness 0 1/$thickness 5 4

+ }

+ }

..

```
