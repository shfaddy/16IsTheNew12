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

--read from ~ keys

..

```

## Body

```scenario oscilla

--body .

kCode sense

if kCode > 0 then

kTone = gkTone [ kCode ]

schedulek $tin + .1 + ( kCode/10000 ), 0, 1/4, 0, iPOctave, kTone
schedulek $tin + .2 + kCode/10000, 0, 1/4, 0, iPOctave, kTone

endif

..

```

## Start the Keyboard Sensor

```scenario oscilla

length = 2^13 * 0

```
