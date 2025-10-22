# Instruments Placement

```scenario oscilla

length = -1

```

## Drone

```scenario oscilla

--instance drone

left = drone
right = drone

dry = 8
wet = 0

*

```

```scenario oscilla

--instance melody

left = melody
right = melody

roomMin 3/8
roomMax 4/8

dry = 0
wet = 4

*

```

```scenario oscilla

--instance percussion

left = percussion-left
right = melody percussion-right

roomMin 1/32
roomMax 4/32

dry = 0
wet = 4

*

```
