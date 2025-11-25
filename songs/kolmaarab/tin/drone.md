# Instrument as a Drone

```scenario oscilla

if $p_drone > 0 then

$parameters

SDrone sprintf {{ i %f %f %f %s }}, p1, $p_length, $p_length, SParameters

scoreline_i SDrone

endif

```
