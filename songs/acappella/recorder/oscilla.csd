<CsoundSynthesizer>

<CsOptions>

-i adc

</CsOptions>

<CsInstruments>

sr = 48000
ksmps = 32
nchnls = 2
0dbfs = 1
alwayson "recorder"
instr recorder
a1 inch 1
a2 inch 2
iTimeStamp date
SFile sprintf "%d.wav", iTimeStamp
SChannel1 sprintf "channel1.%s", SFile
SChannel2 sprintf "channel2.%s", SFile
SMix sprintf "mix.%s", SFile
fout SChannel1, -1, a1
fout SChannel2, -1, a2
fout SMix, -1, a1 + a2
endin

</CsInstruments>

</CsoundSynthesizer>