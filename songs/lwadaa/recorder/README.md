# Recorder Instrument

## Parameters

```scenario oscilla

length = -1

--parameter file --string = recording

```

## Body

```scenario oscilla

--body .

a1 inch 1
a2 inch 2

iTimeStamp date

SFile sprintf "%s.%d.wav", SPFile, iTimeStamp

SSplit sprintf "split.%s", SFile

SMix sprintf "mix.%s", SFile

fout SSplit, -1, a1, a2

fout SMix, -1, a1 + a2

..

```
