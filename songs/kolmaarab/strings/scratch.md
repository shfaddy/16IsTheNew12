# Melody of "Qalb Qalby" to Be Played Using the Tin Instrument

## Drone

```scenario oscilla

--instance drone

channel = drone
ornaments = 3
octave = 6
distance = 2
method = 2
parameter1 = 3
attack = 6
decay = 0
sustain = 2
drone = $drone

+ #define drone #1/8#

* 0 0 $drone 16 16

```

## Rhythm

```scenario oscilla

--instance percussion

step --wrapper none
channel = percussion
octave = 5
distance = 0
method = 3
parameter1 = .5
attack = 6
decay = 2
sustain = 6
tone --attach + ( $hand * 4 )
drone = 1

+ { 8 hand

+ #define dom #0#
+ #define tak #32#

ornaments = 2
ornament = 16

* 0 $dom 1/4

* + $tak

* + $dom

* + $tak

+ }

```

## Melody

```scenario oscilla

--instance melody

step --wrapper none
channel = melody
drone = 0
ornaments = 3
ornament = 0
octave = 8
tone --attach
method = 2
parameter1 = 3
attack = 6
decay = 0
sustain = 2
distance = 2^0

```

```scenario oscilla

+ a 0 0 [ $measure * 0 ]

* [2/8] 0 0

```

## Melody Nota

```scenario oscilla

--read melody.scratch

```
