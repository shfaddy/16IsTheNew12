# Playback Instrument

## Parameters

```scenario oscilla

--parameter sample
--parameter input = 1
--parameter skip
--parameter tone
--parameter gain = 2
--parameter output --string
--parameter distance

```

## Body

```scenario oscilla

--body .

SSample sprintf "../recorder/channel%d.%d.wav", iPInput, iPSample

p3 filelen SSample

aSample diskin2 SSample, 1, iPSkip

fSample pvsanal aSample, 1024, 256, 1024, 1

kTone init 2^( iPTone / 16 )

fTone pvscale fSample, kTone, 0, iPGain

aNote pvsynth fTone

chnmix aNote / ( iPDistance + 1 ), SPOutput

..

--read nota

```
