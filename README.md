
# GLUA
(pronounced 'glue')
<img src='img/lib.png' width=150 align=right>
#	glua.lua	

Some general LUA functions.    	
(c)2022 Tim Menzies <timm@ieee.org> BSD-2 license	
   	
For examples on how to use this code, see https://tinyurl.com/gluaeg.	
## Linting	

| What | Notes |
|:---|:---|
| <b>l.rogues() &rArr;  nil</b> |  report rogue locals |


## Maths	

| What | Notes |
|:---|:---|
| <b>l.same(x, ...) &rArr;  x</b> |  return `x` unmodified |
| <b>l.sd(ns:`(num)+`, fun:`fun`) &rArr;  num</b> |  return standard deviation |


### Random number generator	
The LUA doco says its random number generator is not stable across platforms.	
Hence, we use our own (using Park-Miller).	

| What | Notes |
|:---|:---|
| <b>l.srand(n:`num`) &rArr;  nil</b> |  reset random number seed (defaults to 937162211)  |
| <b>l.rand(nlo:`num`, nhi:`num`) &rArr;  num</b> |  return float from `nlo`..`nhi` (default 0..1) |
| <b>l.rint(nlo:`num`, nhi:`num`) &rArr;  int</b> |  returns integer from `nlo`..`nhi` (default 0..1) |


## Lists	

| What | Notes |
|:---|:---|
| <b>l.any(t:`tab`) &rArr;  any</b> |  return any item from `t`, picked at random |
| <b>l.many(t:`tab`, n:`num`) &rArr;  t</b> |  return `n` items from `t`, picked at random |
| <b>l.per(t:`tab`, p) &rArr;  num</b> |  return the `p`th(=.5) item of sorted list `t` |
| <b>l.ent(t:`tab`) &rArr;  num</b> |   entropy |
| <b>l.kap(t:`tab`,  fun:`fun`) &rArr;  t</b> |  map function `fun`(k,v) over list (skip nil results)  |
| <b>l.keys(t:`tab`) &rArr;  t</b> |  sort+return `t`'s keys (ignore things with leading `_`) |
| <b>l.map(t:`tab`,  fun:`fun`) &rArr;  t</b> |  map function `fun`(v) over list (skip nil results)  |
| <b>l.push(t:`tab`,  x) &rArr;  any</b> |  push `x` to end of list; return `x`  |
| <b>l.slice(t:`tab`,  go,  stop:`str`,  inc) &rArr;  t</b> |  return `t` from `go`(=1) to `stop`(=#t), by `inc`(=1) |


### Sorting Lists	

| What | Notes |
|:---|:---|
| <b>l.gt(s:`str`) &rArr;  fun</b> |  return a function that sorts ascending on `s'. |
| <b>l.lt(s:`str`) &rArr;  fun</b> |  return a function that sorts descending on `s`. |
| <b>l.sort(t:`tab`,  fun:`fun`) &rArr;  t</b> |  return `t`,  sorted by `fun` (default= `<`) |


## Coercion	
### Strings to Things	

| What | Notes |
|:---|:---|
| <b>l.coerce(s:`str`) &rArr;  any</b> |  return int or float or bool or string from `s` |
| <b>l.options(s:`str`) &rArr;  t</b> |   parse help string to extract a table of options |
| <b>l.csv(sFilename:`str`, fun:`fun`) &rArr;  nil</b> |  call `fun` on rows (after coercing cell text) |


### Things to Strings	

| What | Notes |
|:---|:---|
| <b>l.fmt(sControl:`str`, ...) &rArr;  str</b> |  emulate printf |
| <b>l.oo(t:`tab`) &rArr;  nil</b> |  print `t`'s string (the one generated by `o`) |
| <b>l.o(t:`tab`,   seen:`str`?) &rArr;  str</b> |  table to string (recursive) |


## Objects	

| What | Notes |
|:---|:---|
| <b>l.obj(s:`str`) &rArr;  t</b> |  create a klass and a constructor + print method |


Test suite support	

| What | Notes |
|:---|:---|
| <b>l.cli(t:`tab`) &rArr;  t</b> |  alters contents of options in `t` from the  command-line |
| <b>l.run(t:`tab`, funs:`(fun)+`) &rArr;  nfails</b> |  runs all `funs` (or `t.go`), resetting options & seed before each |


-------------------------------	
That's all folks.	
