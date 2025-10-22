# Drone Nota

```scenario oscilla

channel = drone

ornaments = 3

octave = 8

distance = 4

```

```scenario oscilla

+ #define thickness #64#

+ #define measure #8#

+ v $measure

+ { 1024 bar

+ b [ $bar * $measure ]

+ { $thickness beat

* $beat/$thickness 0 1/$thickness 5 4

+ }

+ }

```
