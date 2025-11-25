# Clock Instrument

## Header

```scenario oscilla

--header giMeasure init 0

```

## Body

```scenario oscilla

--body .

giMeasure init iPLength

p3 init 0

..

```

## Set the Clock

```scenario oscilla

+ t 0 105

+ #define measure #4#

+ v $measure

* 0 0 1

+ f 0 [ 1024 * $measure ]

```
