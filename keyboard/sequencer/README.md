# Keyboard Sensor Instrument

## Parameters

```scenario oscilla

--read from ~ tin parameters

octave = 8

```

## Header

```scenario oscilla

--header .

gkTone [] init 128

iKey init 0

while iKey < 128 do

gkTone [ iKey ] init -1

iKey += 1

od

--read from ~ keys

..

```

## Body

```scenario oscilla

--body .

kKey init 0

kCode sense

if kCode > 0 then

if kCode == 61 then

kKey += 1

kTone = 0

elseif kCode == 45 then

kTone = 0

kKey -= 1

else

kTone = gkTone [ kCode ]

endif

if kTone >= 0 then

schedulek $tin + .1 + ( kCode/10000 ), 0, 1/4, 0, iPScale, iPOctave, kTone + kKey, iPMethod, iPParameter1, iPParameter2
schedulek $tin + .2 + kCode/10000, 0, 1/4, 0, iPScale, iPOctave, kTone + kKey, iPMethod, iPParameter1, iPParameter2

endif

endif

..

```

## Start the Keyboard Sensor

```scenario oscilla

length = 2^13 * 0

```
