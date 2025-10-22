# Claps Instrument

## Parameters

```scenario oscilla

--parameter swing
--parameter left --string
--parameter right --string
--parameter distance

```

## Body

```scenario oscilla

--body .

if iPSwing <= rnd ( 128 ) then

iClaps random 1, 4

SClaps sprintf "claps/%d.wav", int ( iClaps )

p3 filelen SClaps

aLeft, aRight diskin2 SClaps

chnmix aLeft / ( iPDistance + 1 ), SPLeft
chnmix aRight / ( iPDistance + 1 ), SPRight

endif

..

```

## Start Clapping

```scenario oscilla

--read nota

```
