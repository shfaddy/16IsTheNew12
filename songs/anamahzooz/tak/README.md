# Tak Instrument Design

## Parameters

```scenario oscilla

note --attach + .$finger

step --attach + $finger/2^9

length = (1/2)

--parameter tone

tone --attach + ( $finger * 4 ) + ( ~ * 2 )

--parameter channel --string

--parameter distance = 1

```

## Body

```scenario oscilla

--body .

aNote = 0

iAttack init 1/2^7
iDecay init 1/2^6 
iSustain init 1/2^4
iRelease init 1/2^6

p3 init iAttack + iDecay + iRelease

iPitch init 2^(iPTone/16)

aMainSubAmplitude linseg 0, iAttack, 1, iDecay, iSustain, iRelease, 0

aMainSubFrequency linseg 2^12, iAttack/2, 2^8

aMainSub poscil aMainSubAmplitude, aMainSubFrequency * iPitch

aNote += aMainSub

aHighSubAmplitude linseg 0, iAttack, 1, iDecay/8, iSustain, iRelease/8, 0

aHighSubFrequency linseg 2^14, iAttack/2, 2^9

aHighSub poscil aHighSubAmplitude, aHighSubFrequency * iPitch

aNote += aHighSub / 4

aGogobell gogobel 1, 2^8 * iPitch, .5, .5, giStrikeFT, 6.0, 0.3, giVibratoFT

aNote += aGogobell / 4

aSnatchAmplitude linseg 0, iAttack/2, 1, iDecay/8, 0

aSnatchFrequency linseg 2^13, iAttack/2, 2^11

aSnatch noise aSnatchAmplitude, 0

aSnatch butterlp aSnatch, aSnatchFrequency * iPitch

aNote += aSnatch

aNote clip aNote, 1, 1

chnmix aNote / ( iPDistance + 1 ), SPChannel

..

```
