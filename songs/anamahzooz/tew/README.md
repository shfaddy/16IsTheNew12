# Tew Instrument

## Parameters

```scenario oscilla

note .

--string
--wrapper none
--combinator .

..

--parameter scale = 16
--parameter octave = 8
--parameter tone
--parameter channel --string
--parameter distance
--parameter ornaments

```

## Body

```scenario oscilla

--body .

--read from ~ tin ornaments

p1 init int ( p1 ) + rnd ( .99999 )

iAttack init $p_length / 2^3
iDecay init iAttack / 2^2
iSustain init 1 / 2^1
iRelease init $p_length / 2^3

aAmplitude adsr iAttack, iDecay, iSustain, iRelease

iFrequency init 2^( iPOctave + ( ( giKey + iPTone ) / iPScale ) )

aAmplitude poscil aAmplitude / ( iPDistance + 1 ), iFrequency * 2^0

iAttack /= 2^11
iDecay /= 2^11

aFrequency linseg iFrequency * 2^(16/16), iAttack, iFrequency * 2^(4/16), iDecay, iFrequency * 2^(0/16), iRelease, iFrequency * 2^(-.5/16)

aClip rspline 0, 1, 0, $p_length * 2^2

aSkew rspline -1, 1, 0, $p_length * 2^3

aNote squinewave aFrequency, aClip, aSkew

aNote butterlp aNote, aFrequency * 2^2

aNote *= aAmplitude

chnmix aNote / ( iPDistance + 1 ), SPChannel

..

```
