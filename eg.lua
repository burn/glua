-- Testing some general LUA functions.    
-- (c)2022 Tim Menzies <timm@ieee.org> BSD-2 license

local _   = require"glua"
local cli,push,rand,rint,rnd,run = _.cli,_.push,_.rand,_.rint,_.rnd,_.run
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

function eg.sd()
  local u={}; for i=1,100 do push(u,i) end
  print(sd(sort(u))) end

-------------------------------------------------------------------------------
the = cli(the)
os.exit(run(the,eg))
