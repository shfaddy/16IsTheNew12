<CsoundSynthesizer>

<CsOptions>

-o dac

</CsOptions>

<CsInstruments>

sr = 48000; 32768
ksmps = 64
nchnls = 2
0dbfs = 1
giKey = 0

giMeasure init 0

#define clock #1#

instr $clock, clock

#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3

giMeasure init iPLength
p3 init 0

endin

#define room #2#

instr $room, room

#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3
#define p_left #p4#
SPLeft strget p4
#define p_right #p5#
SPRight strget p5
#define p_roomMin #p6#
iPRoomMin init p6
#define p_roomMax #p7#
iPRoomMax init p7
#define p_dampMin #p8#
iPDampMin init p8
#define p_dampMax #p9#
iPDampMax init p9
#define p_delayMin #p10#
iPDelayMin init p10
#define p_delayMax #p11#
iPDelayMax init p11
#define p_feedbackMin #p12#
iPFeedbackMin init p12
#define p_feedbackMax #p13#
iPFeedbackMax init p13
#define p_dry #p14#
iPDry init p14
#define p_wet #p15#
iPWet init p15
#define p_distance #p16#
iPDistance init p16
#define parameters #SParameters sprintf {{"%s" "%s" %f %f %f %f %f %f %f %f %f %f %f}}, SPLeft, SPRight, iPRoomMin, iPRoomMax, iPDampMin, iPDampMax, iPDelayMin, iPDelayMax, iPFeedbackMin, iPFeedbackMax, iPDry, iPWet, iPDistance#

aRoomLeft chnget SPLeft
aRoomRight chnget SPRight
kRoom rspline iPRoomMin, iPRoomMax, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )
kDamp rspline iPDampMin, iPDampMax, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )
denorm aRoomLeft
denorm aRoomRight
aReverbLeft, aReverbRight reverbsc aRoomLeft, aRoomRight, kRoom, kDamp
aDelay rspline iPDelayMin, iPDelayMax, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )
kFeedback rspline iPFeedbackMin, iPFeedbackMax, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )
aFlangerLeft flanger aRoomLeft, aDelay, kFeedback
aFlangerRight flanger aRoomRight, aDelay, kFeedback
aReverbLeft += aFlangerLeft
aReverbRight += aFlangerRight
aLeft = ( aRoomLeft / ( iPDry + 1 ) ) + ( aReverbLeft / ( iPWet + 1 ) )
aRight = ( aRoomRight / ( iPDry + 1 ) ) + ( aReverbRight / ( iPWet + 1 ) )
iHigh init 2^7
aLeft butterhp aLeft, iHigh
aRight butterhp aRight, iHigh
iLow init 2^14
aLeft butterlp aLeft, iLow
aRight butterlp aRight, iLow
aLeft clip aLeft, 1, 0dbfs
aRight clip aRight, 1, 0dbfs
chnmix aLeft / ( iPDistance + 1 ), "left"
chnmix aRight / ( iPDistance + 1 ), "right"
chnclear SPLeft
chnclear SPRight

endin

#define mixer #3#

instr $mixer, mixer

#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3

aLeft chnget "left"
aRight chnget "right"
aLeft clip aLeft, 1, 0dbfs
aRight clip aRight, 1, 0dbfs
outs aLeft, aRight
chnclear "left"
chnclear "right"

endin

#define strings #4#

instr $strings, strings

#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3
#define p_attack #p4#
iPAttack init p4
#define p_decay #p5#
iPDecay init p5
#define p_sustain #p6#
iPSustain init p6
#define p_release #p7#
iPRelease init p7
#define p_scale #p8#
iPScale init p8
#define p_octave #p9#
iPOctave init p9
#define p_tone #p10#
iPTone init p10
#define p_channel #p11#
SPChannel strget p11
#define p_distance #p12#
iPDistance init p12
#define p_method #p13#
iPMethod init p13
#define p_parameter1 #p14#
iPParameter1 init p14
#define p_parameter2 #p15#
iPParameter2 init p15
#define p_loopback #p16#
iPLoopback init p16
#define p_drone #p17#
iPDrone init p17
#define p_ornaments #p18#
iPOrnaments init p18
#define p_ornament #p19#
iPOrnament init p19
#define parameters #SParameters sprintf {{%f %f %f %f %f %f %f "%s" %f %f %f %f %f %f %f %f}}, iPAttack, iPDecay, iPSustain, iPRelease, iPScale, iPOctave, iPTone, SPChannel, iPDistance, iPMethod, iPParameter1, iPParameter2, iPLoopback, iPDrone, iPOrnaments, iPOrnament#

