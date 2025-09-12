<CsoundSynthesizer>

<CsOptions>

-o dac

</CsOptions>

<CsInstruments>

sr = 48000
ksmps = 32
nchnls = 2
0dbfs = 1
giStrikeFT ftgen 0, 0, 256, 1, "prerequisites/marmstk1.wav", 0, 0, 0
giVibratoFT ftgen 0, 0, 128, 10, 1

giMeasure init 0
giTempo init 0

#define clock #1#

instr $clock

#define parameters #p4#
#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3
#define p_tempo #p4#
iPTempo init p4

giMeasure init iPLength
giTempo init iPTempo

endin

giKey init 0

#define key #2#

instr $key

#define parameters #p4#
#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3
#define p_pitch #p4#
iPPitch init p4

giKey init iPPitch

endin

gaNote [] init nchnls

#define mixer #3#

instr $mixer

#define parameters #p4#
#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3
#define p_channel #p4#
iPChannel init p4

aNote clip gaNote [ iPChannel ], 1, 0dbfs
outch iPChannel + 1, aNote
gaNote [ iPChannel ] = 0

endin

#define loopback #4#

instr $loopback

#define parameters ##
#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3

rewindscore

endin

gaTin [] init nchnls
instr _tin
aTinLeft = gaTin [ 0 ]
aTinRight = gaTin [ 1 ]
denorm aTinLeft
denorm aTinRight
seed 0
kRoom rspline 1/2, 1, 1 / giMeasure * 2^2, 1 / giMeasure
kDamp rspline 3/4, 1, 1 / giMeasure * 2^1, 1 / giMeasure
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
gaNote [ 0 ] = gaNote [ 0 ] + aLeft
gaNote [ 1 ] = gaNote [ 1 ] + aRight
gaTin [ 0 ] = 0
gaTin [ 1 ] = 0
endin

#define tin #5#

instr $tin

#define parameters #p4, p5, p6, p7, p8#
#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3
#define p_octave #p4#
iPOctave init p4
#define p_tone #p5#
iPTone init p5
#define p_channel #p6#
iPChannel init p6
#define p_distance #p7#
iPDistance init p7
#define p_ornaments #p8#
iPOrnaments init p8

if $p_ornaments > 0 then
seed 0
iRandom random 0, $p_ornaments
iOrnaments init 2 ^ int ( iRandom )
$p_length /= iOrnaments
iOrnament init 1
$p_ornaments = -1
while iOrnament < iOrnaments do
schedule p1, iOrnament * $p_length, $p_length, $parameters
iOrnament += 1
od
$p_ornaments = 0
endif
iAttack init $p_length / 2^13
iDecay init $p_length / 2^13
aAmplitude linseg 0, iAttack, 1, iDecay, 0
iFrequency init 2^( iPOctave + ( ( giKey + iPTone ) / 16 ) )
aFrequency linsegr iFrequency * 2^(16/16), iAttack / 2^1, iFrequency, iDecay / 2, iFrequency * 2^(-4/16)
aClip rspline 0, 1, 0, $p_length
aSkew rspline -1, 1, 0, $p_length
aNote squinewave aFrequency, aClip, aSkew
aNote *= aAmplitude / 2^1
aAmplitude linseg 0, iAttack, 1, $p_length - iAttack, 0
aPluck pluck k ( aAmplitude ), k ( aFrequency ) / 2^0, iFrequency, 0, 1
aNote += aPluck / 2
aNote butterlp aNote, aFrequency * 2^1
aNote butterhp aNote, aFrequency / 2^0
gaTin [ iPChannel ] = gaTin [ iPChannel ] + aNote / 2^iPDistance

endin

#define dom #6#

instr $dom

#define parameters #p4, p5#
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
gaNote [ iPChannel ] = gaNote [ iPChannel ] + aNote / 2^iPDistance

endin

#define tak #7#

instr $tak

#define parameters #p4, p5, p6#
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
gaNote [ iPChannel ] = gaNote [ iPChannel ] + aNote / 2^iPDistance

endin

#define sak #8#

instr $sak

#define parameters #p4, p5, p6#
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

