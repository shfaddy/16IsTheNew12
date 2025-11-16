<CsoundSynthesizer>

<CsOptions>

-o dac

</CsOptions>

<CsInstruments>

sr = 48000
ksmps = 64
nchnls = 2
0dbfs = 1

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
#define p_delayMin #p10#
iPDelayMin init p10
#define p_delayMax #p11#
iPDelayMax init p11
#define p_feedbackMin #p12#
iPFeedbackMin init p12
#define p_feedbackMax #p13#
iPFeedbackMax init p13
#define p_dry #p14#
iPDry init p14
#define p_wet #p15#
iPWet init p15
#define p_distance #p16#
iPDistance init p16
#define parameters #SParameters sprintf {{"%s" "%s" %f %f %f %f %f %f %f %f %f %f %f}}, SPLeft, SPRight, iPRoomMin, iPRoomMax, iPDampMin, iPDampMax, iPDelayMin, iPDelayMax, iPFeedbackMin, iPFeedbackMax, iPDry, iPWet, iPDistance#

aRoomLeft chnget SPLeft
aRoomRight chnget SPRight
kRoom rspline iPRoomMin, iPRoomMax, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )
kDamp rspline iPDampMin, iPDampMax, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )
denorm aRoomLeft
denorm aRoomRight
aReverbLeft, aReverbRight freeverb aRoomLeft, aRoomRight, kRoom, kDamp
aDelay rspline iPDelayMin, iPDelayMax, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )
kFeedback rspline iPFeedbackMin, iPFeedbackMax, 1 / 2^( rnd ( 8 ) ), 1 / 2^( rnd ( 3 ) )
aFlangerLeft flanger aRoomLeft, aDelay, kFeedback
aFlangerRight flanger aRoomRight, aDelay, kFeedback
aReverbLeft += aFlangerLeft
aReverbRight += aFlangerRight
iHigh init 2^9
aReverbLeft butterhp aReverbLeft, iHigh
aReverbRight butterhp aReverbRight, iHigh
iLow init 2^11
aReverbLeft butterlp aReverbLeft, iLow
aReverbRight butterlp aReverbRight, iLow
aLeft = ( aRoomLeft / ( iPDry + 1 ) ) + ( aReverbLeft / ( iPWet + 1 ) )
aRight = ( aRoomRight / ( iPDry + 1 ) ) + ( aReverbRight / ( iPWet + 1 ) )
aLeft clip aLeft, 1, 0dbfs
aRight clip aRight, 1, 0dbfs
chnmix aLeft / ( iPDistance + 1 ), "left"
chnmix aRight / ( iPDistance + 1 ), "right"
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

#define playback #3#

instr $playback, playback

#define p_note #p1#
iPNote init p1
#define p_step #p2#
iPStep init p2
#define p_length #p3#
iPLength init p3
#define p_sample #p4#
iPSample init p4
#define p_input #p5#
iPInput init p5
#define p_skip #p6#
iPSkip init p6
#define p_tone #p7#
iPTone init p7
#define p_gain #p8#
iPGain init p8
#define p_output #p9#
SPOutput strget p9
#define p_distance #p10#
iPDistance init p10
#define parameters #SParameters sprintf {{%f %f %f %f %f "%s" %f}}, iPSample, iPInput, iPSkip, iPTone, iPGain, SPOutput, iPDistance#

SSample sprintf "../recorder/channel%d.%d.wav", iPInput, iPSample
p3 filelen SSample
aSample diskin2 SSample, 1, iPSkip
fSample pvsanal aSample, 1024, 256, 1024, 1
kTone init 2^( iPTone / 16 )
fTone pvscale fSample, kTone, 0, iPGain
aNote pvsynth fTone
chnmix aNote / ( iPDistance + 1 ), SPOutput

endin

</CsInstruments>

<CsScore>

i [1.1] [0] [-1] "vocal" "vocal" [1/2] [1] [1] [1] [2^-1] [2^-1] [2^-2] [2^-2] [2^-8] [2^1] [2^-1]
i [1.2] [0] [-1] "percussion" "percussion" [1/2] [1] [1] [1] [2^-1] [2^-1] [2^-2] [2^-2] [2^-3] [2^4] [0]
i [2] [0] [-1]
i [3] [0] [1] [1763165412] [1] [0] [0] [2] "vocal" [0]
#define detune #1/2^2#
i [3] [0] [1] [1763165412] [1] [0] [$detune] [1.5] "vocal" [0]
i [3] [0] [1] [1763165412] [1] [0] [-$detune] [1.5] "vocal" [0]
i [3] [0] [1] [1763165412] [1] [0] [-16] [1] "vocal" [0]
i [3] [0] [1] [1763165412] [2] [0] [0] [2] "percussion" [2^-8]

</CsScore>

</CsoundSynthesizer>