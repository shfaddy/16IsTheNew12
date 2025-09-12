# Instrument Ornaments

```scenario oscilla

if $p_ornaments > 0 then

seed 0

iRandom random 0, $p_ornaments

iOrnaments init 2 ^ int ( iRandom )

$p_length /= iOrnaments

iOrnament init 1

$p_ornaments = -1

while iOrnament < iOrnaments do

schedule p1, iOrnament * $p_length, $p_length, $parameters

iOrnament += 1

od

$p_ornaments = 0

endif

```
