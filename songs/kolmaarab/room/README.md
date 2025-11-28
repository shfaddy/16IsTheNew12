# Room Instrument

## Parameters

```scenario oscilla

--parameter left --string
--parameter right --string

--parameter roomMin = 1/2
--parameter roomMax = 1

--parameter dampMin = 14/16
--parameter dampMax = 1

--parameter delayMin = 2^-2
--parameter delayMax = 2^-2

--parameter feedbackMin = 2^-2
--parameter feedbackMax = 2^-2

--parameter dry
--parameter wet

--parameter distance

```

## Body

```scenario oscilla

--body .

aRoomLeft chnget SPLeft
aRoomRight chnget SPRight

kRoom rspline iPRoomMin, iPRoomMax, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )

kDamp rspline iPDampMin, iPDampMax, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )

denorm aRoomLeft
denorm aRoomRight

aReverbLeft, aReverbRight reverbsc aRoomLeft, aRoomRight, kRoom, kDamp

aDelay rspline iPDelayMin, iPDelayMax, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )

kFeedback rspline iPFeedbackMin, iPFeedbackMax, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )

aFlangerLeft flanger aRoomLeft, aDelay, kFeedback
aFlangerRight flanger aRoomRight, aDelay, kFeedback

aReverbLeft += aFlangerLeft
aReverbRight += aFlangerRight

aLeft = ( aRoomLeft / ( iPDry + 1 ) ) + ( aReverbLeft / ( iPWet + 1 ) )
aRight = ( aRoomRight / ( iPDry + 1 ) ) + ( aReverbRight / ( iPWet + 1 ) )

iHigh init 2^7

aLeft butterhp aLeft, iHigh
aRight butterhp aRight, iHigh

iLow init 2^14

aLeft butterlp aLeft, iLow
aRight butterlp aRight, iLow

aLeft clip aLeft, 1, 0dbfs
aRight clip aRight, 1, 0dbfs

chnmix aLeft / ( iPDistance + 1 ), "left"
chnmix aRight / ( iPDistance + 1 ), "right"

chnclear SPLeft
chnclear SPRight

..

```

## Instruments Placement

```scenario oscilla

--read placement

```
