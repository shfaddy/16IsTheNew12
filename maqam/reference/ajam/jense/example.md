# Ajam Jense Example

## Mahla Norha

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
* .5/4 $D
* 1/4 $C 1/4
* 2/4 $E
* 3/4 $D 1/2

+ b 5

* 0 $C 1/8
* 1/8 $B-$scale
* 1/4 $C 1/4
* 2/4 $G-$scale 1/2

+ b 8

* 0 $G-$scale 1/4
* 1/4 $C
* 2/4 $D
* 3/4 $E 1/8
* 3.5/4 $D

+ b 12

* 0 $C 1/8
* .5/4 $D
* 1/4 $D 1/2

+ b 15

* 0 $C 1/4
* 1/4 $C 1/8
* 1.5/4 $D
* 2/4 $E 1/4

+ b 18.5

* 0 $D 1/8
* .5/4 $E 1/4

+ b 20.5

* 0 $C 1/8
* .5/4 $G 1/4
* 1.5/4 $C

+ b 23

* 0 $G 1/8
* .5/4 $A
* 1/4 $G 1/4

+ }

+ s 28

..

```
