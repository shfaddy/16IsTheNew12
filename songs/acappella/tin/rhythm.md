# Rhythm

```scenario oscilla

--instance percussion

step --wrapper none
channel = percussion
ornaments = 2
octave = 6
distance = 0
method = 3
parameter1 = .5

+ #define measure #4#

+ v $measure

+ { 1024 bar

+ { 3 hand

+ b [ ( $bar * $measure ) + ( $hand / 2^8 ) ]

* 0 $hand*16 1/8
* + 16+($hand*16) 2/8
* + 16+($hand*16) 1/8
* + $hand*16 2/8
* + 16+($hand*16)

```

```scenario xoscilla

* + 16+($hand*16) 1/4
* +

```

```scenario oscilla

+ }

+ }

```
