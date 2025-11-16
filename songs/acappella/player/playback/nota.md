# Playback Nota

```scenario oscilla

input = 1
output = vocal
sample = 1763165412
1762799783 1762800283 1762800872

gain = 2
distance = 0

* 0 0 1

gain = 1.5
distance = 0 2^-2

+ #define detune #1/2^2#

* 0 $detune
* 0 -$detune

distance = 0
gain = 1

gain = 1

* 0 -16

```

```scenario oscilla

input = 2
output = percussion

gain = 2
distance = 2^-8

* 0 0

```
