# Thornless
Safe, moderate-power math expression evaluation.


**Example 1: basic math**
```
2 ^ (log2($m) + x)
```

**Example 2: vectors**
```
sum([1, 2]) + sin([2, 3]) + 4 + min($vector) + dot($vector, $vector)
```

**Example 3: logical operators**
```
$vector > 5 && $vector == $vector
```

**Example 4: `any`, `all`, and `none`**
```
any($vector > 5)
```

**Example 5: `NaN`**
```
if(sum($vector) > 5? 5 : NaN)
```

**Example 6: implicit `NaN`**
```
if(sum($vector) > 5? 5)
```

**Example 7: statistics**
```
percentile($vector, 95)
```

**Example 7: random variable**
```
if (sample_unif(-100, 100) > $mine? 1 : 0)
```

**Example 8: statistical test**
```
$mine = [-55, 22, 144]
$mean = 0
$std = 50
count(sample_norm:100($mean, $std) > $mine))
```


