# Instrument Drone Function

## Parameters

```scenario oscilla

--parameter drone

```

## Body

```scenario oscilla

--body .

if iPDrone > 0 then

$parameters

SDrone sprintf {{ i %f %f %f %s }}, p1, $p_length, $p_length, SParameters

scoreline_i SDrone

endif

..

```
