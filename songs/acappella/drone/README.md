# Drone Instrument

## Parameters

```scenario oscilla

--parameter scale = 16
--parameter octave = 8
--parameter tone
--parameter channel --string
--parameter distance
--parameter ornaments
--parameter method = 2
--parameter parameter1 = 2
--parameter parameter2

```

## Body

```scenario oscilla

--body .

--read from ~ drone ornaments

p1 init int ( p1 ) + rnd ( .99999 )

iAttack init 1 / 2^6
iDecay init $p_length / 2^2

iFrequency init 2^( iPOctave + ( ( giKey + iPTone ) / iPScale ) )

kAmplitude linseg 0, iAttack, 1, $p_length - iAttack, 0

kFrequency linsegr iFrequency * 2^(4/16), iAttack / 2^3, iFrequency, iDecay / 2^3, iFrequency * 2^(-4/16)

aNote pluck kAmplitude, kFrequency, iFrequency, 0, iPMethod, iPParameter1, iPParameter2

aNote butterlp aNote, kFrequency * 2^1

aNote butterhp aNote, kFrequency / 2^0

chnmix aNote / ( iPDistance + 1 ), SPChannel

..

```

## Start the drone

```scenario oscilla

---read nota

```
