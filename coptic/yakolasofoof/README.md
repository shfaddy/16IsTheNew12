# Ya Kol ASofoof

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

--read clock

--instrument room
--instrument mixer
--instrument loopback

+ --read from ~ tuning

--instrument dom
--instrument tak
--instrument sak
--instrument sik
--instrument sagat

--instrument strings

```

### Loopback

```scenario xoscilla

loopback length = -1 *

```
