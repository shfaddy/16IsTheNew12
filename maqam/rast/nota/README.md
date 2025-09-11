# Nota

```scenario oscilla

~

+ y

+ v $measure

+ { 2 channel

+ { 1 time

+ b [ $measure * $time ]

tin octave = 8 --read from ~ nota 16-ascending

+ b [ $measure * ( $time + 1 ) ]

tin --read from ~ nota 16-descending

+ }

+ }

+ b [ $measure * 2 ]

```

```scenario oscilla

~

+ { 2 channel

+ { 4 finger

sagat --read from ~ nota tempo

+ }

+ }

```

```scenario oscilla

loopback length = -1 * 1

```
