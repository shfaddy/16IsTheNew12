# Music Nota

```scenario oscilla

+ r 2

```

```scenario oscilla

--read placement

```

```scenario oscilla

--read clock

```

## Instrument

```scenario oscilla

+ { 4 instrument

tin .

channel = chord

octave = 5+$instrument

distance = 2

ornaments = $instrument

+ b 0
+ a 0 0 0

--read from ~ melody.draft

..

+ }

+ s

--read clock

tin .

+ { 4 instrument

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

* 0 $do 1

..

+ }

+ s

```
