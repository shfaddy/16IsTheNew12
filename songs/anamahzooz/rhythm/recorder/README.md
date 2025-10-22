# Recorder Instrument

## Parameters

```scenario oscilla

length = -1

--parameter input = 2

--parameter output --string

--parameter file --string = recording.wav

```

## Body

```scenario oscilla

--body .

aInput inch iPInput

;fout SPFile, -1, aInput

chnmix aInput, SPOutput

..

```
