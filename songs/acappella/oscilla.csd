<CsoundSynthesizer>

<CsOptions>

-o dac

</CsOptions>

<CsInstruments>

sr = 32768
ksmps = 32
nchnls = 2
0dbfs = 1
giKey = 0

#define room #1#

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
#define p_dry #p10#
iPDry init p10
#define p_wet #p11#
iPWet init p11
#define parameters #SParameters sprintf {{"%s" "%s" %f %f %f %f %f %f}}, SPLeft, SPRight, iPRoomMin, iPRoomMax, iPDampMin, iPDampMax, iPDry, iPWet#

aRoomLeft chnget SPLeft
aRoomRight chnget SPRight
denorm aRoomLeft
denorm aRoomRight
kRoom rspline iPRoomMin, iPRoomMax, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )
kDamp rspline iPDampMin, iPDampMax, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )
aReverbLeft, aReverbRight freeverb aRoomLeft, aRoomRight, kRoom, kDamp
iHigh init 2^8
aReverbLeft butterhp aReverbLeft, iHigh
aReverbRight butterhp aReverbRight, iHigh
iLow init 2^12
aReverbLeft butterlp aReverbLeft, iLow
aReverbRight butterlp aReverbRight, iLow
aLeft = ( aRoomLeft / ( iPDry + 1 ) ) + ( aReverbLeft / ( iPWet + 1 ) )
aRight = ( aRoomRight / ( iPDry + 1 ) ) + ( aReverbRight / ( iPWet + 1 ) )
aLeft clip aLeft, 1, 0dbfs
aRight clip aRight, 1, 0dbfs
chnmix aLeft, "left"
chnmix aRight, "right"
chnclear SPLeft
chnclear SPRight

endin

#define mixer #2#

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

#define loopback #3#

instr $loopback, loopback

#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3

rewindscore

endin

#define drone #4#

instr $drone, drone

#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3
#define p_scale #p4#
iPScale init p4
#define p_octave #p5#
iPOctave init p5
#define p_tone #p6#
iPTone init p6
#define p_channel #p7#
SPChannel strget p7
#define p_distance #p8#
iPDistance init p8
#define p_ornaments #p9#
iPOrnaments init p9
#define p_method #p10#
iPMethod init p10
#define p_parameter1 #p11#
iPParameter1 init p11
#define p_parameter2 #p12#
iPParameter2 init p12
#define parameters #SParameters sprintf {{%f %f %f "%s" %f %f %f %f %f}}, iPScale, iPOctave, iPTone, SPChannel, iPDistance, iPOrnaments, iPMethod, iPParameter1, iPParameter2#

if $p_ornaments > 0 then
iOrnaments init 2 ^ int ( rnd ( $p_ornaments ) )
$p_length /= iOrnaments
iOrnament init 1
iPOrnaments = -1
while iOrnament < iOrnaments do
$parameters
SOrnament sprintf {{ i %f %f %f %s }}, p1, iOrnament * $p_length, $p_length, SParameters
prints "%s\n", SOrnament
scoreline_i SOrnament
iOrnament += 1
od
endif
p1 init int ( p1 ) + rnd ( .99999 )
iAttack init 1 / 2^6
iDecay init $p_length / 2^2
iFrequency init 2^( iPOctave + ( ( giKey + iPTone ) / iPScale ) )
kAmplitude linseg 0, iAttack, 1, $p_length - iAttack, 0
kFrequency linsegr iFrequency * 2^(4/16), iAttack / 2^3, iFrequency, iDecay / 2^3, iFrequency * 2^(-4/16)
aNote pluck kAmplitude, kFrequency, iFrequency, 0, iPMethod, iPParameter1, iPParameter2
aNote butterlp aNote, kFrequency * 2^1
aNote butterhp aNote, kFrequency / 2^0
chnmix aNote / ( iPDistance + 1 ), SPChannel

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
#define parameters #SParameters sprintf {{%f "%s" "%s" %f}}, iPSwing, SPLeft, SPRight, iPDistance#

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

i [1.1] [0] [-1] "drone" "drone" [1/2] [1] [3/4] [1] [1] [0]
i [1.2] [0] [-1] "percussion-left" "percussion-right" [1/2] [1] [3/4] [1] [1] [8]
i [2] [0] [-1]
v 4
{ 1024 bar
b [ $bar * 4 ]
i [5] [0] [0] [0] "percussion-left" "percussion-right" [2]
i [5] [1/8] [0] [0] "percussion-left" "percussion-right" [2]
i [5] [4/8] [0] [0] "percussion-left" "percussion-right" [2]
i [5] [5/8] [0] [0] "percussion-left" "percussion-right" [2]
i [5] [7/8] [0] [0] "percussion-left" "percussion-right" [2]
}
t 0 90

</CsScore>

</CsoundSynthesizer>