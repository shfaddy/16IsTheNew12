# LWadaa Strings Nota

## Set the Clock

```scenario oscilla

+ #define measure #4#

+ v $measure

+ a 0 0 [ $measure * 0 ]

```

## Start the Drone

```scenario oscilla

channel = drone
drone = 1
distance = 2
octave = 6

* 0 0 1/8 16 16

```

## Play the Melody Using the Tin Sound

```scenario oscilla

--read tin

ornaments = 1

+ # define delay #0#

octave = 8 * $delay 0 0

--read melody

-+ $sample_1
-+ $sample_1
+ $sample_2

loopback = 1 * + 0 -1
loopback = 0

```
