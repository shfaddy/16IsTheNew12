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

## Melody

```scenario oscilla

--instance melody

step --wrapper none
channel = melody
drone = 0
ornaments = 3
octave = 8
distance = 1

```

```scenario oscilla

+ #define measure #4#
+ v $measure
+ a 0 0 [ $measure * 0 ]

* 0 0 0

```

## Men Qalb Qalby

```scenario oscilla

* + 0 1/4
* + 3
* + 4 1/8
* + 9 1/4
* + 8
* + 9
* + 8
* + 9
* + 8
* + 4
* + 8
* + 9 1/2

```

## Basmaa Sawt Neda

```scenario oscilla

* + 9 1/8
* + 8
* + 4 1/4

* + 9 1/8
* + 8
* + 4
* + 3
* + 0
* + 3
* + 4
* + 8
* + 9 1/4

```

## Mesh Masmow Abl Keda

```scenario oscilla

* + 9
* + 13
* + 12
* + 9
* + 8
* + 4 1/8
* + 8
* + 4
* + 8
* + 9 1/4

```

```scenario oscilla

loopback = 1 * + 0 -1

```
