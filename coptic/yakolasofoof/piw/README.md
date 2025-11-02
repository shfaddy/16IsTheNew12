# Piw Instrument

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
--parameter method = 2
--parameter parameter1 = 2
--parameter parameter2

```

## Body

```scenario oscilla

--body .

--read from ~ tin ornaments

p1 init int ( p1 ) + rnd ( .99999 )

iAttack init $p_length / 2^13
iDecay init $p_length / 2^13

iFrequency init 2^( iPOctave + ( ( giKey + iPTone ) / iPScale ) )

kAmplitude linseg 0, iAttack, 1, $p_length - iAttack, 0

kFrequency linsegr iFrequency * 2^(32/16), iAttack / 2^0, iFrequency, iDecay / 2^0, iFrequency * 2^(-4/16)

aLeft, aRight prepiano iFrequency, \
iPStrings, \
iPDetune, \
iStiffness, \
iT30Decay, \
iHighFrequencyLoss, \
kbcl, kbcr, \
iHammerMass, \
ihammerVibrationFrequency, \
iInitialHammerPosition, \
iStringStrikePosition, \
iStrikeVelocity, \
iScanningFrequency, \
iScanningSpread

aNote *= kAmplitude

aNote butterlp aNote, kFrequency * 2^1

aNote butterhp aNote, kFrequency / 2^0

chnmix aNote / ( iPDistance + 1 ), SPChannel

..

```
