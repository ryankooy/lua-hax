print("Enter \"start\" to begin recording your time.")
local start = io.read()

local function punch(inout, tm)
  return string.format("\n[%s-PUNCH: %d:%d ◦ %d/%d ◦ %s]", 
      inout, tm.hour, tm.min, tm.month, tm.day, os.date("%A"))
end

local function last_line(f)
  local lines = {}
  for line in f:lines() do
    lines[#lines + 1] = line
  end
  local last_time = lines[#lines]
  if tonumber(last_time) == nil then
    last_time = 0
  end
  return tonumber(last_time)
end

if start == "start" then
  local path = "C:/Users/Ry/Desktop/workhours.txt"
  local success, err = pcall(io.open(path, "a+"))
  if not success then
    File = io.open("C:/Users/rwkoo/Desktop/workhours.txt", "a+")
  else
    File = io.open(path, "a+")
  end
  local latest = last_line(File)
  local now = os.date("*t")
  local firsttime = os.time()
  local inpunch = punch("IN", now)
  File:write("\n" .. inpunch)
  print("Do not close this window!\nEnter \"stop\" when you're done . . .")
  io.read()
  local newnow = os.date("*t")
  local secondtime = os.time()
  local outpunch = punch("OUT", newnow)
  local diffstring = string.format("%.2f", os.difftime(secondtime, firsttime) / 3600.00)
  local diff = tonumber(diffstring)
  local newtotal = latest + diff
  File:write(outpunch)
  File:write("\n+ " .. diffstring)
  File:write("\nTOTAL HOURS FOR WEEK:\n")
  File:write(newtotal)
  File:close()
else
  print('What?')
end