if iPLoopback != 0 then
rewindscore
endif
if iPDrone > 0 then
iNext init iPDrone * giMeasure
$parameters
iPDrone init -1
SDrone sprintf {{ i %f %f %f %s }}, p1, iNext, $p_length, SParameters
scoreline_i SDrone
endif
if iPOrnaments > 0 then
iOrnaments init 2 ^ int ( rnd ( $p_ornaments ) )
$p_length /= iOrnaments
iIndex init 1
iPOrnaments = -1
while iIndex < iOrnaments do
iTone init iPTone
if iIndex % 2 != 0 then
if rnd ( 10 ) > 0 then
iOrnament init iPOrnament
else
iOrnament init 0
endif
iPTone += iOrnament
endif
$parameters
iPTone init iTone
SOrnament sprintf {{ i %f %f %f %s }}, p1, iIndex * $p_length, $p_length, SParameters
scoreline_i SOrnament
iIndex += 1
od
endif
p1 init int ( p1 ) + rnd ( .99999 )
iAttack init 1 / 2^( iPAttack + rnd ( 1 ) )
iDecay init $p_length / 2^( iPDecay + rnd ( 1 ) )
iSustain init 1/2^iPSustain
iRelease init iDecay * 2^iPRelease
iFrequency init 2^( iPOctave + ( ( giKey + iPTone ) / iPScale ) )
kAmplitude linsegr 0, iAttack, 1, iDecay, iSustain, iRelease, 0
iDetune init 2^7
kDetune rspline 2^(-1/iDetune), 2^(1/iDetune), 0, 1 / ( $p_length * 2^2 )
; kFrequency linsegr iFrequency * 2^( rnd ( 48 ) / iDetune ), $p_length, iFrequency, iRelease, iFrequency * 2^( rnd ( -4 ) / iDetune )
kFrequency linsegr iFrequency * 2^( rnd ( 4 ) / iDetune ), $p_length, iFrequency, iRelease, iFrequency * 2^( rnd ( -4 ) / iDetune )
kFrequency *= kDetune
aNote pluck kAmplitude, kFrequency, iFrequency, 0, iPMethod, iPParameter1, iPParameter2
aNote butterlp aNote, kFrequency * 2^3
aNote butterhp aNote, kFrequency / 2^1
chnmix aNote / ( iPDistance + 1 + rnd ( .01 ) ), SPChannel

endin

#define claps #5#

instr $claps, claps

#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3
#define p_swing #p4#
iPSwing init p4
#define p_left #p5#
SPLeft strget p5
#define p_right #p6#
SPRight strget p6
#define p_distance #p7#
iPDistance init p7
#define p_drone #p8#
iPDrone init p8
#define parameters #SParameters sprintf {{%f "%s" "%s" %f %f}}, iPSwing, SPLeft, SPRight, iPDistance, iPDrone#

if iPDrone > 0 then
iNext init iPDrone * giMeasure
$parameters
iPDrone init -1
SDrone sprintf {{ i %f %f %f %s }}, p1, iNext, $p_length, SParameters
scoreline_i SDrone
endif
if iPSwing <= rnd ( 128 ) then
iClaps random 1, 4
SClaps sprintf "claps/%d.wav", int ( iClaps )
p3 filelen SClaps
aLeft, aRight diskin2 SClaps
chnmix aLeft / ( iPDistance + 1 ), SPLeft
chnmix aRight / ( iPDistance + 1 ), SPRight
endif

endin

</CsInstruments>

<CsScore>

