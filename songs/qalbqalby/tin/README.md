# Tin Instrument

## Parameters

```scenario oscilla

--parameter loopback
--parameter scale = 16
--parameter octave = 8
--parameter tone
--parameter channel --string
--parameter distance
--parameter drone = 0
--parameter ornaments
--parameter method = 1
--parameter parameter1 = 10
--parameter parameter2

```

## Body

```scenario oscilla

--body .

if iPLoopback > 0 then

rewindscore

endif

--read from ~ tin drone
--read from ~ tin ornaments

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

chnmix aNote / ( iPDistance + 1 + rnd ( .01 ) ), SPChannel

..

```

## Start the drone

```scenario oscilla

---read drone

--read melody

```
