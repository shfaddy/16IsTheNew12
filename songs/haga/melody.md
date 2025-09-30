# Melody

## Salam Ya Samir

```scenario oscilla

+ a 0 0 0

~ --read clock

tin .

ornaments = 1

+ #define octave #8#

+ v 4

+ { 2 channel

+ b 0

* 0 $C 1/8
* 1/8 $D
* 1/4 $C 1/4
* 2/4 $D
* 3/4 $C

+ b 4

* 0 $C 1/8
* 1/8 $B-$scale
* 1/4 $C 1/4
* 2/4

+ }

+ s 8

..

```
