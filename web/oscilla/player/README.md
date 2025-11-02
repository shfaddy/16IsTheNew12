# Player Instrument

## Parameters

```scenario oscilla

--parameter channel = $channel
--parameter distance = .5
--parameter loop

```

## Header

```scenario oscilla

--header .

gaPlayer [] init nchnls

instr _player

aPlayerLeft = gaPlayer [ 0 ]
aPlayerRight = gaPlayer [ 1 ]

denorm aPlayerLeft
denorm aPlayerRight

seed 0

kRoom rspline 7/8, 1, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )
kDamp rspline 3/4, 1, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )

aReverbLeft, aReverbRight freeverb aPlayerLeft, aPlayerRight, kRoom, kDamp

iHigh init 2^8

;aReverbLeft butterhp aReverbLeft, iHigh
;aReverbRight butterhp aReverbRight, iHigh

iLow init 2^12

;aReverbLeft butterlp aReverbLeft, iLow
;aReverbRight butterlp aReverbRight, iLow

iReverb init 8

aLeft = aPlayerLeft + aReverbLeft / iReverb
aRight = aPlayerRight + aReverbRight / iReverb

aLeft clip aLeft, 1, 0dbfs
aRight clip aRight, 1, 0dbfs

gaNote [ 0 ] = gaNote [ 0 ] + aLeft
gaNote [ 1 ] = gaNote [ 1 ] + aRight

gaPlayer [ 0 ] = 0
gaPlayer [ 1 ] = 0

endin

..

+ i "_player" 0 -1

```

## Body

```scenario oscilla

--body .

iMeasure init abs ( p3 )

iSkip init ( iPLoop * iMeasure ) + ( iMeasure / 2.438 )

aNote diskin2 "vocal.wav", 1, iSkip

gaPlayer [ 0 ] = gaPlayer [ 0 ] + aNote / ( iPDistance + 1 )
gaPlayer [ 1 ] = gaPlayer [ 1 ] + aNote / ( iPDistance + 1 )

..

```
