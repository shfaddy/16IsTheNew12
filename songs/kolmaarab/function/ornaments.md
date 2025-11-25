# Instrument Ornaments Function

## Parameters

```scenario oscilla

--parameter ornaments
--parameter ornament

```

## Body

```scenario oscilla

--body .

if iPOrnaments > 0 then

iOrnaments init 2 ^ int ( rnd ( $p_ornaments ) )

$p_length /= iOrnaments

iIndex init 1

iPOrnaments = -1

while iIndex < iOrnaments do

iTone init iPTone

if iIndex % 2 != 0 then

if rnd ( 10 ) > 0 then

iOrnament init iPOrnament

else

iOrnament init 0

endif

iPTone += iOrnament

endif

$parameters

iPTone init iTone

SOrnament sprintf {{ i %f %f %f %s }}, p1, iIndex * $p_length, $p_length, SParameters

scoreline_i SOrnament

iIndex += 1

od

endif

..

```
