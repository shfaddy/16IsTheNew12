# Instrument Ornaments

```scenario oscilla

if $p_ornaments > 0 then

iOrnaments init 2 ^ int ( rnd ( $p_ornaments ) )

$p_length /= iOrnaments

iOrnament init 1

iPOrnaments = -1

while iOrnament < iOrnaments do

$parameters

SOrnament sprintf {{ i %f %f %f %s }}, p1, iOrnament * $p_length, $p_length, SParameters
prints "%s\n", SOrnament

scoreline_i SOrnament

iOrnament += 1

od

endif

```
