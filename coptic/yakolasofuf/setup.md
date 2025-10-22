# Synthesizer Setup

## Csound Options

```scenario oscilla

--options .

-o dac

..

```

## Csound Header

```scenario oscilla

--header .

sr = 24000
ksmps = 32
nchnls = 2
0dbfs = 1

giKey = 0

..

```

## Kit

```scenario oscilla

--instrument room
--instrument mixer
--instrument loopback

--instrument dom
--instrument tak
--instrument sak
--instrument sik
--instrument sagat

--instrument tin
--instrument bow

+ .

--read from ~ tuning

..

```
