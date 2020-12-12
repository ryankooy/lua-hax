local path = "C:/Users/rwkoo/Desktop/workhours.txt"
print("Enter \"start\" to begin recording your time.")
local start = io.read()

local function punch(inout, tm)
  return string.format("\n[%s-PUNCH: %d:%d // %d/%d // %s]", 
      inout, tm.hour, tm.min, tm.month, tm.day, os.date("%A"))
end

if start == "start" then
  local file = io.open(path, "a+")
  local lines = {}
  for line in file:lines() do
    lines[#lines + 1] = line
  end
  local latest = tonumber(lines[#lines])
  local now = os.date("*t")
  local firsttime = os.time()
  local inpunch = punch("IN", now)
  file:write(inpunch)
  print("Do not close this window!\nEnter \"stop\" when you're done . . .")
  io.read()
  local newnow = os.date("*t")
  local secondtime = os.time()
  local outpunch = punch("OUT", newnow)
  local diff = tonumber(string.format("%.2f", os.difftime(secondtime, firsttime) / 3600.00))
  local newtotal = latest + diff
  file:write(outpunch)
  file:write("\nTOTAL HOURS FOR WEEK:\n")
  file:write(newtotal)
  file:close()
else
  print('What?')
end
