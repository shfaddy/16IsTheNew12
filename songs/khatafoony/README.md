# Ajam Jense

## Setup

```scenario oscilla

--read setup

```

## 5-Note Version

According to the tuning values found in [MaqamWorld](http://maqamworld.com/en/jins/ajam.php):

* C4 260.74
* D4 293.33
* E4 328; // variable, tuned down from 330
* F4
* 347.65
* G4 391.11

```sh
$ node ../../cents.js 260.74 293.33 328 347.65 391.11
0
203
397
498
701
```

### Playing Ajam Jense Using MaqamWorld's Tuning

```scenario xoscilla

+ --read from ~ maqamworld

--read scale

```

## Tuning in 16-TET

* 0
* 225 (step = 3 semitones x 75 cents = 225 cents )
* 375 (step = 2 semitones x 75 cents = 150 cents )
* 525 (step = 3 semitones x 75 cents = 225 cents )
* 750 (step = 3 semitones x 75 cents = 225 cents )

### Playing Ajam Jense Using Shaikh Faddy's Tuning in 16-TET

```scenario xoscilla

+ --read from ~ shaikhfaddys

--read scale

```

## Example

```scenario xoscilla

+ --read from ~ maqamworld

--read beat

```

```scenario oscilla

+ --read from ~ shaikhfaddys

```

```scenario xoscilla

+ f 0 3600

```

```scenario oscilla

--read beat

```

## Loopback

```scenario xoscilla

loopback length = -1 *

```
