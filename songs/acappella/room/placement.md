# Instruments Placement

```scenario oscilla

length = -1

```

## Drone

```scenario oscilla

--instance drone

left = drone
right = drone

dry = 1
wet = 0

roomMin 13/16
roomMax 15/16

*

```

```scenario oscilla

--instance percussion

left = percussion
right = percussion

dry = 0
wet = 2^16

roomMin 3/8
roomMax 4/8

*

```
