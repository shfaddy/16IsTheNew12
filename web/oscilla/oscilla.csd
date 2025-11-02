<CsoundSynthesizer>

<CsOptions>

-o dac

</CsOptions>

<CsInstruments>

sr = 32768
ksmps = 32
nchnls = 2
0dbfs = 1
giKey = 6

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
#define measure #4#
v $measure
a 0 0 [ $measure * 0 ]
i [3] [0] [1/8] [16] [6] [0] "drone" [2] [1] [10] [0] [0] [1] [0] [0]
i [3] [0] [1/8] [16] [6] [0 + 16] "drone" [2] [1] [10] [0] [0] [1] [0] [0]
i [3] [0] [1/8] [16] [6] [0 + 16 + 16] "drone" [2] [1] [10] [0] [0] [1] [0] [0]
# define delay #0#
i [3.1] $delay [0] [16] [8] [0] "melody" [0] [1] [10] [0] [0] [0] [1] [0]
#define sample_1 #
$sample_1a
$sample_1b
$sample_1c
#
#define sample_1a #
i [3.1] + [1/8] [16] [8] [0] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [0] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [-1] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [0] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [-1] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [-5] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [-6] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [-5] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [-6] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [-9] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [-10] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [-9] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [-6] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [-5] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [-1] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [0] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
#
#define sample_1b #
i [3.1] + [1/8] [16] [8] [0] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [-1] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [0] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [3] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [0] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [-1] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [0] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [3] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [3] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/4] [16] [8] [3] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
#
#define sample_1c #
i [3.1] + [1/8] [16] [8] [-6] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [-5] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [-1] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [0] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [3] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
#
#define sample_2 #
$sample_2a
$sample_2b
$sample_2c
#
#define sample_2a #
i [3.1] + [1/8] [16] [8] [7] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [7] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [6] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [7] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [6] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [7] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [6] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [10] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [9] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [10] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [9] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [10] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [9] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [4] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [3] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [0] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
#
#define sample_2b #
i [3.1] + [1/8] [16] [8] [4] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [4] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [3] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [0] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [0] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [0] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [-1] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/4] [16] [8] [0] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [0] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
#
#define sample_2c #
i [3.1] + [1/8] [16] [8] [-6] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [-5] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [-6] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [-5] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
i [3.1] + [1/8] [16] [8] [-1] "melody" [0] [1] [10] [0] [0] [0] [1] [1]
i [3.1] + [1/8] [16] [8] [0] "melody" [0] [1] [10] [0] [0] [0] [1] [-1]
#
$sample_2
i [3.1] + [-1] [16] [8] [0] "melody" [0] [1] [10] [0] [1] [0] [1] [-1]
e

</CsScore>

</CsoundSynthesizer>