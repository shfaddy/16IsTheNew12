# Sagat Instrument Design

## Parameters

```scenario oscilla

note --attach + .$channel + .0$finger

step --attach + $finger/2^16

length = (1/2^3)

--parameter tone

tone --attach + ~ + ( $finger * 4 )

( $finger/2 ) + ( ~ )

--parameter channel = $channel

--parameter distance = 3

```

## Body

```scenario oscilla

--body .

aNote = 0

iAttack init 1/2^8
iDecay init 1/2^4 
iSustain init 1/2^5
iRelease init 1/2^4

iPLength init iAttack + iDecay + iRelease

iPitch init 2^(iPTone/16)

aMainSubAmplitude linseg 0, iAttack, 1, iDecay, iSustain, iRelease, 0

aMainSubFrequency linseg 2^18, iAttack/2, 2^12

aMainSub poscil aMainSubAmplitude, aMainSubFrequency * iPitch

aNote += aMainSub

aHighSubAmplitude linseg 0, iAttack, 1, iDecay/8, iSustain, iRelease/8, 0

aHighSubFrequency linseg 2^19, iAttack/2, 2^13

aHighSub poscil aHighSubAmplitude, aHighSubFrequency * iPitch

aNote += aHighSub / 2

aHighestSubAmplitude linseg 0, iAttack, 1, iDecay/8, iSustain, iRelease/8, 0

aHighestSubFrequency linseg 2^20, iAttack/2, 2^14

aHighestSub poscil aHighestSubAmplitude, aHighestSubFrequency * iPitch

aNote += aHighestSub / 4

aGogobell gogobel 1, 2^13 * iPitch, .5, .5, giStrikeFT, 6.0, 0.3, giVibratoFT

aNote += aGogobell / 4

aSnatchAmplitude linseg 0, iAttack/4, 1, iDecay/8, 0

aSnatchFrequency linseg 2^16, iAttack/2, 2^13

aSnatch noise aSnatchAmplitude, 0

aSnatch butterlp aSnatch, aSnatchFrequency * iPitch

aNote += aSnatch

aTambourine tambourine 1, iPLength / 2^3, 2^4, .5, .5, ( 2^11 ) * iPitch, ( 2^12 ) * iPitch, ( 2^13 ) * iPitch

aNote += aTambourine/2^0

aNote clip aNote, 1, 1

gaNote [ iPChannel ] = gaNote [ iPChannel ] + aNote / ( iPDistance + 1 )

..

```
