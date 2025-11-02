<CsoundSynthesizer>

<CsOptions>

-o dac

-L stdin

</CsOptions>

<CsInstruments>

sr = 48000
ksmps = 32
nchnls = ( 2 )
0dbfs = 1

gaChannel [] init nchnls

instr 1



endin

instr 2

aChannel clip gaChannel, 1, 0dbfs

out aChannel

gaChannel = 0

endin

instr 3

iPStep init p ( 2 )
iPLength init p ( 3 )
iPSound init p ( 4 )
iPPitch init p ( 5 )
iPDistance init p ( 6 )
iPSweep init p ( 7 )
iPShift init p ( 8 )
iPAttack init p ( 9 )
iPDecay init p ( 10 )
iPSustain init p ( 11 )
iPRelease init p ( 12 )

iAttack init 1 / 2 ^ iPAttack
iDecay init 1 / 2 ^ iPDecay
iSustain init 1 / 2 ^ iPSustain
iRelease init 1 / 2 ^ iPRelease

if p3 < iAttack + iDecay + iRelease then

iAttack *= p3
iDecay *= p3
iRelease *= p3

endif

aAmplitude linseg 0, iAttack, 1, iDecay, iSustain, p3 - iAttack - iDecay - iRelease, iSustain, iRelease, 0

iFrequency init 2 ^ ( 4 + ( iPPitch / 16 ) )
iSweep init 2 ^ ( iPSweep / 16 )
iShift init 1 / 2 ^ iPShift

aFrequency linseg iFrequency * iSweep, iShift, iFrequency

aNote poscil aAmplitude, aFrequency

aNote clip aNote, 1, 0dbfs

gaSound [ iPSound ] = gaSound [ iPSound ] + aNote / 2 ^ iPDistance

endin

instr loopback

rewindscore

endin

instr exit

exitnow

endin

</CsInstruments>

<CsScore>

i "mixer" 0 -1

t 0 [ ( 120 ) ]

#define measure #( 4 )#

v [ $measure ]

; dom at step ( ( 0 ) + ( 0 ) ) for length ( ( (1/$measure) ) * ( ( 1 ) / $ornaments ) ) with pitch ( ( 0 ) + ( 0 ) ) and distance ( ( 0 ) + ( 0 ) )

#define notes #1#

{ 1 chord

#define ornaments #1#

{ $ornaments ornament

; dom/sub
i [ 3.1 + ( $chord / ( 10 ^ ( 1 + 1 + 5 ) ) ) ] [ ( ( ( 0 ) + ( 0 ) ) + ( 0 ) ) ] [ ( ( ( (1/$measure) ) * ( ( 1 ) / $ornaments ) ) * ( 1 ) ) ] [ ( ( 1 ) + ( undefined ) ) ] [ ( ( ( 0 ) + ( 0 ) ) + ( 0 ) ) ] [ ( ( ( 0 ) + ( 0 ) ) + ( 0 ) ) ] [ ( ( 48 ) + ( 0 ) ) ] [ ( ( 5 ) + ( 0 ) ) ] [ ( ( 5 ) + ( 0 ) ) ] [ ( ( 3 ) + ( 0 ) ) ] [ ( ( 3 ) + ( 0 ) ) ] [ ( ( 1 ) + ( 0 ) ) ]

}

}

; dom at step ( ( 0 ) + ( 4/8 ) ) for length ( ( (1/$measure) ) * ( ( 1 ) / $ornaments ) ) with pitch ( ( 0 ) + ( 0 ) ) and distance ( ( 0 ) + ( 0 ) )

#define notes #1#

{ 1 chord

#define ornaments #1#

{ $ornaments ornament

; dom/sub
i [ 3.1 + ( $chord / ( 10 ^ ( 1 + 1 + 5 ) ) ) ] [ ( ( ( 0 ) + ( 4/8 ) ) + ( 0 ) ) ] [ ( ( ( (1/$measure) ) * ( ( 1 ) / $ornaments ) ) * ( 1 ) ) ] [ ( ( 1 ) + ( undefined ) ) ] [ ( ( ( 0 ) + ( 0 ) ) + ( 0 ) ) ] [ ( ( ( 0 ) + ( 0 ) ) + ( 0 ) ) ] [ ( ( 48 ) + ( 0 ) ) ] [ ( ( 5 ) + ( 0 ) ) ] [ ( ( 5 ) + ( 0 ) ) ] [ ( ( 3 ) + ( 0 ) ) ] [ ( ( 3 ) + ( 0 ) ) ] [ ( ( 1 ) + ( 0 ) ) ]

}

}

i "loopback" [ 1 + ( 0 ) ] 1

</CsScore>

</CsoundSynthesizer>