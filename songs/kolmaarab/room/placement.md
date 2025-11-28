# Instruments Placement

```scenario oscilla

length = -1

```

## Drone

```scenario oscilla

--instance drone

left = drone
right = drone

dry = 5
wet = 0

roomMin 13/16
roomMax 15/16

distance = 12

*

```

## Percussion

```scenario oscilla

--instance percussion

left = percussion
right = percussion

distance = 2^-8

dry = 2^-8
wet = 2^13

roomMin = .1
roomMax = .1

dampMin = 2^5
dampMax = 2^5

delayMin = 2^-1
delayMax = 2^-1

feedbackMin = 2^-2
feedbackMax = 2^-2

*

```

## Melody

```scenario oscilla

--instance melody

left = melody
right = melody

distance = 2^-8

dry = 2^-8
wet = 2^2

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
