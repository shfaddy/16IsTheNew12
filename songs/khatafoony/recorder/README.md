# Recorder Instrument

## Parameters

```scenario oscilla

length = -1

--parameter channel = 2
--parameter file --string = recording.wav

```

## Body

```scenario oscilla

--body .

aInput inch iPChannel

fout SPFile, -1, aInput

..

```
