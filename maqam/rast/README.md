# Maqam Rast Tuned Using the 16-TET Tuning System

## Scale Formula (In Cents, Per Step):

According to MaqamWorld, [Maqam Rast](https://www.maqamworld.com/en/maqam/rast.php) is tuned in the following way:

* 0
* +204
* +340 (step size from 2→3 is ~136 cents)
* +498 (step: 158 cents)
* +702 (step: 204 cents)
* +854 (step: 152 cents)
* +1050 (step: 196 cents)
* +1200 (octave, step: 150 cents)

* 0
* +225
* +375 (step size from 2→3 is 150 cents)
* +525 (step: 150 cents)
* +750 (step: 225 cents)
* +900 (step: 150 cents)
* +1050 (step: 150 cents)
* +1200 (octave, step: 150 cents)

## Options

```scenario oscilla

--options .

-o dac

..

```

## Header

```scenario oscilla

--header .

sr = 48000
ksmps = 32
nchnls = 2
0dbfs = 1

giStrikeFT ftgen 0, 0, 256, 1, "prerequisites/marmstk1.wav", 0, 0, 0
giVibratoFT ftgen 0, 0, 128, 10, 1

..

```

## Kit

```scenario oscilla

--instrument clock
--instrument key
--instrument mixer
--instrument loopback

--instrument tin
--instrument dom
--instrument tak
--instrument sak
--instrument sik
--instrument sagat

```

## Generate Code

```scenario oscilla

--code

```

## Nota

```scenario oscilla

--produce nota

```
