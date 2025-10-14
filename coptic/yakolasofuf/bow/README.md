# Bow Instrument

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

--read from ~ tin ornaments

p1 init int ( p1 ) + rnd ( .99999 )

iAttack init p3 / 2^1
iDecay init ( p3 - iAttack ) / 2^4
iSustain init 3/4
iRelease init ( p3 - iAttack - iDecay ) / 2^2

iFrequency init 2^( iPOctave + ( ( giKey + iPTone ) / iPScale ) )

aAmplitude adsr iAttack, iDecay, iSustain, iRelease

kFrequency linsegr iFrequency * 2^(4/16), iAttack / 2^3, iFrequency, iDecay / 2^3, iFrequency * 2^(-4/16)

aNote pluck 1, kFrequency, iFrequency, 0, iPMethod, iPParameter1, iPParameter2

aNote butterlp aNote, kFrequency * 2^1

aNote butterhp aNote, kFrequency / 2^0

aNote *= aAmplitude

chnmix aNote / ( iPDistance + 1 ), SPChannel

..

```
