<CsoundSynthesizer>

<CsOptions>

-o dac

</CsOptions>

<CsInstruments>

sr = 24000
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

giStrikeFT ftgen 0, 0, 256, 1, "prerequisites/marmstk1.wav", 0, 0, 0
giVibratoFT ftgen 0, 0, 128, 10, 1

#define dom #4#

instr $dom, dom

#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3
#define p_channel #p4#
iPChannel init p4
#define p_distance #p5#
iPDistance init p5
#define parameters #SParameters sprintf {{%f %f}}, iPChannel, iPDistance#

aNote = 0
iAttack init 1/2^5
iDecay init 1/2^3
iSustain init 1/2^2
iRelease init 1/2
iPLength init iAttack + iDecay + iRelease
aMainSubAmplitude linseg 0, iAttack, 1, iDecay, iSustain, iRelease, 0
aMainSubFrequency linseg 2^8, iAttack, 2^5
aMainSub poscil aMainSubAmplitude, aMainSubFrequency
aNote += aMainSub
aHighSubAmplitude linseg 0, iAttack/8, 1, iDecay/8, iSustain, iRelease/8, 0
aHighSubFrequency linseg 2^10, iAttack/2, 2^7
aHighSub poscil aHighSubAmplitude, aHighSubFrequency
aNote += aHighSub / 8
aGogobell gogobel 1, 2^5, .5, .5, giStrikeFT, 6.0, 0.3, giVibratoFT
aNote += aGogobell / 4
aSnatchAmplitude linseg 0, iAttack/8, 1, iDecay/8, 0
aSnatchFrequency linseg 2^10, iAttack/2, 2^9
aSnatch noise aSnatchAmplitude, 0
aSnatch butterlp aSnatch, aSnatchFrequency
aNote += aSnatch*4
aNote clip aNote, 1, 1

endin

#define tak #5#

instr $tak, tak

#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3
#define p_tone #p4#
iPTone init p4
#define p_channel #p5#
iPChannel init p5
#define p_distance #p6#
iPDistance init p6
#define parameters #SParameters sprintf {{%f %f %f}}, iPTone, iPChannel, iPDistance#

aNote = 0
iAttack init 1/2^7
iDecay init 1/2^6
iSustain init 1/2^4
iRelease init 1/2^6
p3 init iAttack + iDecay + iRelease
iPitch init 2^(iPTone/16)
aMainSubAmplitude linseg 0, iAttack, 1, iDecay, iSustain, iRelease, 0
aMainSubFrequency linseg 2^12, iAttack/2, 2^8
aMainSub poscil aMainSubAmplitude, aMainSubFrequency * iPitch
aNote += aMainSub
aHighSubAmplitude linseg 0, iAttack, 1, iDecay/8, iSustain, iRelease/8, 0
aHighSubFrequency linseg 2^14, iAttack/2, 2^9
aHighSub poscil aHighSubAmplitude, aHighSubFrequency * iPitch
aNote += aHighSub / 4
aGogobell gogobel 1, 2^8 * iPitch, .5, .5, giStrikeFT, 6.0, 0.3, giVibratoFT
aNote += aGogobell / 4
aSnatchAmplitude linseg 0, iAttack/2, 1, iDecay/8, 0
aSnatchFrequency linseg 2^13, iAttack/2, 2^11
aSnatch noise aSnatchAmplitude, 0
aSnatch butterlp aSnatch, aSnatchFrequency * iPitch
aNote += aSnatch
aNote clip aNote, 1, 1

endin

#define sak #6#

instr $sak, sak

#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3
#define p_tone #p4#
iPTone init p4
#define p_channel #p5#
iPChannel init p5
#define p_distance #p6#
iPDistance init p6
#define parameters #SParameters sprintf {{%f %f %f}}, iPTone, iPChannel, iPDistance#

