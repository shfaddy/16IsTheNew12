# Chord Nota

```scenario oscilla

+ v 8

tin .

channel = chord

distance = 1

ornaments = 3

octave = 7

..

```

```scenario xoscilla

+ #define divisions #8#

+ { $divisions beat

tin * $beat/$divisions 0 1/$divisions 3 12

+ }

```

```scenario oscilla

tin .

+ v 4

+ { 2 bar

+ b [ 4 * $bar ]

* 0 0 1/8 3 6

* 1/8 3 2/8 3 6

* 3/8 3 1/8 3 6

* 4/8 0 2/8 3 6

* 6/8 16+7 2/8 3 6

..

+ }

```
