<CsoundSynthesizer>

<CsOptions>

-o dac
-Ma

</CsOptions>

<CsInstruments>

sr = 48000
ksmps = 32
nchnls = 2
0dbfs = 1
giKey = 9
#define scale #16#
#define C #0#
#define D #3#
#define E #6#
#define F #7#
#define G #10#
#define A #13#
#define B #15#

gaNote [] init nchnls

#define mixer #1#

instr $mixer, mixer

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

#define loopback #2#

instr $loopback, loopback

#define parameters ##
#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3

rewindscore

endin

massign 0, "tin"
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

#define tin #3#

instr $tin, tin

#define parameters #p4, p5, p6, p7, p8, p9#
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
i "_tin" 0 -1
#define scale #16#
#define C #0#
#define D #3#
#define E #6#
#define F #7#
#define G #10#
#define A #13#
#define B #15#
a 0 0 0
t 0 150
#define octave #8#
v 4
{ 2 channel
b 0
i [3 + .$octave] [0] [1/8] [$scale] [$octave] [$C] [$channel] [0] [1]
i [3 + .$octave] [.5/4] [1/8] [$scale] [$octave] [$D] [$channel] [0] [1]
i [3 + .$octave] [1/4] [1/4] [$scale] [$octave] [$C] [$channel] [0] [1]
i [3 + .$octave] [2/4] [1/4] [$scale] [$octave] [$E] [$channel] [0] [1]
i [3 + .$octave] [3/4] [1/2] [$scale] [$octave] [$D] [$channel] [0] [1]
b 5
i [3 + .$octave] [0] [1/8] [$scale] [$octave] [$C] [$channel] [0] [1]
i [3 + .$octave] [1/8] [1/8] [$scale] [$octave] [$B-$scale] [$channel] [0] [1]
i [3 + .$octave] [1/4] [1/4] [$scale] [$octave] [$C] [$channel] [0] [1]
i [3 + .$octave] [2/4] [1/2] [$scale] [$octave] [$G-$scale] [$channel] [0] [1]
b 8
i [3 + .$octave] [0] [1/4] [$scale] [$octave] [$G-$scale] [$channel] [0] [1]
i [3 + .$octave] [1/4] [1/4] [$scale] [$octave] [$C] [$channel] [0] [1]
i [3 + .$octave] [2/4] [1/4] [$scale] [$octave] [$D] [$channel] [0] [1]
i [3 + .$octave] [3/4] [1/8] [$scale] [$octave] [$E] [$channel] [0] [1]
i [3 + .$octave] [3.5/4] [1/8] [$scale] [$octave] [$D] [$channel] [0] [1]
b 12
i [3 + .$octave] [0] [1/8] [$scale] [$octave] [$C] [$channel] [0] [1]
i [3 + .$octave] [.5/4] [1/8] [$scale] [$octave] [$D] [$channel] [0] [1]
i [3 + .$octave] [1/4] [1/2] [$scale] [$octave] [$D] [$channel] [0] [1]
b 15
i [3 + .$octave] [0] [1/4] [$scale] [$octave] [$C] [$channel] [0] [1]
i [3 + .$octave] [1/4] [1/8] [$scale] [$octave] [$C] [$channel] [0] [1]
i [3 + .$octave] [1.5/4] [1/8] [$scale] [$octave] [$D] [$channel] [0] [1]
i [3 + .$octave] [2/4] [1/4] [$scale] [$octave] [$E] [$channel] [0] [1]
b 18.5
i [3 + .$octave] [0] [1/8] [$scale] [$octave] [$D] [$channel] [0] [1]
i [3 + .$octave] [.5/4] [1/4] [$scale] [$octave] [$E] [$channel] [0] [1]
b 20.5
i [3 + .$octave] [0] [1/8] [$scale] [$octave] [$C] [$channel] [0] [1]
i [3 + .$octave] [.5/4] [1/4] [$scale] [$octave] [$G] [$channel] [0] [1]
i [3 + .$octave] [1.5/4] [1/4] [$scale] [$octave] [$C] [$channel] [0] [1]
b 23
i [3 + .$octave] [0] [1/8] [$scale] [$octave] [$G] [$channel] [0] [1]
i [3 + .$octave] [.5/4] [1/8] [$scale] [$octave] [$A] [$channel] [0] [1]
i [3 + .$octave] [1/4] [1/4] [$scale] [$octave] [$G] [$channel] [0] [1]
}
s 28
i [2] [0] [-1]

</CsScore>

</CsoundSynthesizer>