aNote = 0
iAttack init 1/2^10
iDecay init 1/2^9
iSustain init 1/2^5
iRelease init 1/2^9
p3 init iAttack + iDecay + iRelease
iPitch init 2^(iPTone/16)
aMainSubAmplitude linseg 0, iAttack, 1, iDecay, iSustain, iRelease, 0
aMainSubFrequency linseg 2^13, iAttack/2^5, 2^9
aMainSub poscil aMainSubAmplitude, aMainSubFrequency * iPitch
aNote += aMainSub
aHighSubAmplitude linseg 0, iAttack, 1, iDecay/8, iSustain, iRelease/8, 0
aHighSubFrequency linseg 2^15, iAttack/2^5, 2^10
aHighSub poscil aHighSubAmplitude, aHighSubFrequency * iPitch
aNote += aHighSub / 4
aGogobell gogobel 1, 2^9 * iPitch, .5, .5, giStrikeFT, 6.0, 0.3, giVibratoFT
aNote += aGogobell / 4
aSnatchAmplitude linseg 0, iAttack/2, 1, iDecay/8, 0
aSnatchFrequency linseg 2^14, iAttack/2^5, 2^12
aSnatch noise aSnatchAmplitude, 0
aSnatch butterlp aSnatch, aSnatchFrequency * iPitch
aNote += aSnatch
aNote clip aNote, 1, 1

endin

#define sik #7#

instr $sik, sik

#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3
#define p_tone #p4#
iPTone init p4
#define p_channel #p5#
SPChannel strget p5
#define p_distance #p6#
iPDistance init p6
#define parameters #SParameters sprintf {{%f "%s" %f}}, iPTone, SPChannel, iPDistance#

aNote = 0
iAttack init 1/2^10
iDecay init 1/2^10
iSustain init 1/2^5
iRelease init 1/2^9
p3 init iAttack + iDecay + iRelease
iPitch init 2^(iPTone/16)
aMainSubAmplitude linseg 0, iAttack, 1, iDecay, iSustain, iRelease, 0
aMainSubFrequency linseg 2^18, iAttack/2^5, 2^10
aMainSub poscil aMainSubAmplitude, aMainSubFrequency * iPitch
aNote += aMainSub
aHighSubAmplitude linseg 0, iAttack, 1, iDecay/8, iSustain, iRelease/8, 0
aHighSubFrequency linseg 2^19, iAttack/2^5, 2^11
aHighSub poscil aHighSubAmplitude, aHighSubFrequency * iPitch
aNote += aHighSub / 4
aGogobell gogobel 1, 2^10 * iPitch, .5, .5, giStrikeFT, 6.0, 0.3, giVibratoFT
aNote += aGogobell / 2^2
aSnatchAmplitude linseg 0, iAttack/2, 1, iDecay/8, 0
aSnatchFrequency linseg 2^15, iAttack/2^5, 2^13
aSnatch noise aSnatchAmplitude, 0
aSnatch butterlp aSnatch, aSnatchFrequency * iPitch
aNote += aSnatch / 2^2
aNote clip aNote, 1, 1
chnmix aNote / ( iPDistance + 1 ), SPChannel

endin

#define sagat #8#

instr $sagat, sagat

#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3
#define p_tone #p4#
iPTone init p4
#define p_channel #p5#
iPChannel init p5
#define p_distance #p6#
iPDistance init p6
#define parameters #SParameters sprintf {{%f %f %f}}, iPTone, iPChannel, iPDistance#

