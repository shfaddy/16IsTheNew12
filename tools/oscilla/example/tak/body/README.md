# Body Phone

```scenario oscilla

distance 0

pitch 10

FM 0

sweep 60
shift 10

attack 8
decay 8
sustain 13
release 8

```

## 2nd Body Phone

```scenario oscilla

--reproduce 2nd-body .

step (1/2^8)

pitch 3

```

### 3rd Body Phone

```scenario oscilla

--reproduce 3rd-body .

step (1/2^8)

pitch 6

```
