# Synthesizer Setup

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

giKey = 7

..

```

## Kit

```scenario oscilla

--instrument recorder

```
