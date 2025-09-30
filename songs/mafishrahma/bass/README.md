# Bass Instrument

## Parameters

```scenario oscilla

--read parameters

```

## Body

```scenario oscilla

--body .

--read from ~ bass ornaments

iAttack init $p_length / 2^13
iDecay init $p_length / 2^13

aAmplitude linseg 0, iAttack, 1, iDecay, 0

iFrequency init 2^( iPOctave + ( ( giKey + iPTone ) / iPScale ) )

aFrequency linsegr iFrequency * 2^(32/16), iAttack / 2^0, iFrequency, iDecay / 2^0, iFrequency * 2^(-4/16)

aClip rspline 0, 1, 0, $p_length

aSkew rspline -1, 1, 0, $p_length

aNote squinewave aFrequency, aClip, aSkew

aNote *= aAmplitude / 2^2

aAmplitude linseg 0, iAttack, 1, $p_length - iAttack, 0

aNote butterlp aNote, aFrequency * 2^1

aNote butterhp aNote, aFrequency / 2^0

..

```
