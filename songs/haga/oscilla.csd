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
giStrikeFT ftgen 0, 0, 256, 1, "prerequisites/marmstk1.wav", 0, 0, 0
giVibratoFT ftgen 0, 0, 128, 10, 1
#define scale #16#
#define C #0#
#define D #3#
#define E #4#
#define F #7#
#define G #10#
#define A #11#
#define B #14#

gaNote [] init nchnls

#define mixer #1#

instr $mixer, mixer

#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3
#define p_channel #p4#
iPChannel init p4
#define parameters #SParameters sprintf {{%f}}, iPChannel#

aNote clip gaNote [ iPChannel ], 1, 0dbfs
outch iPChannel + 1, aNote
gaNote [ iPChannel ] = 0

endin

#define loopback #2#

instr $loopback, loopback

#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3

rewindscore

endin

gaPlayer [] init nchnls
instr _player
aPlayerLeft = gaPlayer [ 0 ]
aPlayerRight = gaPlayer [ 1 ]
denorm aPlayerLeft
denorm aPlayerRight
seed 0
kRoom rspline 7/8, 1, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )
kDamp rspline 3/4, 1, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )
aReverbLeft, aReverbRight freeverb aPlayerLeft, aPlayerRight, kRoom, kDamp
iHigh init 2^8
;aReverbLeft butterhp aReverbLeft, iHigh
;aReverbRight butterhp aReverbRight, iHigh
iLow init 2^12
;aReverbLeft butterlp aReverbLeft, iLow
;aReverbRight butterlp aReverbRight, iLow
iReverb init 8
aLeft = aPlayerLeft + aReverbLeft / iReverb
aRight = aPlayerRight + aReverbRight / iReverb
aLeft clip aLeft, 1, 0dbfs
aRight clip aRight, 1, 0dbfs
gaNote [ 0 ] = gaNote [ 0 ] + aLeft
gaNote [ 1 ] = gaNote [ 1 ] + aRight
gaPlayer [ 0 ] = 0
gaPlayer [ 1 ] = 0
endin

#define player #3#

instr $player, player

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
#define p_loop #p6#
iPLoop init p6
#define parameters #SParameters sprintf {{%f %f %f}}, iPChannel, iPDistance, iPLoop#

iMeasure init abs ( p3 )
iSkip init ( iPLoop * iMeasure ) + ( iMeasure / 2.438 )
aNote diskin2 "vocal.wav", 1, iSkip
gaPlayer [ 0 ] = gaPlayer [ 0 ] + aNote / ( iPDistance + 1 )
gaPlayer [ 1 ] = gaPlayer [ 1 ] + aNote / ( iPDistance + 1 )

endin

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
gaNote [ iPChannel ] = gaNote [ iPChannel ] + aNote / ( iPDistance + 1 )

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
gaNote [ iPChannel ] = gaNote [ iPChannel ] + aNote / ( iPDistance + 1 )

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
gaNote [ iPChannel ] = gaNote [ iPChannel ] + aNote / ( iPDistance + 1 )

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
iPChannel init p5
#define p_distance #p6#
iPDistance init p6
#define parameters #SParameters sprintf {{%f %f %f}}, iPTone, iPChannel, iPDistance#

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
gaNote [ iPChannel ] = gaNote [ iPChannel ] + aNote / ( iPDistance + 1 )

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
gaNote [ iPChannel ] = gaNote [ iPChannel ] + aNote / ( iPDistance + 1 )

endin

giTone [] init 12
giTone [ 0 ] init $C
giTone [ 2 ] init $D
giTone [ 4 ] init $E
giTone [ 5 ] init $F
giTone [ 7 ] init $G
giTone [ 9 ] init $A
giTone [ 11 ] init $B
gaTin [] init nchnls
instr _tin
aTinLeft = gaTin [ 0 ]
aTinRight = gaTin [ 1 ]
denorm aTinLeft
denorm aTinRight
seed 0
kRoom rspline 1/2, 1, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )
kDamp rspline 3/4, 1, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )
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
iPChannel init p7
#define p_distance #p8#
iPDistance init p8
#define p_ornaments #p9#
iPOrnaments init p9
#define parameters #SParameters sprintf {{%f %f %f %f %f %f}}, iPScale, iPOctave, iPTone, iPChannel, iPDistance, iPOrnaments#

iKey init 0
iVelocity init 0
midinoteonkey iKey, iVelocity
if iKey > 0 then
$p_length init 1/2^2
iPOctave init 3 + int ( iKey / 12 )
iPTone init giTone [ iKey % 12 ]
iPScale init 16
endif
if $p_ornaments > 0 then
iOrnaments init 2 ^ int ( rnd ( $p_ornaments ) )
$p_length /= iOrnaments
iOrnament init 1
$p_ornaments = -1
while iOrnament < iOrnaments do
schedule p1, iOrnament * $p_length, $p_length, $parameters
iOrnament += 1
od
endif
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
gaTin [ iPChannel ] = gaTin [ iPChannel ] + aNote / ( iPDistance + 1 )

endin

</CsInstruments>

<CsScore>

{ 2 channel
i [1 + .$channel] [0] [-1] [$channel]
}
i "_player" 0 -1
i "_tin" 0 -1
#define scale #16#
#define C #0#
#define D #3#
#define E #4#
#define F #7#
#define G #10#
#define A #11#
#define B #14#
a 0 0 [4-.655]
a 0 40 -1
t 0 64
v 4
#define chorus #9#
{ $chorus voice
i [3 + ($voice/$chorus)] [1] [-1] [$channel] [$chorus/1.25] [1+($voice*9)]
}
{ 2 channel
{ 10 beat
b [ ( 4 * $beat ) + .655 ]
#define octave #8#
i [9 + .$octave] [0] [1/4] [$scale] [$octave] [$C] [$channel] [10000] [1]
i [9 + .$octave] [1/4] [1/4] [$scale] [$octave] [$C] [$channel] [10000] [1]
i [9 + .$octave] [2/4] [1/4] [$scale] [$octave] [$C] [$channel] [10000] [1]
i [9 + .$octave] [3/4] [1/4] [$scale] [$octave] [$C] [$channel] [10000] [1]
i [4 + .$channel] [0] [1/2] [$channel] [0]
i [4 + .$channel] [5/8] [1/2] [$channel] [0]
{ 3 finger
i [5 + .$channel + .0$finger] [1.5/8 + $finger/2^9] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] [$channel] [2]
i [5 + .$channel + .0$finger] [3/8 + $finger/2^9] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] [$channel] [2]
i [5 + .$channel + .0$finger] [6/8 + $finger/2^9] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] [$channel] [2]
i [6 + .$channel + .0$finger] [1/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] [$channel] [3]
i [6 + .$channel + .0$finger] [2/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] [$channel] [3]
i [6 + .$channel + .0$finger] [4/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] [$channel] [3]
i [6 + .$channel + .0$finger] [5/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] [$channel] [3]
i [6 + .$channel + .0$finger] [7/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] [$channel] [3]
i [6 + .$channel + .0$finger] [8/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] [$channel] [3]
i [6 + .$channel + .0$finger] [9/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] [$channel] [3]
i [6 + .$channel + .0$finger] [11/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] [$channel] [3]
i [6 + .$channel + .0$finger] [13/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] [$channel] [3]
i [6 + .$channel + .0$finger] [14/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] [$channel] [3]
i [6 + .$channel + .0$finger] [15/16 + $finger/2^11] [(1/2)] [0 + ( $finger * 4 ) + ( ~ * 2 )] [$channel] [3]
}
}
}
s

</CsScore>

</CsoundSynthesizer>