# Melody of "Qalb Qalby" to Be Played Using the Tin Instrument

## Drone

```scenario oscilla

--instance drone

channel = drone
drone = 1
ornaments = 3
octave = 6
distance = 4

* 0 0 1/8 16 16

```

## Melody

```scenario oscilla

--instance melody

step --wrapper none
channel = melody
drone = 0
ornaments = 3
octave = 8
distance = 0

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
* + 9
* + 8

* + 9
* + 8
* + 9
* + 4
* + 9
* + 8
* + 9 1/4

```

## Response to "Men Qalb Qalby"

```scenario xoscilla

* + 4 1/8
* + 8
* + 4
* + 8
* + 9
* + 8
* + 9 1/2

```

## Basmaa Sawt Neda

```scenario oscilla

* + 9 1/8
* + 8
* + 4

* + 9
* + 8
* + 4
rewind = 1 * + 0 -1


```
