# Tin Instrument

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

iAttack init $p_length / 2^13
iDecay init $p_length / 2^13

aAmplitude linseg 0, iAttack, 1, iDecay, 0

iFrequency init 2^( iPOctave + ( ( giKey + iPTone ) / iPScale ) )

aFrequency linsegr iFrequency * 2^(32/16), iAttack / 2^0, iFrequency, iDecay / 2^0, iFrequency * 2^(0/16)

aClip rspline 0, 1, 0, $p_length

aSkew rspline -1, 1, 0, $p_length

aNote squinewave aFrequency, aClip, aSkew

aNote *= aAmplitude / 2^2

aAmplitude linseg 0, iAttack, 1, $p_length - iAttack, 0

aPluck pluck k ( aAmplitude ), k ( aFrequency ) / 2^0, iFrequency, 0, 1

aNote += aPluck / 2

aNote butterlp aNote, aFrequency * 2^1

aNote butterhp aNote, aFrequency / 2^0

chnmix aNote / ( iPDistance + 1 ), SPChannel

..

```
