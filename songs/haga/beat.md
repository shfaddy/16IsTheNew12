# Melody

## Salam Ya Samir

```scenario oscilla

player distance = 2
dom distance = 0
tak distance = 2
sak distance = 3

+ a 0 0 [4-.655]

+ a 0 40 -1

--read clock

+ v 4

+ #define chorus #9#

+ { $chorus voice

player .

note --attach + ($voice/$chorus)

distance = $chorus/1.25

loop = 1+($voice*9)

length = -1

* 1

..

+ }

+ { 2 channel

+ { 10 beat

+ b [ ( 4 * $beat ) + .655 ]

+ #define octave #8#

tin ornaments = 1
tin distance = 10000

tin * 0 $C 1/4
tin * 1/4
tin * 2/4
tin * 3/4

dom * 0
dom * 5/8

+ { 3 finger

tak * 1.5/8
tak * 3/8
tak * 6/8

sak * 1/16
sak * 2/16
sak * 4/16
sak * 5/16
sak * 7/16
sak * 8/16
sak * 9/16
sak * 11/16
sak * 13/16
sak * 14/16
sak * 15/16

+ }

+ }

+ }

+ s

```
