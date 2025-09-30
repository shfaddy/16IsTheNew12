# Keyboard Instrument

## Parameters

```scenario oscilla

--read from .. tin parameters

scale = 16
octave = 9

```

## Header

```scenario oscilla

massign 0, $keyboard

```

## Body

```scenario oscilla

--body .

kCode sense

if kCode > 0 then

#define code_s #115#
#define code_d #100#
#define code_f #102#

#define code_j #102#
#define code_k #107#

if kCode == $code_s then

$p_tone = $C

elseif kCode == $code_d then

$p_tone = $D

elseif kCode == $code_f then

$p_tone = $E

elseif kCode == $code_j then

$p_tone = $F

elseif kCode == $code_k then

$p_tone = $G

endif

schedulek $tin + .1, 0, 1/4, $parameters

endif

..

```

## Start the Keyboard

```scenario oscilla

length = -1 * 0

```