aNote = 0
iAttack init 1/2^8
iDecay init 1/2^8
iSustain init 1/2^5
iRelease init 1/2^8
p3 init iAttack + iDecay + iRelease
iPitch init 2^(iPTone/16)
aMainSubAmplitude linseg 0, iAttack, 1, iDecay, iSustain, iRelease, 0
aMainSubFrequency linseg 2^13, iAttack/2^3, 2^9
aMainSub poscil aMainSubAmplitude, aMainSubFrequency * iPitch
aNote += aMainSub
aHighSubAmplitude linseg 0, iAttack, 1, iDecay/8, iSustain, iRelease/8, 0
aHighSubFrequency linseg 2^15, iAttack/2, 2^10
aHighSub poscil aHighSubAmplitude, aHighSubFrequency * iPitch
aNote += aHighSub / 4
aGogobell gogobel 1, 2^9 * iPitch, .5, .5, giStrikeFT, 6.0, 0.3, giVibratoFT
aNote += aGogobell / 4
aSnatchAmplitude linseg 0, iAttack/2, 1, iDecay/8, 0
aSnatchFrequency linseg 2^14, iAttack/2, 2^12
aSnatch noise aSnatchAmplitude, 0
aSnatch butterlp aSnatch, aSnatchFrequency * iPitch
aNote += aSnatch
aNote clip aNote, 1, 1
gaNote [ iPChannel ] = gaNote [ iPChannel ] + aNote / 2^iPDistance

endin

#define sik #9#

instr $sik

#define parameters #p4, p5, p6#
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
gaNote [ iPChannel ] = gaNote [ iPChannel ] + aNote / 2^iPDistance

endin

#define sagat #10#

instr $sagat

#define parameters #p4, p5, p6#
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
gaNote [ iPChannel ] = gaNote [ iPChannel ] + aNote / 2^iPDistance

endin

</CsInstruments>

<CsScore>

#define tempo #96#
t 0 $tempo
#define measure #4#
v $measure
i [1] [0] [1] [$tempo]
{ 2 channel
i [3 + .$channel] [0] [-1] [$channel]
}
i "_tin" 0 -1
#define tempo #120#
y
v 8
{ 2 channel
b 0
{ 16 note
i [5] [$note/16] [1/16] [8] [$note] [$channel] [0] [1]
}
b 8
{ 16 note
i [5] [$note/16] [1/16] [8] [16-$note] [$channel] [0] [1]
}
}
b 0
a 0 0 16
s 16
t 0 $tempo
v 4
{ 2 channel
{ 4 finger
i [10 + .$channel + .0$finger] [0 + $finger/2^8] [(1/2^3)] [0 + ~ + ( $finger * 4 )] [$channel] [3]
i [10 + .$channel + .0$finger] [1/4 + $finger/2^8] [(1/2^3)] [0 + ~ + ( $finger * 4 )] [$channel] [3]
i [10 + .$channel + .0$finger] [2/4 + $finger/2^8] [(1/2^3)] [0 + ~ + ( $finger * 4 )] [$channel] [3]
i [10 + .$channel + .0$finger] [3/4 + $finger/2^8] [(1/2^3)] [0 + ~ + ( $finger * 4 )] [$channel] [3]
}
}
a 0 0 4
s 4
t 0 $tempo
v 16
{ 2 channel
b 0
i [5] [0] [1/16] [8] [0] [$channel] [0] [4]
i [5] [1/16] [1/16] [8] [3] [$channel] [0] [4]
i [5] [2/16] [1/16] [8] [5] [$channel] [0] [4]
i [5] [3/16] [1/16] [8] [7] [$channel] [0] [4]
i [5] [4/16] [1/16] [8] [10] [$channel] [0] [4]
i [5] [5/16] [1/16] [8] [12] [$channel] [0] [4]
i [5] [6/16] [1/16] [8] [14] [$channel] [0] [4]
i [5] [7/16] [1/16] [8] [16] [$channel] [0] [4]
b 8
i [5] [0/16] [1/16] [8] [16] [$channel] [0] [4]
i [5] [1/16] [1/16] [8] [14] [$channel] [0] [4]
i [5] [2/16] [1/16] [8] [12] [$channel] [0] [4]
i [5] [3/16] [1/16] [8] [10] [$channel] [0] [4]
i [5] [4/16] [1/16] [8] [7] [$channel] [0] [4]
i [5] [5/16] [1/16] [8] [5] [$channel] [0] [4]
i [5] [6/16] [1/16] [8] [3] [$channel] [0] [4]
i [5] [7/16] [1/16] [8] [0] [$channel] [0] [4]
}
s 16
i [4] [0] [-1]

</CsScore>

</CsoundSynthesizer>