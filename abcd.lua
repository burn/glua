local function inc(t,k) t[k] = 1 + (t[k] or 0) end

local function fmt(str,...) --- emulate printf
  return string.format(str,...) end

local function oo(t) --- print nested lists
   print(o(t)) return t end 

local function o(t,   seen,show,u) ---  coerce to string (skip loops, sort slots)
  if type(t) ~=  "table" then return tostring(t) end
  seen=seen or {}
  if seen[t] then return "..." end
  seen[t] = t
  function show(k,v)
    if not tostring(k):find"^_"  then
      v = o(v,seen)
      return #t==0 and fmt(":%s %s",k,v) or o(v,seen) end end
  u={}; for k,v in pairs(t) do u[1+#u] = show(k,v) end
  if #t==0 then table.sort(u) end
  return "{"..table.concat(u," ").."}" end

local function obj(s,    isa,new,t)
  isa=setmetatable
  function new(k,...) local i=isa({},k); return isa(t.new(i,...) or i,k) end
  t={__tostring = function(x) return s..o(x) end}
  t.__index = t;return isa(t,{__call=new}) end

local ABCD = obj"ABCD"

-- ## ABCD    ---- ----- -------------------------------------------------------
function ABCD:new(source,sRx)
  self.source, self.rx = source or "", sRx or ""
  self.yes, self.no = 0,0
  self.known,self.a,self.b,self.c,self.d = {},{},{},{},{} end

function ABCD:add(got,want) --- update results for all classes
  self:exists(want) 
  self:exists(got)  
  if want == got then self.yes=self.yes+1 else self.no=self.no+1 end
  for k,_ in pairs(self.known) do 
    print("|",want,"|",k,"|")
    if   want == k
    then inc(want == got and self.d or self.b, k)
    else inc(got  == k   and self.c or self.a, k) end end end 

function ABCD:exists(x)
  local new = not self.known[x]
  inc(self.known,x)
  if new then
    self.a[x]=self.yes + self.no
    self.b[x]=0; self.c[x]=0; self.d[x]=0 end end

function ABCD:report(    p,out,a,b,c,d,pd,pf,pn,f,acc,g,prec)
  p = function (z) return math.floor(100*z + 0.5) end
  out= {}
  for x,_ in pairs(self.known) do
    pd,pf,pn,prec,g,f,acc = 0,0,0,0,0,0,0
    a= (self.a[x] or 0); b= (self.b[x] or 0); 
    c= (self.c[x] or 0); d= (self.d[x] or 0);
    if b+d > 0     then pd   = d     / (b+d)        end
    if a+c > 0     then pf   = c     / (a+c)        end
    if a+c > 0     then pn   = (b+d) / (a+c)        end
    if c+d > 0     then prec = d     / (c+d)        end
    if 1-pf+pd > 0 then g=2*(1-pf) * pd / (1-pf+pd) end 
    if prec+pd > 0 then f=2*prec*pd / (prec + pd)   end
    if self.yes + self.no > 0 then 
       acc= self.yes /(self.yes + self.no) end
    out[x]={data=self.source,rx=self.rx,num=self.yes+self.no,
            a=a,b=b,c=c,d=d,acc=p(acc),
            prec=p(prec), pd=p(pd), pf=p(pf),f=p(f), g=p(g), class=x} end
  return out end

function ABCD:pretty(t)
  local function slots(t,     u)
    u={}; for k,v in pairs(t) do u[1+#u]=k end; table.sort(u); return u end
  print""
  local s1  = "%10s | %10s | %4s | %4s | %4s | %4s "
  local s2  = "| %3s | %3s| %3s | %4s | %3s | %3s |"
  local d,s = "---", (s1 .. s2)
  print("#"..fmt(s,"db","rx","a","b","c","d","acc","pd","pf","prec","f","g"))
  print("#"..fmt(s,d,d,d,d,d,d,d,d,d,d,d,d))
  for _,x in pairs(slots(t)) do
    local u = t[x]
    print(" "..fmt(s.." %s", u.data,u.rx,u.a, u.b, u.c, u.d,
                        u.acc, u.pd, u.pf, u.prec, u.f, u.g, x)) end end
 

local go={}
function go.abcd(  abcd)
  local abcd= ABCD()
  local y="yes"
  local n="no"
  local m="maybe"
  for i = 1,6 do abcd:add(y,y) end
  for i = 1,2 do abcd:add(n,n) end
  for i = 1,5 do abcd:add(m,m) end
  abcd:add(m,n)
  print(ABCD:pretty( abcd:report() )) end

go.abcd()

-- |	yes	|	yes	|
-- |	yes	|	yes	|
-- |	yes	|	yes	|
-- |	yes	|	yes	|
-- |	yes	|	yes	|
-- |	yes	|	yes	|
-- |	no	|	yes	|
-- |	no	|	no	|
-- |	no	|	yes	|
-- |	no	|	no	|
-- |	maybe	|	yes	|
-- |	maybe	|	maybe	|
-- |	maybe	|	no	|
-- |	maybe	|	yes	|
-- |	maybe	|	maybe	|
-- |	maybe	|	no	|
-- |	maybe	|	yes	|
-- |	maybe	|	maybe	|
-- |	maybe	|	no	|
-- |	maybe	|	yes	|
-- |	maybe	|	maybe	|
-- |	maybe	|	no	|
-- |	maybe	|	yes	|
-- |	maybe	|	maybe	|
-- |	maybe	|	no	|
-- |	no	|	yes	|
-- |	no	|	maybe	|
-- |	no	|	no	|
--
-- #        db |         rx |    a |    b |    c |    d | acc |  pd|  pf | prec |   f |   g |
-- #       --- |        --- |  --- |  --- |  --- |  --- | --- | ---| --- |  --- | --- | --- |
--             |            |    8 |    0 |    1 |    5 |  93 | 100|  11 |   83 |  91 |  94 | maybe
--             |            |   11 |    1 |    0 |    2 |  93 |  67|   0 |  100 |  80 |  80 | no
--             |            |    8 |    0 |    0 |    6 |  93 | 100|   0 |  100 | 100 | 100 | yes
--
--
