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

#define tin #4#

instr $tin, tin

#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3
#define p_loopback #p4#
iPLoopback init p4
#define p_scale #p5#
iPScale init p5
#define p_octave #p6#
iPOctave init p6
#define p_tone #p7#
iPTone init p7
#define p_channel #p8#
SPChannel strget p8
#define p_distance #p9#
iPDistance init p9
#define p_drone #p10#
iPDrone init p10
#define p_ornaments #p11#
iPOrnaments init p11
#define p_method #p12#
iPMethod init p12
#define p_parameter1 #p13#
iPParameter1 init p13
#define p_parameter2 #p14#
iPParameter2 init p14
#define parameters #SParameters sprintf {{%f %f %f %f "%s" %f %f %f %f %f %f}}, iPLoopback, iPScale, iPOctave, iPTone, SPChannel, iPDistance, iPDrone, iPOrnaments, iPMethod, iPParameter1, iPParameter2#

if iPLoopback > 0 then
rewindscore
endif
if $p_drone > 0 then
$parameters
SDrone sprintf {{ i %f %f %f %s }}, p1, $p_length, $p_length, SParameters
scoreline_i SDrone
endif
if $p_ornaments > 0 then
iOrnaments init 2 ^ int ( rnd ( $p_ornaments ) )
$p_length /= iOrnaments
iOrnament init 1
iPOrnaments = -1
iPDrone = -1
while iOrnament < iOrnaments do
$parameters
SOrnament sprintf {{ i %f %f %f %s }}, p1, iOrnament * $p_length, $p_length, SParameters
prints "%s\n", SOrnament
scoreline_i SOrnament
iOrnament += 1
od
endif
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
chnmix aNote / ( iPDistance + 1 + rnd ( .01 ) ), SPChannel

endin

</CsInstruments>

<CsScore>

i [1.1] [0] [-1] "drone" "drone" [1/2] [1] [3/4] [1] [8] [0]
i [1.2] [0] [-1] "melody" "melody" [1/2] [1] [3/4] [1] [0] [4]
i [2] [0] [-1]
t 0 97.5
i [4.1] [0] [1/8] [(note = 3,step = 0,length = 0+0)] [16] [6] [0] "drone" [4] [1] [3] [1] [10] [0]
i [4.1] [0] [1/8] [(note = 3,step = 0,length = 0+0)] [16] [6] [0 + 16] "drone" [4] [1] [3] [1] [10] [0]
i [4.1] [0] [1/8] [(note = 3,step = 0,length = 0+0)] [16] [6] [0 + 16 + 16] "drone" [4] [1] [3] [1] [10] [0]
#define measure #4#
v $measure
a 0 0 [ $measure * 0 ]
i [4.2] 0 [0] [(note = 3,step = 0,length = 0+0)] [16] [8] [0] "melody" [0] [0] [3] [1] [10] [0]
i [4.2] + [1/4] [(note = 3,step = 0,length = 0+0)] [16] [8] [0] "melody" [0] [0] [3] [1] [10] [0]
i [4.2] + [1/4] [(note = 3,step = 0,length = 0+0)] [16] [8] [3] "melody" [0] [0] [3] [1] [10] [0]
i [4.2] + [1/8] [(note = 3,step = 0,length = 0+0)] [16] [8] [4] "melody" [0] [0] [3] [1] [10] [0]
i [4.2] + [1/8] [(note = 3,step = 0,length = 0+0)] [16] [8] [9] "melody" [0] [0] [3] [1] [10] [0]
i [4.2] + [1/8] [(note = 3,step = 0,length = 0+0)] [16] [8] [8] "melody" [0] [0] [3] [1] [10] [0]
i [4.2] + [1/8] [(note = 3,step = 0,length = 0+0)] [16] [8] [9] "melody" [0] [0] [3] [1] [10] [0]
i [4.2] + [1/8] [(note = 3,step = 0,length = 0+0)] [16] [8] [8] "melody" [0] [0] [3] [1] [10] [0]
i [4.2] + [1/8] [(note = 3,step = 0,length = 0+0)] [16] [8] [9] "melody" [0] [0] [3] [1] [10] [0]
i [4.2] + [1/8] [(note = 3,step = 0,length = 0+0)] [16] [8] [4] "melody" [0] [0] [3] [1] [10] [0]
i [4.2] + [1/8] [(note = 3,step = 0,length = 0+0)] [16] [8] [9] "melody" [0] [0] [3] [1] [10] [0]
i [4.2] + [1/8] [(note = 3,step = 0,length = 0+0)] [16] [8] [8] "melody" [0] [0] [3] [1] [10] [0]
i [4.2] + [1/4] [(note = 3,step = 0,length = 0+0)] [16] [8] [9] "melody" [0] [0] [3] [1] [10] [0]
i [4.2] + [1/8] [(note = 3,step = 0,length = 0+0)] [16] [8] [9] "melody" [0] [0] [3] [1] [10] [0]
i [4.2] + [1/8] [(note = 3,step = 0,length = 0+0)] [16] [8] [8] "melody" [0] [0] [3] [1] [10] [0]
i [4.2] + [1/8] [(note = 3,step = 0,length = 0+0)] [16] [8] [4] "melody" [0] [0] [3] [1] [10] [0]
i [4.2] + [1/8] [(note = 3,step = 0,length = 0+0)] [16] [8] [9] "melody" [0] [0] [3] [1] [10] [0]
i [4.2] + [1/8] [(note = 3,step = 0,length = 0+0)] [16] [8] [8] "melody" [0] [0] [3] [1] [10] [0]
i [4.2] + [1/8] [(note = 3,step = 0,length = 0+0)] [16] [8] [4] "melody" [0] [0] [3] [1] [10] [0]
s
i [3] [0] [-1]

</CsScore>

</CsoundSynthesizer>