# Instrument Ornaments

```scenario oscilla

if $p_ornaments > 0 then

iOrnaments init 2 ^ int ( rnd ( $p_ornaments ) )

$p_length /= iOrnaments

iOrnament init 1

$p_ornaments = -1

while iOrnament < iOrnaments do

schedule p1, iOrnament * $p_length, $p_length, $parameters

iOrnament += 1

od

endif

```
