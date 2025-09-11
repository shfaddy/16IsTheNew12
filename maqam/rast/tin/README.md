# Tin Instrument

## Parameters

```scenario oscilla

--parameter octave
--parameter tone
--parameter channel = $channel
--parameter distance = 1

```

## Header

```scenario oscilla

--header .

gaTin [] init nchnls

instr _tin

aTinLeft = gaTin [ 0 ]
aTinRight = gaTin [ 1 ]

denorm aTinLeft
denorm aTinRight

seed 0

kRoom rspline 1/2, 1, 1 / giMeasure * 2^2, 1 / giMeasure

kDamp rspline 3/4, 1, 1 / giMeasure * 2^1, 1 / giMeasure

aReverbLeft, aReverbRight freeverb aTinLeft, aTinRight, kRoom, kDamp

iHigh init 2^8

aReverbLeft butterhp aReverbLeft, iHigh
aReverbRight butterhp aReverbRight, iHigh

iLow init 2^12

aReverbLeft butterlp aReverbLeft, iLow
aReverbRight butterlp aReverbRight, iLow

iReverb init 2

aLeft = aTinLeft + aReverbLeft / iReverb
aRight = aTinRight + aReverbRight / iReverb

aLeft clip aLeft, 1, 0dbfs
aRight clip aRight, 1, 0dbfs

gaNote [ 0 ] = gaNote [ 0 ] + aLeft
gaNote [ 1 ] = gaNote [ 1 ] + aRight

gaTin [ 0 ] = 0
gaTin [ 1 ] = 0

endin

..

+ i "_tin" 0 -1

```

## Body

```scenario oscilla

--body .

iAttack init iPLength / 2^6
iDecay init iPLength / 2^6

aAmplitude linseg 0, iAttack, 1, iDecay, 0

iFrequency init 2^( iPOctave + ( ( giKey + iPTone ) / 16 ) )

aFrequency linsegr iFrequency * 2^(4/16), iAttack / 2^6, iFrequency, iDecay / 2, iFrequency * 2^(-4/16)

aClip rspline 0, 1, 0, iPLength

aSkew rspline -1, 1, 0, iPLength

aNote squinewave aFrequency, aClip, aSkew

aNote *= aAmplitude / 2^2

aAmplitude linseg 0, iAttack, 1, iPLength - iAttack, 0

aPluck pluck k ( aAmplitude ), k ( aFrequency ) / 2^0, iFrequency, 0, 1

aNote += aPluck / 2

aNote butterlp aNote, aFrequency * 2^2

aNote butterhp aNote, aFrequency / 2^0

gaTin [ iPChannel ] = gaTin [ iPChannel ] + aNote / 2^iPDistance

..

```
