# Clock Instrument

## Parameters

```scenario oscilla

length = 1
--parameter tempo = $tempo

```

## Header

```scenario oscilla

--header .

giMeasure init 0
giTempo init 0

..

```

## Body

```scenario oscilla

--body .

giMeasure init iPLength
giTempo init iPTempo

..

```

## Start the Clock

```scenario oscilla

+ #define tempo #96#

+ t 0 $tempo

+ #define measure #4#

+ v $measure

* 0

```
