# Mixer Instrument

## Body

```scenario oscilla

--body .

aLeft chnget "left"
aRight chnget "right"

aLeft clip aLeft, 1, 0dbfs
aRight clip aRight, 1, 0dbfs

outs aLeft, aRight

chnclear "left"
chnclear "right"

..

```

## Start the Mixer

```scenario oscilla

length = -1 *

```