aNote = 0
iAttack init 1/2^8
iDecay init 1/2^4
iSustain init 1/2^5
iRelease init 1/2^4
iPLength init iAttack + iDecay + iRelease
iPitch init 2^(iPTone/16)
aMainSubAmplitude linseg 0, iAttack, 1, iDecay, iSustain, iRelease, 0
aMainSubFrequency linseg 2^18, iAttack/2, 2^12
aMainSub poscil aMainSubAmplitude, aMainSubFrequency * iPitch
aNote += aMainSub
aHighSubAmplitude linseg 0, iAttack, 1, iDecay/8, iSustain, iRelease/8, 0
aHighSubFrequency linseg 2^19, iAttack/2, 2^13
aHighSub poscil aHighSubAmplitude, aHighSubFrequency * iPitch
aNote += aHighSub / 2
aHighestSubAmplitude linseg 0, iAttack, 1, iDecay/8, iSustain, iRelease/8, 0
aHighestSubFrequency linseg 2^20, iAttack/2, 2^14
aHighestSub poscil aHighestSubAmplitude, aHighestSubFrequency * iPitch
aNote += aHighestSub / 4
aGogobell gogobel 1, 2^13 * iPitch, .5, .5, giStrikeFT, 6.0, 0.3, giVibratoFT
aNote += aGogobell / 4
aSnatchAmplitude linseg 0, iAttack/4, 1, iDecay/8, 0
aSnatchFrequency linseg 2^16, iAttack/2, 2^13
aSnatch noise aSnatchAmplitude, 0
aSnatch butterlp aSnatch, aSnatchFrequency * iPitch
aNote += aSnatch
aTambourine tambourine 1, iPLength / 2^3, 2^4, .5, .5, ( 2^11 ) * iPitch, ( 2^12 ) * iPitch, ( 2^13 ) * iPitch
aNote += aTambourine/2^0
aNote clip aNote, 1, 1

endin

#define tin #9#

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
/*
iAttack init 1 / 2^6
iDecay init $p_length / 2^2
*/
iAttack init 1 / 2^( 6 + rnd ( 1 ) )
iDecay init $p_length / 2^( 1 + rnd ( 1 ) )
iSustain init 1/2^2
iRelease init iDecay + rnd ( 1/2^6 )
iFrequency init 2^( iPOctave + ( ( giKey + iPTone ) / iPScale ) )
; kAmplitude linseg 0, iAttack, 1, $p_length - iAttack, 0
kAmplitude linsegr 0, iAttack, 1, $p_length - iAttack, iSustain, iRelease, 0
iDetune init 2^7
kDetune rspline 2^(-1/iDetune), 2^(1/iDetune), 0, 1 / ( $p_length * 2^2 )
kFrequency linseg iFrequency * 2^( ( 0 + rnd ( -4 ) ) / iDetune ), $p_length, iFrequency
kFrequency *= kDetune
aNote pluck kAmplitude, kFrequency, iFrequency, 0, iPMethod, iPParameter1, iPParameter2
aNote butterlp aNote, kFrequency * 2^2
aNote butterhp aNote, kFrequency / 2^0
chnmix aNote / ( iPDistance + 1 ), SPChannel

endin

#define bow #10#

instr $bow, bow

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
iAttack init p3 / 2^1
iDecay init ( p3 - iAttack ) / 2^4
iSustain init 3/4
iRelease init ( p3 - iAttack - iDecay ) / 2^2
iFrequency init 2^( iPOctave + ( ( giKey + iPTone ) / iPScale ) )
aAmplitude adsr iAttack, iDecay, iSustain, iRelease
kFrequency linsegr iFrequency * 2^(4/16), iAttack / 2^3, iFrequency, iDecay / 2^3, iFrequency * 2^(-4/16)
aNote pluck 1, kFrequency, iFrequency, 0, iPMethod, iPParameter1, iPParameter2
aNote butterlp aNote, kFrequency * 2^1
aNote butterhp aNote, kFrequency / 2^0
aNote *= aAmplitude
chnmix aNote / ( iPDistance + 1 ), SPChannel

endin

</CsInstruments>

<CsScore>

