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

#define strings #3#

instr $strings, strings

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
#define p_method #p9#
iPMethod init p9
#define p_parameter1 #p10#
iPParameter1 init p10
#define p_parameter2 #p11#
iPParameter2 init p11
#define p_loopback #p12#
iPLoopback init p12
#define p_drone #p13#
iPDrone init p13
#define p_ornaments #p14#
iPOrnaments init p14
#define p_ornament #p15#
iPOrnament init p15
#define parameters #SParameters sprintf {{%f %f %f "%s" %f %f %f %f %f %f %f %f}}, iPScale, iPOctave, iPTone, SPChannel, iPDistance, iPMethod, iPParameter1, iPParameter2, iPLoopback, iPDrone, iPOrnaments, iPOrnament#

if iPLoopback > 0 then
rewindscore
endif
if iPDrone > 0 then
$parameters
SDrone sprintf {{ i %f %f %f %s }}, p1, $p_length, $p_length, SParameters
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
iAttack init 1 / 2^( 5 + rnd ( 1 ) )
iDecay init $p_length / 2^( 3 + rnd ( 1 ) )
iSustain init 1/2^2
iRelease init iDecay * 2^0
iFrequency init 2^( iPOctave + ( ( giKey + iPTone ) / iPScale ) )
kAmplitude linsegr 0, iAttack, 1, iDecay, iSustain, iRelease, 0
iDetune init 2^5
kDetune rspline 2^(-1/iDetune), 2^(1/iDetune), 0, 1 / ( $p_length * 2^2 )
kFrequency linsegr iFrequency * 2^( rnd ( 48 ) / iDetune ), $p_length, iFrequency, iRelease, iFrequency * 2^( rnd ( -4 ) / iDetune )
kFrequency *= kDetune
aNote pluck kAmplitude, kFrequency, iFrequency, 0, iPMethod, iPParameter1, iPParameter2
aNote butterlp aNote, kFrequency * 2^3
aNote butterhp aNote, kFrequency / 2^1
chnmix aNote / ( iPDistance + 1 + rnd ( .01 ) ), SPChannel

endin

#define claps #4#

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
i [1.2] [0] [-1] "percussion" "percussion" [1/2] [1] [3/4] [1] [0] [2^16]
i [2] [0] [-1]
#define measure #4#
v $measure
{ 1024 bar
{ 8 hand
b [ ( $bar * $measure ) + ( $hand / 2^8 ) ]
i [3.1] 0 [1/8] [16] [5] [$hand*2] "percussion" [0] [3] [.5] [0] [0] [0] [2] [16]
i [3.1] + [2/8] [16] [5] [32+($hand*2)] "percussion" [0] [3] [.5] [0] [0] [0] [3] [16]
i [3.1] + [1/8] [16] [5] [32+($hand*2)] "percussion" [0] [3] [.5] [0] [0] [0] [3] [16]
i [3.1] + [2/8] [16] [5] [$hand*2] "percussion" [0] [3] [.5] [0] [0] [0] [2] [16]
i [3.1] + [2/8] [16] [5] [32+($hand*2)] "percussion" [0] [3] [.5] [0] [0] [0] [3] [16]
}
}
v $measure
{ 1024 bar
b [ $bar * $measure ]
i [4] [0] [0] [16] "percussion" "percussion" [4]
i [4] [1/8] [0] [16] "percussion" "percussion" [4]
i [4] [3/8] [0] [16] "percussion" "percussion" [4]
i [4] [4/8] [0] [16] "percussion" "percussion" [4]
i [4] [6/8] [0] [16] "percussion" "percussion" [4]
}
t 0 105

</CsScore>

</CsoundSynthesizer>