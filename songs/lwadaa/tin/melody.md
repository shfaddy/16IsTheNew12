# Melody of LWadaa to Be Played Using the Tin Instrument

```scenario oscilla

--instance melody

channel = melody

ornaments = 3

octave = 8

distance = 0

```

```scenario oscilla

+ #define measure #4#

+ v $measure

+ a 0 0 [ $measure * 0 ]

* 0 0 0

step --wrapper none

```

## Baol LeMin LWadaa

```scenario oscilla

+ { 2 time

```

```scenario oscilla

* + 0 1/8
* +
* + -1
* + 0
* + -1
* + -5
* + -6
* + -5

+ #define bar #1#

* + -6
* + -9
* + -10
* + -9
* + -6
* + -5
* + -1
* + 0

+ #define bar #2#

```

## MaDomt Ana Dayato

```scenario oscilla

* + 0
* + -1
* + 0
* + 3
* + 0
* + -1
* + 0
* + 3 1/4
* + 3

```

## Response

```scenario oscilla

* + -6 1/8
* + -5
* + -1
* + 0
* + 3

+ #define bar #4#

```

```scenario oscilla

+ }

```

## Habeto Lama Akhani

```scenario oscilla

+ { 2 time

```

```scenario oscilla

* + 7 1/8
* +
* + 6
* + 7 1/4
* + 7 1/8
* + 6
* + 10 1/8
* +
* +
* + 9
* + 4+($time*6)
* + 3+($time*6)
* + 4
* + 3
* + 0

```

## LeHad MaEtamet

```scenario oscilla

* + 4 1/8
* +
* + 3
* + 0 1/4
* + -1+$time
* + 0+(7*$time) 1/8
* + 0+(7*$time)
* +

```

## Response

```scenario oscilla

* + -6+($time*16) 1/8
* + -5+($time*9)
* + -6+($time*9)
* + -5+($time*9)
* + -1+($time*4)
* + 0 1/(8/($time+1))

```

```scenario oscilla

+ }

```

## Delwaati Wahdi

```scenario oscilla

+ { 2 time

```

```scenario oscilla

* + -6 1/4
* + -5
* + -1
* + 0
* + 0  1/8

```

## Response

```scenario oscilla

* + -6+($time*9) 1/8
* + -5+($time*5)
* + -6+($time*5)
* + -5+($time*5)
* + -1+($time*4)
* + $time*4 1/4

```

```scenario oscilla

+ }

```

## Ana Fiha Moaddi

```scenario oscilla

+ { 2 time

```

```scenario oscilla

* + 3 1/8
* + 4
* + 7 1/4
* + 4+($time*3) 1/8
* + 3+($time*4)
* + 4+($time*4) 1/4
* + $time*7 1/8
* + -1+($time*5)
* + $time*7 1/4

```

## Response

```scenario oscilla

* + -5+($time*9) 1/8
* + -1+($time*4)
* + $time*-5 1/4

```

```scenario oscilla

+ }

```

```scenario oscilla

* + -1 1/4
* + 0
* + 3
* + 4
* + 8
* + 10
* +
* +

```

## Baol LeMin LWadaa

```scenario xoscilla

+ { 1 time

```

```scenario xoscilla

* + 0 1/8
* +
* + -1
* + 0
* + -1
* + -5
* + -6
* + -5

+ #define bar #1#

* + -6
* + -9
* + -10
* + -9
* + -6
* + -5
* + -1
* + 0

+ #define bar #2#

```

```scenario xoscilla

+ }

```
