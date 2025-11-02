<CsoundSynthesizer>

<CsOptions>

-o dac

</CsOptions>

<CsInstruments>

sr = 48000
ksmps = 32
nchnls = 2
0dbfs = 1
giKey = 9

gaTin [] init nchnls
instr _tin
aTinLeft = gaTin [ 0 ]
aTinRight = gaTin [ 1 ]
denorm aTinLeft
denorm aTinRight
seed 0
kRoom rspline 1/2, 1, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )
kDamp rspline 3/4, 1, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )
aReverbLeft, aReverbRight freeverb aTinLeft, aTinRight, kRoom, kDamp
iHigh init 2^8
aReverbLeft butterhp aReverbLeft, iHigh
aReverbRight butterhp aReverbRight, iHigh
iLow init 2^12
aReverbLeft butterlp aReverbLeft, iLow
aReverbRight butterlp aReverbRight, iLow
iReverb init 2
aLeft = aTinLeft + aReverbLeft / iReverb
aRight = aTinRight + aReverbRight / iReverb
aLeft clip aLeft, 1, 0dbfs
aRight clip aRight, 1, 0dbfs
outs aLeft, aRight
gaTin [ 0 ] = 0
gaTin [ 1 ] = 0
endin

#define tin #1#

instr $tin, tin

#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3
#define p_channel #p4#
iPChannel init p4
#define p_scale #p5#
iPScale init p5
#define p_octave #p6#
iPOctave init p6
#define p_tone #p7#
iPTone init p7
#define p_method #p8#
iPMethod init p8
#define p_parameter1 #p9#
iPParameter1 init p9
#define p_parameter2 #p10#
iPParameter2 init p10
#define parameters #SParameters sprintf {{%f %f %f %f %f %f %f}}, iPChannel, iPScale, iPOctave, iPTone, iPMethod, iPParameter1, iPParameter2#

p1 init int ( p1 ) + rnd ( .99999 )
iAttack init 1 / 2^( 6 + rnd ( 1 ) )
iDecay init $p_length / 2^( 0 + rnd ( 1 ) )
iSustain init 1/2^2
iRelease init iDecay * 2^0
iFrequency init 2^( iPOctave + ( ( giKey + iPTone ) / iPScale ) )
kAmplitude linsegr 0, iAttack, 1, iDecay, iSustain, iRelease, 0
iDetune init 2^7
kDetune rspline 2^(-1/iDetune), 2^(1/iDetune), 0, 1 / ( $p_length * 2^2 )
kFrequency linsegr iFrequency * 2^( rnd ( 4 ) / iDetune ), $p_length, iFrequency, iRelease, iFrequency * 2^( rnd ( -4 ) / iDetune )
kFrequency *= kDetune
aNote pluck kAmplitude, kFrequency, iFrequency, 0, iPMethod, iPParameter1, iPParameter2
aNote butterlp aNote, kFrequency * 2^.75
aNote butterhp aNote, kFrequency / 2^.75
gaTin [ iPChannel ] = gaTin [ iPChannel ] + aNote

endin

gkTone [] init 128
iKey init 0
while iKey < 128 do
gkTone [ iKey ] init -1
iKey += 1
od
gkTone [ 122 ] init 0
gkTone [ 120 ] init 1
gkTone [ 99 ] init 2
gkTone [ 118 ] init 3
gkTone [ 97 ] init 4
gkTone [ 115 ] init 5
gkTone [ 100 ] init 6
gkTone [ 102 ] init 7
gkTone [ 113 ] init 8
gkTone [ 119 ] init 9
gkTone [ 101 ] init 10
gkTone [ 114 ] init 11
gkTone [ 49 ] init 12
gkTone [ 50 ] init 13
gkTone [ 51 ] init 14
gkTone [ 52 ] init 15
gkTone [ 109 ] init 16
gkTone [ 44 ] init 17
gkTone [ 46 ] init 18
gkTone [ 47 ] init 19
gkTone [ 106 ] init 20
gkTone [ 107 ] init 21
gkTone [ 108 ] init 22
gkTone [ 59 ] init 23
gkTone [ 117 ] init 24
gkTone [ 105 ] init 25
gkTone [ 111 ] init 26
gkTone [ 112 ] init 27
gkTone [ 55 ] init 28
gkTone [ 56 ] init 29
gkTone [ 57 ] init 30
gkTone [ 48 ] init 31

#define sequencer #2#

instr $sequencer, sequencer

#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3
#define p_channel #p4#
iPChannel init p4
#define p_scale #p5#
iPScale init p5
#define p_octave #p6#
iPOctave init p6
#define p_tone #p7#
iPTone init p7
#define p_method #p8#
iPMethod init p8
#define p_parameter1 #p9#
iPParameter1 init p9
#define p_parameter2 #p10#
iPParameter2 init p10
#define parameters #SParameters sprintf {{%f %f %f %f %f %f %f}}, iPChannel, iPScale, iPOctave, iPTone, iPMethod, iPParameter1, iPParameter2#

kKey init 0
kCode sense
if kCode > 0 then
if kCode == 61 then
kKey += 1
kTone = 0
elseif kCode == 45 then
kTone = 0
kKey -= 1
else
kTone = gkTone [ kCode ]
endif
if kTone >= 0 then
schedulek $tin + .1 + ( kCode/10000 ), 0, 1/4, 0, iPScale, iPOctave, kTone + kKey, iPMethod, iPParameter1, iPParameter2
schedulek $tin + .2 + kCode/10000, 0, 1/4, 0, iPScale, iPOctave, kTone + kKey, iPMethod, iPParameter1, iPParameter2
endif
endif

endin

</CsInstruments>

<CsScore>

i "_tin" 0 -1
i [2] [0] [2^13] [0] [16] [8] [0] [1] [10] [0]

</CsScore>

</CsoundSynthesizer>