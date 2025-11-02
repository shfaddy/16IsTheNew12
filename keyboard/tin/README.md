# Tin Instrument

## Parameters

```scenario oscilla

--read parameters

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

kRoom rspline 1/2, 1, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )

kDamp rspline 3/4, 1, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )

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

outs aLeft, aRight

gaTin [ 0 ] = 0
gaTin [ 1 ] = 0

endin

..

+ i "_tin" 0 -1

```

## Body

```scenario oscilla

--body .

p1 init int ( p1 ) + rnd ( .99999 )

iAttack init 1 / 2^( 6 + rnd ( 1 ) )
iDecay init $p_length / 2^( 0 + rnd ( 1 ) )
iSustain init 1/2^2
iRelease init iDecay * 2^0

iFrequency init 2^( iPOctave + ( ( giKey + iPTone ) / iPScale ) )

kAmplitude linsegr 0, iAttack, 1, iDecay, iSustain, iRelease, 0

iDetune init 2^7

kDetune rspline 2^(-1/iDetune), 2^(1/iDetune), 0, 1 / ( $p_length * 2^2 )

kFrequency linsegr iFrequency * 2^( rnd ( 4 ) / iDetune ), $p_length, iFrequency, iRelease, iFrequency * 2^( rnd ( -4 ) / iDetune )

kFrequency *= kDetune

aNote pluck kAmplitude, kFrequency, iFrequency, 0, iPMethod, iPParameter1, iPParameter2

aNote butterlp aNote, kFrequency * 2^.75

aNote butterhp aNote, kFrequency / 2^.75

gaTin [ iPChannel ] = gaTin [ iPChannel ] + aNote

..

```
