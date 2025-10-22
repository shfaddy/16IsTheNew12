<CsoundSynthesizer>

<CsOptions>

-i adc
-o dac

</CsOptions>

<CsInstruments>

sr = 48000
ksmps = 32
nchnls = 2
0dbfs = 1
giKey = 7

#define recorder #1#

instr $recorder, recorder

#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3
#define p_file #p4#
SPFile strget p4
#define parameters #SParameters sprintf {{"%s"}}, SPFile#

a1 inch 1
a2 inch 2
iTimeStamp date
SFile sprintf "%s.%d.wav", SPFile, iTimeStamp
SSplit sprintf "split.%s", SFile
SMix sprintf "mix.%s", SFile
fout SSplit, -1, a1, a2
fout SMix, -1, a1 + a2

endin

</CsInstruments>

<CsScore>

v 8
i [1] [0] [1024] "recording"

</CsScore>

</CsoundSynthesizer>