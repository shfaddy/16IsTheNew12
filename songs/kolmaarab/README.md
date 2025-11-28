# Kol MaArab

## Synthesizer Setup

### Csound Options

```scenario oscilla

--options .

-o dac

..

```

### Csound Header

```scenario oscilla

--header .

sr = 48000; 32768
ksmps = 64
nchnls = 2
0dbfs = 1

giKey = 0

..

```

### Kit

```scenario oscilla

--instrument clock
--instrument room
--instrument mixer

--produce function

--instrument strings
--instrument claps

```
