# Rhythm

```scenario oscilla

--instance percussion

step --wrapper none
channel = percussion
octave = 5
distance = 0
method = 3
parameter1 = .5

+ #define measure #4#

+ v $measure

+ { 1024 bar

+ { 3 hand

+ b [ ( $bar * $measure ) + ( $hand / 2^8 ) ]

ornaments = 2 * 0 $hand*2:16 1/8
ornaments = 3 * + 32+($hand*2) 2/8
ornaments = 3 * + 32+($hand*2) 1/8
ornaments = 2 * + $hand*2 2/8
ornaments = 3 * + 32+($hand*2)

```

```scenario xoscilla

ornaments = 3 * + 32+($hand*2) 1/4
* +

```

```scenario oscilla

+ }

+ }

```
