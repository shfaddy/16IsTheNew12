# Room Instrument

## Parameters

```scenario oscilla

--parameter left --string
--parameter right --string

--parameter roomMin = 1/2
--parameter roomMax = 1

--parameter dampMin = 3/4
--parameter dampMax = 1

--parameter dry
--parameter wet

```

## Body

```scenario oscilla

--body .

aRoomLeft chnget SPLeft
aRoomRight chnget SPRight

denorm aRoomLeft
denorm aRoomRight

kRoom rspline iPRoomMin, iPRoomMax, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )

kDamp rspline iPDampMin, iPDampMax, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )

aReverbLeft, aReverbRight freeverb aRoomLeft, aRoomRight, kRoom, kDamp

iHigh init 2^8

aReverbLeft butterhp aReverbLeft, iHigh
aReverbRight butterhp aReverbRight, iHigh

iLow init 2^12

aReverbLeft butterlp aReverbLeft, iLow
aReverbRight butterlp aReverbRight, iLow

aLeft = ( aRoomLeft / ( iPDry + 1 ) ) + ( aReverbLeft / ( iPWet + 1 ) )
aRight = ( aRoomRight / ( iPDry + 1 ) ) + ( aReverbRight / ( iPWet + 1 ) )

aLeft clip aLeft, 1, 0dbfs
aRight clip aRight, 1, 0dbfs

chnmix aLeft, "left"
chnmix aRight, "right"

chnclear SPLeft
chnclear SPRight

..

```

## Instruments Placement

```scenario oscilla

--read placement

```
