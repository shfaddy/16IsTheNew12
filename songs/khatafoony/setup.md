# Synthesizer

## Csound Options

```scenario oscilla

--options .

-i adc

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

giStrikeFT ftgen 0, 0, 256, 1, "prerequisites/marmstk1.wav", 0, 0, 0
giVibratoFT ftgen 0, 0, 128, 10, 1

--read from ~ shaikhfaddys

..

```

## Kit

```scenario oscilla

--instrument mixer
--instrument loopback

--instrument recorder
--instrument player
--instrument dom
--instrument tak
--instrument sak
--instrument sik
--instrument sagat
--instrument tin

```
