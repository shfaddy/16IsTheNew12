# Music Nota

```scenario oscilla

--read placement

```

## Instrument

```scenario oscilla

tin .

channel = chord

octave = 7+$instrument

distance = 1

ornaments = 3

..

```

```scenario oscilla

bow .

channel = drone

octave = 6+$instrument

distance = 0

ornaments = 3

..

```

```scenario oscilla

--read clock

+ { 2 instrument

+ b 2

+ { 4 beat

tin * $beat/4 $fa 1/4

bow * $beat/4 $fa 1/4

+ }

+ }

+ f 0 1

+ s

```

```scenario oscilla

+ r 2

--read clock

+ b 0
+ a 0 0 0

```

```scenario oscilla

+ { 2 instrument

tin --read from ~ melody

bow --read from ~ melody

+ }

+ s

--read clock

tin .

+ { 2 instrument

+ $bar(0)

* 0 $sol 1

+ $bar(1)

* 0 $fa 1/4
* 1/4 $fa
* 2/4 $mi 1/2

+ $bar(2)

* 0 $re 1/2
* 1/2 -16+$si

+ $bar(3)

* 0 $do 1/2

..

+ }

+ s 14

```
