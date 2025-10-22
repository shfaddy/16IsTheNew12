<CsoundSynthesizer>

<CsOptions>

-o dac

</CsOptions>

<CsInstruments>

sr = 32768
ksmps = 32
nchnls = 2
0dbfs = 1
giKey = 8

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

giStrikeFT ftgen 0, 0, 256, 1, "prerequisites/marmstk1.wav", 0, 0, 0

#define tin #4#

instr $tin, tin

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
i [4.1] [0] [0] [16] [8] [0] "melody" [0] [3] [1] [10] [0]
{ 2 time
i [4.1] + [1/8] [16] [8] [0] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [0] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-1] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [0] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-1] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-5] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-6] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-5] "melody" [0] [3] [1] [10] [0]
#define bar #1#
i [4.1] + [1/8] [16] [8] [-6] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-9] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-10] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-9] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-6] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-5] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-1] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [0] "melody" [0] [3] [1] [10] [0]
#define bar #2#
i [4.1] + [1/8] [16] [8] [0] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-1] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [0] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [3] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [0] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-1] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [0] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/4] [16] [8] [3] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/4] [16] [8] [3] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-6] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-5] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-1] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [0] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [3] "melody" [0] [3] [1] [10] [0]
#define bar #4#
}
{ 2 time
i [4.1] + [1/8] [16] [8] [7] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [7] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [6] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/4] [16] [8] [7] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [7] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [6] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [10] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [10] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [10] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [9] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [4+($time*6)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [3+($time*6)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [4] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [3] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [0] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [4] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [4] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [3] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/4] [16] [8] [0] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/4] [16] [8] [-1+$time] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [0+(7*$time)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [0+(7*$time)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [0+(7*$time)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-6+($time*16)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-5+($time*9)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-6+($time*9)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-5+($time*9)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-1+($time*4)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/(8/($time+1))] [16] [8] [0] "melody" [0] [3] [1] [10] [0]
}
{ 2 time
i [4.1] + [1/4] [16] [8] [-6] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/4] [16] [8] [-5] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/4] [16] [8] [-1] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/4] [16] [8] [0] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [0] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-6+($time*9)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-5+($time*5)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-6+($time*5)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-5+($time*5)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-1+($time*4)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/4] [16] [8] [$time*4] "melody" [0] [3] [1] [10] [0]
}
{ 2 time
i [4.1] + [1/8] [16] [8] [3] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [4] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/4] [16] [8] [7] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [4+($time*3)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [3+($time*4)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/4] [16] [8] [4+($time*4)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [$time*7] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-1+($time*5)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/4] [16] [8] [$time*7] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-5+($time*9)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/8] [16] [8] [-1+($time*4)] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/4] [16] [8] [$time*-5] "melody" [0] [3] [1] [10] [0]
}
i [4.1] + [1/4] [16] [8] [-1] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/4] [16] [8] [0] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/4] [16] [8] [3] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/4] [16] [8] [4] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/4] [16] [8] [8] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/4] [16] [8] [10] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/4] [16] [8] [10] "melody" [0] [3] [1] [10] [0]
i [4.1] + [1/4] [16] [8] [10] "melody" [0] [3] [1] [10] [0]
s
i [3] [0] [-1]

</CsScore>

</CsoundSynthesizer>