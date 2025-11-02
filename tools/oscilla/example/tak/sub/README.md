# Sub Phone

```scenario oscilla

distance 0

pitch 0

sweep 60
shift 23

attack 8
decay 8
sustain 13
release 8

```

## 2nd Sub

```scenario oscilla

--reproduce 2nd-sub .

distance 0

step (1/2^8)

pitch 1

```

### 3rd Sub Phone

```scenario oscilla

--reproduce 3rd-sub .

step (1/2^8)

pitch 4

.. ..

```

## Higher Sub

```scenario oscilla

--reproduce higher-sub .

length (1/2^3)

distance 2

pitch 10

```

### 2nd Higher Sub

```scenario oscilla

--reproduce 2nd-higher-sub .

step (1/2^8)

pitch 2

```

#### 3rd Higher Sub

```scenario oscilla

--reproduce 3rd-higher-sub .

step (1/2^8)

pitch 5

```
