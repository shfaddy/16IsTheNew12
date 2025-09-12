# Nota

```scenario oscilla

~

+ #define tempo #120#

+ y

+ v 8

+ { 2 channel

+ b 0

tin octave = 8 --read from ~ nota 16-ascending

+ b 8

tin --read from ~ nota 16-descending

+ }

+ b 0

+ a 0 0 16

+ s 16

```

```scenario oscilla

~

+ t 0 $tempo

+ v 4

+ { 2 channel

+ { 4 finger

sagat --read from ~ nota tempo

+ }

+ }

+ a 0 0 4

+ s 4

```

```scenario oscilla

+ t 0 $tempo

+ v 16

+ { 2 channel

+ b 0

tin octave = 8 --read from ~ nota rast

+ }

+ s 16

```

```scenario oscilla

loopback length = -1 * 0

```
