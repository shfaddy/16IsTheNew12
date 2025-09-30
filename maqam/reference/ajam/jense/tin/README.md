# Tin Instrument

## Parameters

```scenario oscilla

--read parameters

note --attach + .$octave
scale = $scale
octave = $octave
channel = $channel
distance = 0
ornaments = 1

```

## Header

```scenario oscilla

--header .

massign 0, "tin"

giTone [] init 12

giTone [ 0 ] init $C
giTone [ 2 ] init $D
giTone [ 4 ] init $E
giTone [ 5 ] init $F
giTone [ 7 ] init $G
giTone [ 9 ] init $A
giTone [ 11 ] init $B

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

iKey init 0
iVelocity init 0

midinoteonkey iKey, iVelocity

if iKey > 0 then

$p_length init 1/2^2

iPOctave init 3 + int ( iKey / 12 )
iPTone init giTone [ iKey % 12 ]
iPScale init 16

endif

--read from ~ tin ornaments

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

aPluck pluck k ( aAmplitude ), k ( aFrequency ) / 2^0, iFrequency, 0, 1

aNote += aPluck / 2

aNote butterlp aNote, aFrequency * 2^1

aNote butterhp aNote, aFrequency / 2^0

gaTin [ iPChannel ] = gaTin [ iPChannel ] + aNote / ( iPDistance + 1 )

..

```
