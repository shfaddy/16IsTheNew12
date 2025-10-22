# Ajam Jense Example

## Mahla Norha

```scenario oscilla

+ a 0 8 12

~ --read clock

tin .

ornaments = 1

+ #define octave #8#

+ v 4

+ { 2 channel

+ b 0

* 0 $C 1/4
* 1/4
* 2/4 $E
* 3/4 $D 1/2

+ b 5

* 0 $C 1/8
* 1/8 $B-$scale
* 1/4 $C 1/4
* 2/4 $G-$scale

+ b 8

+ }

+ s 20

..

```
