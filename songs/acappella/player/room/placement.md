# Instruments Placement

```scenario oscilla

length = -1

```

## Vocal

```scenario oscilla

--instance vocal

distance = 2^-1

left = vocal
right = vocal

dry = 2^-8
wet = 2^1

roomMin 1
roomMax 1

dampMin = 1
dampMax = 1

delayMin = 2^-1
delayMax = 2^-1

feedbackMin = 2^-2
feedbackMax = 2^-2

*

```

```scenario oscilla

--instance percussion

distance = 0

left = percussion
right = percussion

dry = 2^-3
wet = 2^4

roomMin 3/8
roomMax 3/8

*

```
