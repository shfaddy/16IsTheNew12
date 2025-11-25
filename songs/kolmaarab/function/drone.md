# Instrument Drone Function

## Parameters

```scenario oscilla

--parameter drone

```

## Body

```scenario oscilla

--body .

if iPDrone > 0 then

iNext init iPDrone * giMeasure

$parameters

iPDrone init -1

SDrone sprintf {{ i %f %f %f %s }}, p1, iNext, $p_length, SParameters

scoreline_i SDrone

endif

..

```
