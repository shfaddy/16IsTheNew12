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

sr = 48000
ksmps = 32
nchnls = 2
0dbfs = 1

giKey = 9

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
--instrument claps

--instrument tin
--instrument tew

```
