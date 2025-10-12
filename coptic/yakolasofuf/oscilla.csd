<CsoundSynthesizer>

<CsOptions>

-o dac

</CsOptions>

<CsInstruments>

sr = 48000
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
SPNote strget p1
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
#define parameters #SParameters sprintf {{%f %f %f "%s" %f %f}}, iPScale, iPOctave, iPTone, SPChannel, iPDistance, iPOrnaments#

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
iAttack init $p_length / 2^13
iDecay init $p_length / 2^13
aAmplitude linseg 0, iAttack, 1, iDecay, 0
iFrequency init 2^( iPOctave + ( ( giKey + iPTone ) / iPScale ) )
aFrequency linsegr iFrequency * 2^(32/16), iAttack / 2^0, iFrequency, iDecay / 2^0, iFrequency * 2^(-4/16)
aClip rspline 0, 1, 0, $p_length
aSkew rspline -1, 1, 0, $p_length
aNote squinewave aFrequency, aClip, aSkew
aNote *= aAmplitude / 2^2
aAmplitude linseg 0, iAttack, 1, $p_length - iAttack, 0
aPluck pluck k ( aAmplitude ), k ( aFrequency ) / 2^0, iFrequency, 0, 1
aNote += aPluck / 2
aNote butterlp aNote, aFrequency * 2^1
aNote butterhp aNote, aFrequency / 2^0
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
r 2
i [1.1] [0] [-1] "drone" "drone" [1/2] [1] [3/4] [1] [10] [0]
i [1.2] [0] [-1] "chord" "chord" [7/8] [1] [3/4] [1] [0] [2]
i [1.3] [0] [-1] "percussion" "percussion" [7/8] [1] [3/4] [1] [0] [8]
t 0 95
#define measure #2#
v $measure
#define bar(time) #b [ $measure * $time ]#
{ 4 instrument
b 0
a 0 0 0
$bar(0)
i 9 [0] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
$bar(1)
i 9 [0] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [2/4] [1/4] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [3/4] [1/4] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
$bar(2)
i 9 [0] [1/2] [16] [5+$instrument] [$la] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
$bar(3)
i 9 [0] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
$bar(4)
i 9 [0] [1/4] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
i 9 [1/4] [1/4] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [2/4] [1/4] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
i 9 [3/4] [1/4] [16] [5+$instrument] [$re] "chord" [2] [$instrument]
$bar(5)
i 9 [0] [1/4] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [1/4] [1/4] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
i 9 [2/4] [1/4] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [3/4] [1/4] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
$bar(6)
i 9 [0] [1/2] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
$bar(7)
i 9 [0] [1/4] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
i 9 [1/4] [1/4] [16] [5+$instrument] [$re] "chord" [2] [$instrument]
i 9 [2/4] [1/4] [16] [5+$instrument] [$re] "chord" [2] [$instrument]
i 9 [3/4] [1/4] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
$bar(8)
i 9 [0] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [2/4] [1/4] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
i 9 [3/4] [1/4] [16] [5+$instrument] [$re] "chord" [2] [$instrument]
$bar(9)
i 9 [0] [1/2] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
$bar(10)
i 9 [0] [1/2] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
i 9 [2/4] [1/4] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [3/4] [1/4] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
$bar(11)
i 9 [0] [1/4] [16] [5+$instrument] [$re] "chord" [2] [$instrument]
i 9 [1/4] [1/4] [16] [5+$instrument] [$do] "chord" [2] [$instrument]
i 9 [2/4] [1/4] [16] [5+$instrument] [$re] "chord" [2] [$instrument]
i 9 [3/4] [1/4] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
$bar(12)
i 9 [0] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
$bar(13)
i 9 [0] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [4/8] [1/4] [16] [5+$instrument] [$la] "chord" [2] [$instrument]
i 9 [6/8] [1/8] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
i 9 [7/8] [1/8] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
$bar(14)
i 9 [0] [1/2] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
$bar(15)
i 9 [0] [1/4] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
i 9 [1/4] [1/4] [16] [5+$instrument] [$re] "chord" [2] [$instrument]
i 9 [2/4] [1/4] [16] [5+$instrument] [$re] "chord" [2] [$instrument]
i 9 [3/4] [1/4] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
$bar(16)
i 9 [0] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [2/4] [1/4] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
i 9 [3/4] [1/4] [16] [5+$instrument] [$re] "chord" [2] [$instrument]
$bar(17)
i 9 [0] [1/2] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
$bar(18)
i 9 [0] [1/2] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
$bar(19)
i 9 [0] [1/2] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
$bar(20)
i 9 [0] [1/4] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
i 9 [1/4] [1/4] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [2/4] [1/4] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
i 9 [3/4] [1/4] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
$bar(21)
i 9 [0] [1/4] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
i 9 [1/4] [1/4] [16] [5+$instrument] [$re] "chord" [2] [$instrument]
i 9 [2/4] [1/4] [16] [5+$instrument] [$do] "chord" [2] [$instrument]
i 9 [3/4] [1/4] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
$bar(22)
i 9 [0] [1] [16] [5+$instrument] [$re] "chord" [2] [$instrument]
$bar(23)
i 9 [0] [1] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
$bar(24)
i 9 [0] [1/4] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
i 9 [1/4] [1/4] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [2/4] [1/4] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
i 9 [3/4] [1/4] [16] [5+$instrument] [$re] "chord" [2] [$instrument]
$bar(25)
i 9 [0] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
$bar(26)
i 9 [0] [1/4] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [1/4] [1/4] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
i 9 [2/4] [1/4] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
i 9 [3/4] [1/4] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
$bar(27)
i 9 [0] [1/2] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$do] "chord" [2] [$instrument]
$bar(28)
i 9 [0] [1/2] [16] [5+$instrument] [$re] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
$bar(29)
i 9 [0] [1/4] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
i 9 [1/4] [1/4] [16] [5+$instrument] [$re] "chord" [2] [$instrument]
i 9 [2/4] [1/2] [16] [5+$instrument] [$do] "chord" [2] [$instrument]
$bar(30)
i 9 [0] [1/2] [16] [5+$instrument] [$re] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
$bar(31)
i 9 [0] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [2/4] [1/4] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
i 9 [3/4] [1/4] [16] [5+$instrument] [$re] "chord" [2] [$instrument]
$bar(32)
i 9 [0] [1/2] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
$bar(33)
i 9 [0] [1/2] [16] [5+$instrument] [$re] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
$bar(34)
i 9 [0] [1/4] [16] [5+$instrument] [$re] "chord" [2] [$instrument]
i 9 [1/4] [1/4] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
i 9 [2/4] [1/2] [16] [5+$instrument] [$re] "chord" [2] [$instrument]
$bar(35)
i 9 [0] [1/2] [16] [5+$instrument] [$si] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$la] "chord" [2] [$instrument]
$bar(36)
i 9 [0] [1/4] [16] [5+$instrument] [$si] "chord" [2] [$instrument]
i 9 [1/4] [1/4] [16] [5+$instrument] [$la] "chord" [2] [$instrument]
i 9 [2/4] [1/4] [16] [5+$instrument] [$si] "chord" [2] [$instrument]
i 9 [3/4] [1/4] [16] [5+$instrument] [17+$do] "chord" [2] [$instrument]
$bar(37)
i 9 [0] [1/2] [16] [5+$instrument] [$la] "chord" [2] [$instrument]
i 9 [2/4] [1/4] [16] [5+$instrument] [$si] "chord" [2] [$instrument]
i 9 [3/4] [1/4] [16] [5+$instrument] [$la] "chord" [2] [$instrument]
$bar(38)
i 9 [0] [1] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
$bar(39)
i 9 [0] [1/2] [16] [5+$instrument] [17+$do] "chord" [2] [$instrument]
i 9 [2/4] [1/4] [16] [5+$instrument] [$si] "chord" [2] [$instrument]
i 9 [3/4] [1/4] [16] [5+$instrument] [$la] "chord" [2] [$instrument]
$bar(40)
i 9 [0] [1/2] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$la] "chord" [2] [$instrument]
$bar(41)
i 9 [0] [1/4] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
i 9 [1/4] [1/4] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [2/4] [1/4] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [3/4] [1/4] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
$bar(42)
i 9 [0] [1/2] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
$bar(43)
i 9 [0] [1] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
$bar(44)
i 9 [0] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
$bar(45)
i 9 [0] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
$bar(46)
i 9 [0] [1/4] [16] [5+$instrument] [$la] "chord" [2] [$instrument]
i 9 [1/4] [1/4] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
i 9 [2/4] [1/4] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [3/4] [1/4] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
$bar(47)
i 9 [0] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [2/4] [1/4] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [3/4] [1/4] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
$bar(48)
i 9 [0] [1/2] [16] [5+$instrument] [$la] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
$bar(49)
i 9 [0] [1/2] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
$bar(50)
i 9 [0] [1/2] [16] [5+$instrument] [$la] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
}
s
t 0 95
#define measure #2#
v $measure
#define bar(time) #b [ $measure * $time ]#
{ 4 instrument
$bar(0)
i 9 [0] [1] [16] [5+$instrument] [$sol] "chord" [2] [$instrument]
$bar(1)
i 9 [0] [1/4] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [1/4] [1/4] [16] [5+$instrument] [$fa] "chord" [2] [$instrument]
i 9 [2/4] [1/2] [16] [5+$instrument] [$mi] "chord" [2] [$instrument]
$bar(2)
i 9 [0] [1/2] [16] [5+$instrument] [$re] "chord" [2] [$instrument]
i 9 [1/2] [1/2] [16] [5+$instrument] [-16+$si] "chord" [2] [$instrument]
$bar(3)
i 9 [0] [1] [16] [5+$instrument] [$do] "chord" [2] [$instrument]
}
s
i [3] [0] [-1]

</CsScore>

</CsoundSynthesizer>