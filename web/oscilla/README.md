# LWadaa

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

giKey = 6

..

```

### Kit

```scenario oscilla

--instrument room
--instrument mixer

+ t 0 97.5

--instrument strings

+ e

```
