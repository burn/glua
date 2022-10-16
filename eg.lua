-- Testing some general LUA functions.    
-- (c)2022 Tim Menzies <timm@ieee.org> BSD-2 license

local _   = require"glua"
local cli,ent,kap,keys,lt,many,map   = _.cli,_.ent,_.kap,_.keys,_.lt,_.many,_.map
local oo,pers,push       = _.oo,_.pers,_.push
local rand,rint,rnd,run  = _.rand,_.rint,_.rnd,_.run
local slice,sd,sort,srand      = _.slice,_.sd,_.sort,_.srand
local the = _.options[[

 -h  --help  show help       = false
 -s  --seed  random seed     = 937162211
 -g  --go    start-up action = all]]

local eg={}

function eg.the()
  local n=0; for k,v in pairs(the) do n=n+1 end 
  return the.help==false and the.seed and the.go and the._help and n==4 end

function eg.rnd()
  return rnd(10.1234, 2) == 10.12 end

function eg.rand()
  local u={};for i=1,5 do u[1+#u] = rnd(rand()) end
  srand();   for i=1,5 do assert(u[i]== rnd(rand())) end end

function eg.rint()
  local u={}; for i=1,5 do u[1+#u] = rint(100) end
  srand();    for i=1,5 do assert(u[i] == rint(100)) end end

function eg.ent()
  local u={a=4,b=2,c=1}
  return 1.38 == rnd(ent(u),2) end

function eg.per() -- per works if sd works
  return eg.sd() end

function eg.sd()
  local u={}; for i=1,100 do push(u,i) end
  return 29.01 == rnd(sd(sort(u)),2) end

function eg.many()
  local u={}; for i=1,1000 do push(u,i) end
  srand(); local t1 = many(u,100)
  srand(); local t2 = many(u,100) 
  for i,x in pairs(t1) do  if x ~= t2[i] then return false end end  end

function eg.pers()
  local u={}; for i=1,100 do push(u,i) end
  return 75==pers(u,{.25,.5,.75})[3] end

function eg.map()
  local t=map({10,20,30,40},function(v) if v>20 then return v end end)
  oo(t)
  return #t==2 and t[1]==30 and t[2]==40 end

function eg.kap()
  local t=kap({a=1,b=2,c=3,d=4},function(k,v) if v>2 then return v end end)
  oo(t)
  return t.a==nil and t.b==nil and t.c==3 and t.d==4 end

function eg.kap()
  local t=keys({d=1,c=2,a=3,b=4})
  return #t==4 and t[4]== "d" end

function eg.push()
  local t={}; for i=20,29 do push(t,i) end
  return #t==10 and t[10]==29 end

function eg.slice()
  local t={}; for i=20,29 do push(t,i) end
  local u=slice(t,2,10,3) 
  oo(u)
  return u[#u]==27 end

function eg.lt()
  local u={}; for k,_ in pairs(_ENV) do push(u, {name=k, n=#k}) end
  u= sort(u,lt"n")
  return u[#u].name=="collectgarbage"
end

-------------------------------------------------------------------------------
the = cli(the)
os.exit(run(the,eg))
