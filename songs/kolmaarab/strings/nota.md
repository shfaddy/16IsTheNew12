# Melody of "Qalb Qalby" to Be Played Using the Tin Instrument

## Drone

```scenario oscilla

--instance drone

channel = drone
ornaments = 1
octave = 7
distance = 0
method = 2
parameter1 = 3
attack = 4
decay = 0
sustain = 2
drone = $drone

+ #define drone #1/32#

* 0 0 $drone 9 4

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

## Bass

```scenario xoscilla

--instance percussion

step --wrapper none
channel = percussion
octave = 7
distance = 2
method = 2
parameter1 = 4
attack = 6
decay = 0
sustain = 3
tone --attach
drone = 4

+ #define chord1 #9#
+ #define chord2 #4#

ornaments = 1
ornament = 16

* 0 0 1/4 $chord1 $chord2

* + 3 1/4 $chord1 $chord2

* + 4 1/2 $chord1 $chord2

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

* [10/8] 0 0

```

## Men Qalb Qalby

```scenario oscilla

* + 0 1/4
* + 3
* + 4
* + 9
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

* + 9 1/4
* + 13
* + 12
* + 9
* + 8
* + 4 1/8
* + 8
* + 4
* + 8
* + 9 1/2

```

## Sot Faraihy BHamsa

```scenario oscilla

* + 0 1/8
* + 3
* + 0 1/4
* + 4
* +
* + 9 1/8
* + 8
* + 9
* + 8
* + 9
* + 8
* + 4
* + -1

```

## Beysaal Lao Rohy Hassa

```scenario oscilla

* + 0 1/8
* + -1
* + 0 1/4
* + 0 1/8
* + 4 1/4
* + 4 1/8
* + 9
* + 8
* + 9
* + 8
* + 9
* + 8

```

## Wala Ana Fel Maddy Lessa

```scenario oscilla

* + 9 1/4
* + 16
* + 16
* + 13
* + 12
* + 13 1/8
* + 12
* + 9
* + 8
* + 9
* + 8
* + 9
* +

```

## Taieh Mesh Ader Ansa

```scenario oscilla

* + 4 1/8
* + 3
* + 0 1/4
* + 0 1/8
* + 3 1/4
* + 4 1/8
* + 9
* + 8
* + 9
* + 8
* + 9 1/4
* + 4 1/8
* + 8
* + 9 1/4
* + 4 1/8
* + 8
* + 9 1/4

```

## Ana Kol MaArab Mennek Khtwa

```scenario oscilla

ornaments = 4

* + 9 1/4
* + 16
* + 16
* + 13
* + 13
* + 12
* + 12
* + 9
* + 9
* + 4
* + 3
* + 4
* + 0

```

## Bahess BRaha Ghariba Alaia

```scenario xoscilla



```

## WeLaiet FelRaha Farha Farida

```scenario xoscilla

```

## Men Gowaia Mesket Fia

```scenario xoscilla


```

## Ah Lao Teksary Khofy LeShei Men LKhaial

```scenario xoscilla

```

## Arsa Ala Ardek WArtah Men LTerhal

```scenario xoscilla



```

```scenario oscilla

loopback = 1 * + 0 -1

```