t 0 105
#define measure #4#
v $measure
i [1] [0] [1]
f 0 [ 1024 * $measure ]
i [2.1] [0] [-1] "drone" "drone" [1/2] [1] [14/16] [1] [2^-2] [2^-2] [2^-2] [2^-2] [5] [0] [12]
i [2.2] [0] [-1] "percussion" "percussion" [.1] [.1] [2^5] [2^5] [2^-1] [2^-1] [2^-2] [2^-2] [2^-8] [2^13] [2^-8]
i [2.3] [0] [-1] "melody" "melody" [.9] [.9] [2^16] [2^16] [2^-1] [2^-1] [2^-2] [2^-2] [2^-8] [2^2] [2^-8]
i [3] [0] [-1]
#define drone #1/32#
i [4.1] [0] [$drone] [4] [0] [2] [0] [16] [7] [0] "drone" [0] [2] [3] [0] [0] [$drone] [1] [0]
i [4.1] [0] [$drone] [4] [0] [2] [0] [16] [7] [0 + 9] "drone" [0] [2] [3] [0] [0] [$drone] [1] [0]
i [4.1] [0] [$drone] [4] [0] [2] [0] [16] [7] [0 + 9 + 4] "drone" [0] [2] [3] [0] [0] [$drone] [1] [0]
{ 8 hand
#define dom #0#
#define tak #32#
i [4.2] 0 [1/4] [6] [2] [6] [0] [16] [5] [$dom + ( $hand * 4 )] "percussion" [0] [3] [.5] [0] [0] [1] [2] [16]
i [4.2] + [1/4] [6] [2] [6] [0] [16] [5] [$tak + ( $hand * 4 )] "percussion" [0] [3] [.5] [0] [0] [1] [2] [16]
i [4.2] + [1/4] [6] [2] [6] [0] [16] [5] [$dom + ( $hand * 4 )] "percussion" [0] [3] [.5] [0] [0] [1] [2] [16]
i [4.2] + [1/4] [6] [2] [6] [0] [16] [5] [$tak + ( $hand * 4 )] "percussion" [0] [3] [.5] [0] [0] [1] [2] [16]
}
a 0 0 [ $measure * 0 ]
i [4.3] [10/8] [0] [6] [0] [2] [0] [16] [8] [0] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [0] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [3] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [4] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [4] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/2] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [4] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [4] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [3] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [0] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [3] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [4] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [13] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [12] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [4] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [4] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/2] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [0] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [3] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [0] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [4] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [4] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [4] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [-1] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [0] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [-1] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [0] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [0] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [4] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [4] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [16] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [16] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [13] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [12] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [13] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [12] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [4] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [3] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [0] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [0] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [3] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [4] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [4] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [4] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/8] [6] [0] [2] [0] [16] [8] [8] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [3] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [4] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [16] "melody" [2^0] [2] [3] [0] [0] [0] [4] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [16] "melody" [2^0] [2] [3] [0] [0] [0] [4] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [13] "melody" [2^0] [2] [3] [0] [0] [0] [4] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [13] "melody" [2^0] [2] [3] [0] [0] [0] [4] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [12] "melody" [2^0] [2] [3] [0] [0] [0] [4] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [12] "melody" [2^0] [2] [3] [0] [0] [0] [4] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [4] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [9] "melody" [2^0] [2] [3] [0] [0] [0] [4] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [4] "melody" [2^0] [2] [3] [0] [0] [0] [4] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [3] "melody" [2^0] [2] [3] [0] [0] [0] [4] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [4] "melody" [2^0] [2] [3] [0] [0] [0] [4] [0]
i [4.3] + [1/4] [6] [0] [2] [0] [16] [8] [0] "melody" [2^0] [2] [3] [0] [0] [0] [4] [0]
i [4.3] + [-1] [6] [0] [2] [0] [16] [8] [0] "melody" [2^0] [2] [3] [0] [1] [0] [4] [0]
i [5] [0] [0] [16] "percussion" "percussion" [4] [1]
i [5] [1/2] [0] [16] "percussion" "percussion" [4] [1]

</CsScore>

</CsoundSynthesizer>