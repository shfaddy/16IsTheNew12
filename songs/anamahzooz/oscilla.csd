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
SPChannel strget p4
#define p_distance #p5#
iPDistance init p5
#define parameters #SParameters sprintf {{"%s" %f}}, SPChannel, iPDistance#

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
chnmix aNote / ( iPDistance + 1 ), SPChannel

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
SPChannel strget p5
#define p_distance #p6#
iPDistance init p6
#define parameters #SParameters sprintf {{%f "%s" %f}}, iPTone, SPChannel, iPDistance#

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
chnmix aNote / ( iPDistance + 1 ), SPChannel

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
SPChannel strget p5
#define p_distance #p6#
iPDistance init p6
#define parameters #SParameters sprintf {{%f "%s" %f}}, iPTone, SPChannel, iPDistance#

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
chnmix aNote / ( iPDistance + 1 ), SPChannel

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
SPChannel strget p5
#define p_distance #p6#
iPDistance init p6
#define parameters #SParameters sprintf {{%f "%s" %f}}, iPTone, SPChannel, iPDistance#

aNote = 0
iAttack init 1/2^8
iDecay init 1/2^4
iSustain init 1/2^5
iRelease init 1/2^4
iPLength init iAttack + iDecay + iRelease
p3 init iPLength
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
chnmix aNote / ( iPDistance + 1 ), SPChannel

endin

#define claps #9#

instr $claps, claps

#define p_note #p1#
SPNote strget p1
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

#define tin #10#

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
aFrequency linsegr iFrequency * 2^(32/16), iAttack / 2^0, iFrequency, iDecay / 2^0, iFrequency * 2^(0/16)
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

#define tew #11#

instr $tew, tew

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
iPLength init abs ( $p_length )
iAttack init iPLength / 2^3
iDecay init iAttack / 2^2
iSustain init 1 / 2^1
iRelease init iPLength / 2^3
aAmplitude adsr iAttack, iDecay, iSustain, iRelease
iFrequency init 2^( iPOctave + ( ( giKey + iPTone ) / iPScale ) )
aAmplitude poscil aAmplitude / ( iPDistance + 1 ), iFrequency * 2^0
iAttack /= 2^11
iDecay /= 2^11
aFrequency linseg iFrequency * 2^(16/16), iAttack, iFrequency * 2^(4/16), iDecay, iFrequency * 2^(0/16), iRelease, iFrequency * 2^(-.5/16)
aClip rspline 0, 1, 0, iPLength * 2^2
aSkew rspline -1, 1, 0, iPLength * 2^3
aNote squinewave aFrequency, aClip, aSkew
aNote butterlp aNote, aFrequency * 2^2
aNote *= aAmplitude
chnmix aNote / ( iPDistance + 1 ), SPChannel

endin

</CsInstruments>

<CsScore>

