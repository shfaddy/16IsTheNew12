# Melody of Shikabala to Be Played Using the Tin Instrument

```scenario oscilla

--instance melody

channel = melody

ornaments = 3

octave = 8

distance = 0

```

```scenario oscilla

+ #define measure #4#

+ v $measure

+ a 0 0 [ $measure * 0 ]

+ #define duration #34#

* 0 0 0

step --wrapper none

```

## Section: Ostoora Shatoora Kora Soora

### Shikabala Da Ostoora - Helwa WeShatoora

```scenario xoscilla

+ { 2 time

+ { 2 verse

```

```scenario oscilla

* + -4 1/8
* +

+ { 2 time

+ { 2 verse

* + 3 1/4
* + 3 1/8
* +
* + 6 1/4
* + 9
* + 3 1/8

```

### Response

```scenario oscilla

* + 3 1/8
* + -1
* + 2
* + 3 1/4
* + -4+($verse*10)

```

```scenario oscilla

+ }

```

### Betnataa BelKora

```scenario oscilla

* + 6 1/4
* +
* + 9
* + 10
* + 13 1/8

```

### Response

```scenario oscilla

* + 10 1/8
* + 9
* + 10
* + 13 1/4

```

### WeBtoros FelSoora

```scenario oscilla

* + 13 1/4
* +
* + 10 1/4
* + 9
* + 6

```

### Response

```scenario oscilla

* + 10 1/8
* + 9
* + 6
* + 3
* + 3 1/4

* + 3 1/4

```

```scenario oscilla

+ }

```

## Section: Yallah Shikabala Yallah Hala

### Yallah Yallah Ya Shikabala

```scenario oscilla

+ { 2 time

```

```scenario oscilla

* + 19 1/4
* + 19 1/8
* +
* + 18 1/4
* + 18 1/8
* +
* + 15 1/4
* + 15 1/8
* +
* + 12 1/4
* +

```

### Oros Yallah WeEmel Hala

```scenario oscilla

* + 15 1/4
* + 15 1/8
* +
* + 12+($time*4) 1/4
* + 12+($time*4) 1/8
* +
* + 9+($time*3) 1/4
* + 9+($time*3) 1/8
* +
* + 8+($time*1) 1/4
* + 8

```

```scenario oscilla

+ }

```

## Section: Shaghala Hala

```scenario oscilla

+ { 2 time

```

### Waho Keda Keda Nasak Shaghala

```scenario oscilla

* + 12+($time*1) 1/8
* + 9+($time*3)
* + 8+($time*1)
* + 9
* + 8 1/4
* +
* + 9
* + 12
* + 13 1/8
* + 12
* + 13

```

### WeAfsha FeQadya

```scenario oscilla

* + 12 1/8
* + 13
* + 12
* + 9
* + 8
* + 13
* + 12
* + 13 1/8
* + 12
* + 13
* + 12
* + 13
* + 12
* + 13 1/4

```

### Gybalak LHala

```scenario oscilla

* + 9 1/4
* + 13 1/8
* + 12
* + 9 1/4
* + 8
* +

```

```scenario oscilla

+ }

```
