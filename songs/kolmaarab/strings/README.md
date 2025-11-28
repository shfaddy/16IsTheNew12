# Strings Instrument

## Parameters

```scenario oscilla

--parameter attack = 5
--parameter decay = 3
--parameter sustain = 2
--parameter release

--parameter scale = 16
--parameter octave = 8
--parameter tone

--parameter channel --string
--parameter distance

--parameter method = 1
--parameter parameter1 = 10
--parameter parameter2

```

## Functions

```scenario oscilla

--read --from ~ function loopback
--read --from ~ function drone
--read --from ~ function ornaments

```

## Body

```scenario oscilla

--body .

p1 init int ( p1 ) + rnd ( .99999 )

iAttack init 1 / 2^( iPAttack + rnd ( 1 ) )
iDecay init $p_length / 2^( iPDecay + rnd ( 1 ) )
iSustain init 1/2^iPSustain
iRelease init iDecay * 2^iPRelease

iFrequency init 2^( iPOctave + ( ( giKey + iPTone ) / iPScale ) )

kAmplitude linsegr 0, iAttack, 1, iDecay, iSustain, iRelease, 0

iDetune init 2^7

kDetune rspline 2^(-1/iDetune), 2^(1/iDetune), 0, 1 / ( $p_length * 2^2 )

; kFrequency linsegr iFrequency * 2^( rnd ( 48 ) / iDetune ), $p_length, iFrequency, iRelease, iFrequency * 2^( rnd ( -4 ) / iDetune )
kFrequency linsegr iFrequency * 2^( rnd ( 4 ) / iDetune ), $p_length, iFrequency, iRelease, iFrequency * 2^( rnd ( -4 ) / iDetune )

kFrequency *= kDetune

aNote pluck kAmplitude, kFrequency, iFrequency, 0, iPMethod, iPParameter1, iPParameter2

aNote butterlp aNote, kFrequency * 2^3

aNote butterhp aNote, kFrequency / 2^1

chnmix aNote / ( iPDistance + 1 + rnd ( .01 ) ), SPChannel

..

```

## Play the Nota

```scenario oscilla

--read nota
scratch

```