i [2] [0] [-1]
i [1.1] [0] [-1] "drone" "drone" [1/2] [1] [3/4] [1] [4] [0]
i [1.2] [0] [-1] "chord" "chord" [1/2] [1] [3/4] [1] [.1] [1]
i [1.3] [0] [-1] "percussion" "percussion" [1/2] [1] [3/4] [1] [0] [3]
t 0 105
v 8
f 0 1
i 11 [0] [-1] [16] [8] [0] "drone" [6] [1]
i 11 [0] [-1] [16] [8] [0 + 7] "drone" [6] [1]
i 11 [0] [-1] [16] [8] [0 + 7 + 5] "drone" [6] [1]
s 8
t 0 105
v 8
#define thickness #16#
{ $thickness beat
i 10 [$beat/$thickness] [1/$thickness] [16] [7] [0] "chord" [0] [3]
i 10 [$beat/$thickness] [1/$thickness] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [$beat/$thickness] [1/$thickness] [16] [7] [0 + 7 + 5] "chord" [0] [3]
}
s 8
t 0 105
v 4
b 0
i 10 [0] [1/8] [16] [7] [0] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [-3] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [-3 + 7] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [-3 + 7 + 5] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
b 4
i 10 [0] [1/8] [16] [7] [8] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [8 + 7] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [8 + 7 + 5] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [8] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [8 + 7] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [8 + 7 + 5] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [4] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [4 + 7] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [4 + 7 + 5] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
s 8
t 0 105
v 4
b 0
i 10 [0] [1/8] [16] [7] [0] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [-3] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [-3 + 7] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [-3 + 7 + 5] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
b 4
i 10 [0] [1/8] [16] [7] [8] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [8 + 7] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [8 + 7 + 5] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [8] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [8 + 7] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [8 + 7 + 5] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [4] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [4 + 7] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [4 + 7 + 5] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
v 4
{ 2 bar
b [ 4 * $bar ]
{ 3 finger
i [7 + .$finger] [1/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
i [7 + .$finger] [3/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
i [6 + .$finger] [4/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [6 + .$finger] [5/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [7 + .$finger] [7/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
i [7 + .$finger] [9/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
i [6 + .$finger] [10/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [6 + .$finger] [11/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [6 + .$finger] [13/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [6 + .$finger] [14/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [7 + .$finger] [15/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
}
}
s 8
t 0 105
v 4
b 0
i 10 [0] [1/8] [16] [7] [0] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [-3] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [-3 + 7] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [-3 + 7 + 5] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
b 4
i 10 [0] [1/8] [16] [7] [8] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [8 + 7] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [8 + 7 + 5] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [8] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [8 + 7] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [8 + 7 + 5] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [4] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [4 + 7] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [4 + 7 + 5] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
v 4
{ 2 bar
b [ 4 * $bar ]
{ 3 finger
i [7 + .$finger] [1/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
i [7 + .$finger] [3/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
i [6 + .$finger] [4/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [6 + .$finger] [5/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [7 + .$finger] [7/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
i [7 + .$finger] [9/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
i [6 + .$finger] [10/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [6 + .$finger] [11/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [6 + .$finger] [13/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [6 + .$finger] [14/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [7 + .$finger] [15/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
}
}
v 4
{ 2 bar
b [ 4 * $bar ]
{ 3 finger
i [5 + .$finger] [2/16 + $finger/2^9] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [4]
i [5 + .$finger] [6/16 + $finger/2^9] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [4]
i [5 + .$finger] [12/16 + $finger/2^9] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [4]
}
}
s 8
t 0 105
v 4
b 0
i 10 [0] [1/8] [16] [7] [0] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [-3] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [-3 + 7] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [-3 + 7 + 5] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
b 4
i 10 [0] [1/8] [16] [7] [8] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [8 + 7] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [8 + 7 + 5] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [8] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [8 + 7] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [8 + 7 + 5] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [4] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [4 + 7] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [4 + 7 + 5] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
v 4
{ 2 bar
b [ 4 * $bar ]
{ 3 finger
i [7 + .$finger] [1/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
i [7 + .$finger] [3/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
i [6 + .$finger] [4/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [6 + .$finger] [5/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [7 + .$finger] [7/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
i [7 + .$finger] [9/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
i [6 + .$finger] [10/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [6 + .$finger] [11/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [6 + .$finger] [13/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [6 + .$finger] [14/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [7 + .$finger] [15/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
}
}
v 4
{ 2 bar
b [ 4 * $bar ]
{ 3 finger
i [5 + .$finger] [2/16 + $finger/2^9] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [4]
i [5 + .$finger] [6/16 + $finger/2^9] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [4]
i [5 + .$finger] [12/16 + $finger/2^9] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [4]
}
}
v 4
{ 2 bar
b [ 4 * $bar ]
i [4] [0] [1/2] "percussion" [1]
i [4] [1/2] [1/2] "percussion" [1]
}
s 8
t 0 105
v 4
b 0
i 10 [0] [1/8] [16] [7] [0] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [-3] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [-3 + 7] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [-3 + 7 + 5] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
b 4
i 10 [0] [1/8] [16] [7] [8] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [8 + 7] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [8 + 7 + 5] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [8] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [8 + 7] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [8 + 7 + 5] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [4] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [4 + 7] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [4 + 7 + 5] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
v 4
{ 2 bar
b [ 4 * $bar ]
{ 3 finger
i [7 + .$finger] [1/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
i [7 + .$finger] [3/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
i [6 + .$finger] [4/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [6 + .$finger] [5/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [7 + .$finger] [7/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
i [7 + .$finger] [9/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
i [6 + .$finger] [10/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [6 + .$finger] [11/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [6 + .$finger] [13/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [6 + .$finger] [14/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [7 + .$finger] [15/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
}
}
v 4
{ 2 bar
b [ 4 * $bar ]
{ 3 finger
i [5 + .$finger] [2/16 + $finger/2^9] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [4]
i [5 + .$finger] [6/16 + $finger/2^9] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [4]
i [5 + .$finger] [12/16 + $finger/2^9] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [4]
}
}
v 4
{ 2 bar
b [ 4 * $bar ]
i [4] [0] [1/2] "percussion" [1]
i [4] [1/2] [1/2] "percussion" [1]
}
v 4
{ 2 bar
b [ 4 * $bar ]
i 9 [1/8] [0] [0] "percussion" "percussion" [6]
i 9 [3/8] [0] [0] "percussion" "percussion" [6]
i 9 [5/8] [0] [0] "percussion" "percussion" [6]
i 9 [7/8] [0] [0] "percussion" "percussion" [6]
}
s 8
r 4
t 0 105
v 4
b 0
i 10 [0] [1/8] [16] [7] [0] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [-3] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [-3 + 7] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [-3 + 7 + 5] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
b 4
i 10 [0] [1/8] [16] [7] [8] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [8 + 7] "chord" [0] [3]
i 10 [0] [1/8] [16] [7] [8 + 7 + 5] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [8] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [8 + 7] "chord" [0] [3]
i 10 [1/8] [2/8] [16] [7] [8 + 7 + 5] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [4] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [4 + 7] "chord" [0] [3]
i 10 [3/8] [1/8] [16] [7] [4 + 7 + 5] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [4/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7] "chord" [0] [3]
i 10 [6/8] [2/8] [16] [7] [0 + 7 + 5] "chord" [0] [3]
v 4
{ 2 bar
b [ 4 * $bar ]
{ 3 finger
i [7 + .$finger] [1/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
i [7 + .$finger] [3/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
i [6 + .$finger] [4/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [6 + .$finger] [5/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [7 + .$finger] [7/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
i [7 + .$finger] [9/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
i [6 + .$finger] [10/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [6 + .$finger] [11/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [6 + .$finger] [13/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [6 + .$finger] [14/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [5]
i [7 + .$finger] [15/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [32]
}
}
v 4
{ 2 bar
b [ 4 * $bar ]
{ 3 finger
i [5 + .$finger] [2/16 + $finger/2^9] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [4]
i [5 + .$finger] [6/16 + $finger/2^9] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [4]
i [5 + .$finger] [12/16 + $finger/2^9] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] "percussion" [4]
}
}
v 4
{ 2 bar
b [ 4 * $bar ]
i [4] [0] [1/2] "percussion" [1]
i [4] [1/2] [1/2] "percussion" [1]
}
v 4
{ 2 bar
b [ 4 * $bar ]
i 9 [1/8] [0] [0] "percussion" "percussion" [6]
i 9 [3/8] [0] [0] "percussion" "percussion" [6]
i 9 [5/8] [0] [0] "percussion" "percussion" [6]
i 9 [7/8] [0] [0] "percussion" "percussion" [6]
}
v 4
{ 2 bar
b [ 4 * $bar ]
{ 2 finger
i [8 + .$finger] [0 + $finger/2^9] [(1/2^3)] [0 + ~ + ( $finger * 4 )] "percussion" [16]
i [8 + .$finger] [3/8 + $finger/2^9] [(1/2^3)] [0 + ~ + ( $finger * 4 )] "percussion" [16]
i [8 + .$finger] [4/8 + $finger/2^9] [(1/2^3)] [0 + ~ + ( $finger * 4 )] "percussion" [16]
i [8 + .$finger] [6/8 + $finger/2^9] [(1/2^3)] [0 + ~ + ( $finger * 4 )] "percussion" [16]
}
}
s 8
i [3] [0] [-1]

</CsScore>

</CsoundSynthesizer>