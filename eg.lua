-- Testing some general LUA functions.    
-- (c)2022 Tim Menzies <timm@ieee.org> BSD-2 license

local _   = require"glua"
local cli,ent,many,push = _.cli,_.ent,_.many,_.push
local rand,rint,rnd,run = _.rand,_.rint,_.rnd,_.run
local sd,sort,srand          = _.sd,_.sort,_.srand
local the = _.options[[

 -h  --help  show help       = false
 -s  --seed  random seed     = 937162211
 -g  --go    start-up action = all]]

local eg={}

function eg.the()
  for k,v in pairs(the) do print(k,v) end end

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

function eg.sd()
  local u={}; for i=1,100 do push(u,i) end
  return 29.01 == rnd(sd(sort(u)),2) end

function eg.many()
  local u={}; for i=1,1000 do push(u,i) end
  srand(); local t1 = many(u,100)
  srand(); local t2 = many(u,100) 
  for i,x in pairs(t1) do  if x ~= t2[i] then return false end end  end

-------------------------------------------------------------------------------
the = cli(the)
os.exit(run(the,eg))
