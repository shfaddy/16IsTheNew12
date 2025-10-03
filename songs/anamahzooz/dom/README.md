# Dom Instrument Design

## Parameters

```scenario oscilla

length = 1/2

--parameter channel --string
--parameter distance

```

## Header

```scenario oscilla

--header .

giStrikeFT ftgen 0, 0, 256, 1, "prerequisites/marmstk1.wav", 0, 0, 0
giVibratoFT ftgen 0, 0, 128, 10, 1

..

```

## Body

```scenario oscilla

--body .

aNote = 0

iAttack init 1/2^5
iDecay init 1/2^3 
iSustain init 1/2^2
iRelease init 1/2

iPLength init iAttack + iDecay + iRelease

aMainSubAmplitude linseg 0, iAttack, 1, iDecay, iSustain, iRelease, 0

aMainSubFrequency linseg 2^8, iAttack, 2^5

aMainSub poscil aMainSubAmplitude, aMainSubFrequency

aNote += aMainSub

aHighSubAmplitude linseg 0, iAttack/8, 1, iDecay/8, iSustain, iRelease/8, 0

aHighSubFrequency linseg 2^10, iAttack/2, 2^7

aHighSub poscil aHighSubAmplitude, aHighSubFrequency

aNote += aHighSub / 8

aGogobell gogobel 1, 2^5, .5, .5, giStrikeFT, 6.0, 0.3, giVibratoFT

aNote += aGogobell / 4

aSnatchAmplitude linseg 0, iAttack/8, 1, iDecay/8, 0

aSnatchFrequency linseg 2^10, iAttack/2, 2^9

aSnatch noise aSnatchAmplitude, 0

aSnatch butterlp aSnatch, aSnatchFrequency

aNote += aSnatch*4

aNote clip aNote, 1, 1

chnmix aNote / ( iPDistance + 1 ), SPChannel

..

```
