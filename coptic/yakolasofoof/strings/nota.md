# Strings Nota for Ya Kol ASofoof Coptic Hymn

## Set the Clock

```scenario oscilla

+ #define measure #2#

+ v $measure

+ a 0 0 [ $measure * 0 ]

```

## Play the Melody Using the Tin Sound

```scenario oscilla

* 0 0 0

--read tin

--read melody

octave = 7

* 0 0 0

--read melody

octave = 9
distance = 1

* 0 0 0

--read melody

```
