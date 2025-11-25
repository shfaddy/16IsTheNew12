# Instruments Placement

```scenario oscilla

length = -1

```

## Drone

```scenario oscilla

--instance drone

left = drone
right = drone

dry = 10
wet = 0

roomMin 13/16
roomMax 15/16

distance = 12

*

```

```scenario oscilla

--instance melody

left = melody
right = melody

distance = 2^-4

dry = 2^-8
wet = 2^3

roomMin = .9
roomMax = .9

dampMin = 2^16
dampMax = 2^16

delayMin = 2^-1
delayMax = 2^-1

feedbackMin = 2^-2
feedbackMax = 2^-2

*

```
