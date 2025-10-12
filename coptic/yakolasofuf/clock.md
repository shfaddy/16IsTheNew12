# Performance Clock

```scenario oscilla

+ t 0 95

```

## Time Signature

### Measure (in Beats)

```scenario oscilla

+ #define measure #2#

+ v $measure

```

### Macro for Setting Time Bar

```scenario oscilla

+ #define bar(time) #b [ $measure * $time ]#

```