i [2] [0] [-1]
#define do #0#
#define re #3#
#define mi #5#
#define fa #7#
#define sol #10#
#define la #13#
#define si #14#
i [1.1] [0] [-1] "drone" "drone" [1/2] [1] [3/4] [1] [1] [4]
i [1.2] [0] [-1] "chord" "chord" [7/8] [1] [3/4] [1] [0] [8]
i [1.3] [0] [-1] "percussion" "percussion" [7/8] [1] [3/4] [1] [0] [8]
t 0 95
#define measure #2#
v $measure
#define bar(time) #b [ $measure * $time ]#
{ 2 instrument
b 2
{ 4 beat
i [9] [$beat/4] [1/4] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [10] [$beat/4] [1/4] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
}
}
f 0 1
s
r 2
t 0 95
#define measure #2#
v $measure
#define bar(time) #b [ $measure * $time ]#
b 0
a 0 0 0
{ 2 instrument
$bar(0)
i [9] [0] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
$bar(1)
i [9] [0] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/4] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [3/4] [1/4] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
$bar(2)
i [9] [0] [1/2] [16] [7+$instrument] [$la] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
$bar(3)
i [9] [0] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
$bar(4)
i [9] [0] [1/4] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
i [9] [1/4] [1/4] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/4] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
i [9] [3/4] [1/4] [16] [7+$instrument] [$re] "chord" [1] [3] [2] [5] [0]
$bar(5)
i [9] [0] [1/4] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [1/4] [1/4] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/4] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [3/4] [1/4] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
$bar(6)
i [9] [0] [1/2] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
$bar(7)
i [9] [0] [1/4] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
i [9] [1/4] [1/4] [16] [7+$instrument] [$re] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/4] [16] [7+$instrument] [$re] "chord" [1] [3] [2] [5] [0]
i [9] [3/4] [1/4] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
$bar(8)
i [9] [0] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/4] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
i [9] [3/4] [1/4] [16] [7+$instrument] [$re] "chord" [1] [3] [2] [5] [0]
$bar(9)
i [9] [0] [1/2] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
$bar(10)
i [9] [0] [1/2] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/4] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [3/4] [1/4] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
$bar(11)
i [9] [0] [1/4] [16] [7+$instrument] [$re] "chord" [1] [3] [2] [5] [0]
i [9] [1/4] [1/4] [16] [7+$instrument] [$do] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/4] [16] [7+$instrument] [$re] "chord" [1] [3] [2] [5] [0]
i [9] [3/4] [1/4] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
$bar(12)
i [9] [0] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
$bar(13)
i [9] [0] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [4/8] [1/4] [16] [7+$instrument] [$la] "chord" [1] [3] [2] [5] [0]
i [9] [6/8] [1/8] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
i [9] [7/8] [1/8] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
$bar(14)
i [9] [0] [1/2] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
$bar(15)
i [9] [0] [1/4] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
i [9] [1/4] [1/4] [16] [7+$instrument] [$re] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/4] [16] [7+$instrument] [$re] "chord" [1] [3] [2] [5] [0]
i [9] [3/4] [1/4] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
$bar(16)
i [9] [0] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/4] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
i [9] [3/4] [1/4] [16] [7+$instrument] [$re] "chord" [1] [3] [2] [5] [0]
$bar(17)
i [9] [0] [1/2] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
$bar(18)
i [9] [0] [1/2] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
$bar(19)
i [9] [0] [1/2] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
$bar(20)
i [9] [0] [1/4] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
i [9] [1/4] [1/4] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/4] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
i [9] [3/4] [1/4] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
$bar(21)
i [9] [0] [1/4] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
i [9] [1/4] [1/4] [16] [7+$instrument] [$re] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/4] [16] [7+$instrument] [$do] "chord" [1] [3] [2] [5] [0]
i [9] [3/4] [1/4] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
$bar(22)
i [9] [0] [1] [16] [7+$instrument] [$re] "chord" [1] [3] [2] [5] [0]
$bar(23)
i [9] [0] [1] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
$bar(24)
i [9] [0] [1/4] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
i [9] [1/4] [1/4] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/4] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
i [9] [3/4] [1/4] [16] [7+$instrument] [$re] "chord" [1] [3] [2] [5] [0]
$bar(25)
i [9] [0] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
$bar(26)
i [9] [0] [1/4] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [1/4] [1/4] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/4] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
i [9] [3/4] [1/4] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
$bar(27)
i [9] [0] [1/2] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$do] "chord" [1] [3] [2] [5] [0]
$bar(28)
i [9] [0] [1/2] [16] [7+$instrument] [$re] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
$bar(29)
i [9] [0] [1/4] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
i [9] [1/4] [1/4] [16] [7+$instrument] [$re] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/2] [16] [7+$instrument] [$do] "chord" [1] [3] [2] [5] [0]
$bar(30)
i [9] [0] [1/2] [16] [7+$instrument] [$re] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
$bar(31)
i [9] [0] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/4] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
i [9] [3/4] [1/4] [16] [7+$instrument] [$re] "chord" [1] [3] [2] [5] [0]
$bar(32)
i [9] [0] [1/2] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
$bar(33)
i [9] [0] [1/2] [16] [7+$instrument] [$re] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
$bar(34)
i [9] [0] [1/4] [16] [7+$instrument] [$re] "chord" [1] [3] [2] [5] [0]
i [9] [1/4] [1/4] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/2] [16] [7+$instrument] [$re] "chord" [1] [3] [2] [5] [0]
$bar(35)
i [9] [0] [1/2] [16] [7+$instrument] [$si] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$la] "chord" [1] [3] [2] [5] [0]
$bar(36)
i [9] [0] [1/4] [16] [7+$instrument] [$si] "chord" [1] [3] [2] [5] [0]
i [9] [1/4] [1/4] [16] [7+$instrument] [$la] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/4] [16] [7+$instrument] [$si] "chord" [1] [3] [2] [5] [0]
i [9] [3/4] [1/4] [16] [7+$instrument] [17+$do] "chord" [1] [3] [2] [5] [0]
$bar(37)
i [9] [0] [1/2] [16] [7+$instrument] [$la] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/4] [16] [7+$instrument] [$si] "chord" [1] [3] [2] [5] [0]
i [9] [3/4] [1/4] [16] [7+$instrument] [$la] "chord" [1] [3] [2] [5] [0]
$bar(38)
i [9] [0] [1] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
$bar(39)
i [9] [0] [1/2] [16] [7+$instrument] [17+$do] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/4] [16] [7+$instrument] [$si] "chord" [1] [3] [2] [5] [0]
i [9] [3/4] [1/4] [16] [7+$instrument] [$la] "chord" [1] [3] [2] [5] [0]
$bar(40)
i [9] [0] [1/2] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$la] "chord" [1] [3] [2] [5] [0]
$bar(41)
i [9] [0] [1/4] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
i [9] [1/4] [1/4] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/4] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [3/4] [1/4] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
$bar(42)
i [9] [0] [1/2] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
$bar(43)
i [9] [0] [1] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
$bar(44)
i [9] [0] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
$bar(45)
i [9] [0] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
$bar(46)
i [9] [0] [1/4] [16] [7+$instrument] [$la] "chord" [1] [3] [2] [5] [0]
i [9] [1/4] [1/4] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/4] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [3/4] [1/4] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
$bar(47)
i [9] [0] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/4] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [3/4] [1/4] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
$bar(48)
i [9] [0] [1/2] [16] [7+$instrument] [$la] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
$bar(49)
i [9] [0] [1/2] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
$bar(50)
i [9] [0] [1/2] [16] [7+$instrument] [$la] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
$bar(0)
i [10] [0] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
$bar(1)
i [10] [0] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/4] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [3/4] [1/4] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
$bar(2)
i [10] [0] [1/2] [16] [6+$instrument] [$la] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
$bar(3)
i [10] [0] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
$bar(4)
i [10] [0] [1/4] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
i [10] [1/4] [1/4] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/4] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
i [10] [3/4] [1/4] [16] [6+$instrument] [$re] "drone" [0] [3] [2] [2] [0]
$bar(5)
i [10] [0] [1/4] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [1/4] [1/4] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/4] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [3/4] [1/4] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
$bar(6)
i [10] [0] [1/2] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
$bar(7)
i [10] [0] [1/4] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
i [10] [1/4] [1/4] [16] [6+$instrument] [$re] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/4] [16] [6+$instrument] [$re] "drone" [0] [3] [2] [2] [0]
i [10] [3/4] [1/4] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
$bar(8)
i [10] [0] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/4] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
i [10] [3/4] [1/4] [16] [6+$instrument] [$re] "drone" [0] [3] [2] [2] [0]
$bar(9)
i [10] [0] [1/2] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
$bar(10)
i [10] [0] [1/2] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/4] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [3/4] [1/4] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
$bar(11)
i [10] [0] [1/4] [16] [6+$instrument] [$re] "drone" [0] [3] [2] [2] [0]
i [10] [1/4] [1/4] [16] [6+$instrument] [$do] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/4] [16] [6+$instrument] [$re] "drone" [0] [3] [2] [2] [0]
i [10] [3/4] [1/4] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
$bar(12)
i [10] [0] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
$bar(13)
i [10] [0] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [4/8] [1/4] [16] [6+$instrument] [$la] "drone" [0] [3] [2] [2] [0]
i [10] [6/8] [1/8] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
i [10] [7/8] [1/8] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
$bar(14)
i [10] [0] [1/2] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
$bar(15)
i [10] [0] [1/4] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
i [10] [1/4] [1/4] [16] [6+$instrument] [$re] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/4] [16] [6+$instrument] [$re] "drone" [0] [3] [2] [2] [0]
i [10] [3/4] [1/4] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
$bar(16)
i [10] [0] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/4] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
i [10] [3/4] [1/4] [16] [6+$instrument] [$re] "drone" [0] [3] [2] [2] [0]
$bar(17)
i [10] [0] [1/2] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
$bar(18)
i [10] [0] [1/2] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
$bar(19)
i [10] [0] [1/2] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
$bar(20)
i [10] [0] [1/4] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
i [10] [1/4] [1/4] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/4] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
i [10] [3/4] [1/4] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
$bar(21)
i [10] [0] [1/4] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
i [10] [1/4] [1/4] [16] [6+$instrument] [$re] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/4] [16] [6+$instrument] [$do] "drone" [0] [3] [2] [2] [0]
i [10] [3/4] [1/4] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
$bar(22)
i [10] [0] [1] [16] [6+$instrument] [$re] "drone" [0] [3] [2] [2] [0]
$bar(23)
i [10] [0] [1] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
$bar(24)
i [10] [0] [1/4] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
i [10] [1/4] [1/4] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/4] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
i [10] [3/4] [1/4] [16] [6+$instrument] [$re] "drone" [0] [3] [2] [2] [0]
$bar(25)
i [10] [0] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
$bar(26)
i [10] [0] [1/4] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [1/4] [1/4] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/4] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
i [10] [3/4] [1/4] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
$bar(27)
i [10] [0] [1/2] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$do] "drone" [0] [3] [2] [2] [0]
$bar(28)
i [10] [0] [1/2] [16] [6+$instrument] [$re] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
$bar(29)
i [10] [0] [1/4] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
i [10] [1/4] [1/4] [16] [6+$instrument] [$re] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/2] [16] [6+$instrument] [$do] "drone" [0] [3] [2] [2] [0]
$bar(30)
i [10] [0] [1/2] [16] [6+$instrument] [$re] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
$bar(31)
i [10] [0] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/4] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
i [10] [3/4] [1/4] [16] [6+$instrument] [$re] "drone" [0] [3] [2] [2] [0]
$bar(32)
i [10] [0] [1/2] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
$bar(33)
i [10] [0] [1/2] [16] [6+$instrument] [$re] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
$bar(34)
i [10] [0] [1/4] [16] [6+$instrument] [$re] "drone" [0] [3] [2] [2] [0]
i [10] [1/4] [1/4] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/2] [16] [6+$instrument] [$re] "drone" [0] [3] [2] [2] [0]
$bar(35)
i [10] [0] [1/2] [16] [6+$instrument] [$si] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$la] "drone" [0] [3] [2] [2] [0]
$bar(36)
i [10] [0] [1/4] [16] [6+$instrument] [$si] "drone" [0] [3] [2] [2] [0]
i [10] [1/4] [1/4] [16] [6+$instrument] [$la] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/4] [16] [6+$instrument] [$si] "drone" [0] [3] [2] [2] [0]
i [10] [3/4] [1/4] [16] [6+$instrument] [17+$do] "drone" [0] [3] [2] [2] [0]
$bar(37)
i [10] [0] [1/2] [16] [6+$instrument] [$la] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/4] [16] [6+$instrument] [$si] "drone" [0] [3] [2] [2] [0]
i [10] [3/4] [1/4] [16] [6+$instrument] [$la] "drone" [0] [3] [2] [2] [0]
$bar(38)
i [10] [0] [1] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
$bar(39)
i [10] [0] [1/2] [16] [6+$instrument] [17+$do] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/4] [16] [6+$instrument] [$si] "drone" [0] [3] [2] [2] [0]
i [10] [3/4] [1/4] [16] [6+$instrument] [$la] "drone" [0] [3] [2] [2] [0]
$bar(40)
i [10] [0] [1/2] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$la] "drone" [0] [3] [2] [2] [0]
$bar(41)
i [10] [0] [1/4] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
i [10] [1/4] [1/4] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/4] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [3/4] [1/4] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
$bar(42)
i [10] [0] [1/2] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
$bar(43)
i [10] [0] [1] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
$bar(44)
i [10] [0] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$mi] "drone" [0] [3] [2] [2] [0]
$bar(45)
i [10] [0] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
$bar(46)
i [10] [0] [1/4] [16] [6+$instrument] [$la] "drone" [0] [3] [2] [2] [0]
i [10] [1/4] [1/4] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/4] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [3/4] [1/4] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
$bar(47)
i [10] [0] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [2/4] [1/4] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [3/4] [1/4] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
$bar(48)
i [10] [0] [1/2] [16] [6+$instrument] [$la] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
$bar(49)
i [10] [0] [1/2] [16] [6+$instrument] [$fa] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
$bar(50)
i [10] [0] [1/2] [16] [6+$instrument] [$la] "drone" [0] [3] [2] [2] [0]
i [10] [1/2] [1/2] [16] [6+$instrument] [$sol] "drone" [0] [3] [2] [2] [0]
}
s
t 0 95
#define measure #2#
v $measure
#define bar(time) #b [ $measure * $time ]#
{ 2 instrument
$bar(0)
i [9] [0] [1] [16] [7+$instrument] [$sol] "chord" [1] [3] [2] [5] [0]
$bar(1)
i [9] [0] [1/4] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [1/4] [1/4] [16] [7+$instrument] [$fa] "chord" [1] [3] [2] [5] [0]
i [9] [2/4] [1/2] [16] [7+$instrument] [$mi] "chord" [1] [3] [2] [5] [0]
$bar(2)
i [9] [0] [1/2] [16] [7+$instrument] [$re] "chord" [1] [3] [2] [5] [0]
i [9] [1/2] [1/2] [16] [7+$instrument] [-16+$si] "chord" [1] [3] [2] [5] [0]
$bar(3)
i [9] [0] [1/2] [16] [7+$instrument] [$do] "chord" [1] [3] [2] [5] [0]
}
s 14
i [3] [0] [-1]

</CsScore>

</CsoundSynthesizer>