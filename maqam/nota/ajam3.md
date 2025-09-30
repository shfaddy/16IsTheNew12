# Maqam Ajam (3rd Variant) Nota

```scenario oscilla

~

+ t 0 $tempo

+ #define measure #16#

+ f 0 $measure

+ { 2 channel

+ v [ $measure/2 ]

+ { 2 time

+ b [ $time * $measure/2 ]

~ --read nota wahda
~ --read nota wenoss

+ }

+ v $measure

tin .

distance = 1/2

ornaments = 3

+ #define octave #8#

--read from ~ nota ajam3.scale

distance = 1/2

ornaments = 4

+ #define octave #9#

--read from ~ nota ajam3.scale

distance = 1/2

ornaments = 5

+ #define octave #7#

--read from ~ nota ajam3.scale

distance = 3

ornaments = 4

+ #define octave #10#

--read from ~ nota ajam3.scale

distance = 0

ornaments = 4

+ #define octave #6#

--read from ~ nota ajam3.scale

distance = 0

ornaments = 4

+ #define octave #5#

--read from ~ nota ajam3.scale

+ }

~

+ s

```
