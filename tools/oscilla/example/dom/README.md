# Dom Sound Design

```scenario oscilla

pitch 0

sweep 30
shift 5

attack 5
decay 3
sustain 3
release 1

```

## Sub Phones

```scenario oscilla

import sine

sine sub

```

### Higher Sub

```scenario xoscilla

--reproduce higher .

distance 1

pitch 20

length (1/2^2)

sweep 0
shift 3

attack 1
decay 1
release 1

```

## Snatch Phone

```scenario xoscilla

~ dom .

import noise

noise snatch .

distance 0

pitch -10

sweep 60
shift 7

attack 5
decay 5
sustain 10
release 10

```

### Higher Snatch Phone

```scenario xoscilla

--reproduce higher .

pitch 10
distance 1

```

#### Higher Snatch Phone

```scenario xoscilla

--reproduce higher .

pitch 10
distance 2

```

## Body Phone

```scenario xoscilla

~ dom .

import fm

fm body .

distance 1

pitch -20

FM -1

sweep 40
shift 6

attack 5
decay 4
sustain 8
release 3

```
