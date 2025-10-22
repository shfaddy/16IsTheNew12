# Mixer Instrument

## Parameters

```scenario oscilla

--parameter channel = $channel

note --attach + .$channel

```

## Header

```scenario oscilla

--header gaNote [] init nchnls

```

## Body

```scenario oscilla

--body .

aNote clip gaNote [ iPChannel ], 1, 0dbfs

outch iPChannel + 1, aNote

gaNote [ iPChannel ] = 0

..

```

## Start the Mixer

```scenario oscilla

+ { 2 channel

* 0 0 -1

+ }

```
