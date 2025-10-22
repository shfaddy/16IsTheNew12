# Shaikh Faddy's Songs in A Cappella

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

sr = 32768
ksmps = 32
nchnls = 2
0dbfs = 1

giKey = 0

..

```

### Kit

```scenario oscilla

--instrument room
--instrument mixer
--instrument loopback

--instrument drone
--instrument claps

```

```scenario oscilla

+ t 0 90

```
