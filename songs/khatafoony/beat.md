# Melody

```scenario oscilla

```

```scenario oscilla

dom distance = 0
tak distance = 2
sak distance = 3

--read clock

```

```scenario oscilla

player .

distance = 3

skip = 4.75

length = -1

+ { 2 octave

-note --attach + .$octave

scale = $octave*-16

* 0

+ }

..

```

```scenario xoscilla

recorder *

```

```scenario oscilla

+ v $measure

+ { 1024 beat

+ b [ $beat * $measure ]

+ { 1 channel

dom * 0

+ { 3 finger

sak * 1/4

tak * 2/4

sak * 3/4

+ }

+ }

+ }

+ s

```
