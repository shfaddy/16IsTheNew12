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

kCode sense

if kCode > 0 then

kTone = gkTone [ kCode ]

if kTone >= 0 then

schedulek $tin + .1 + ( kCode/10000 ), 0, 1/4, 0, iPOctave, kTone
schedulek $tin + .2 + kCode/10000, 0, 1/4, 0, iPOctave, kTone

endif

endif

..

```

## Start the Keyboard Sensor

```scenario oscilla

length = 2^13 * 0

```
