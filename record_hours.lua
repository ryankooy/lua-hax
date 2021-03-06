print("Enter \"start\" to begin recording your time.")
local start = io.read()

local function punch(inout, tm)
  return string.format("\n[%s-PUNCH: %d:%d ◦ %d/%d ◦ %s]", 
      inout, tm.hour, tm.min, tm.month, tm.day, os.date("%A"))
end

local function last_line(path)
  FileOpen = io.open(path, "a+")
  local lines = {}
  for line in FileOpen:lines() do
    lines[#lines + 1] = line
  end
  local last_time = lines[#lines]
  if tonumber(last_time) == nil then
    last_time = 0
  end
  return FileOpen, tonumber(last_time)
end

if start == "start" then
  local path = "C:/Users/Ry/Desktop/WorkHours.txt"
  local success, err = pcall(last_line, path)
  if not success then
    File, Latest = last_line("C:/Users/rwkoo/Desktop/workhours.txt")
  else
    File, Latest = last_line(path)
  end
  local now = os.date("*t")
  local firsttime = os.time()
  local inpunch = punch("IN", now)
  print("Do not close this window!\nEnter \"stop\" when you're done . . .")
  io.read()
  local newnow = os.date("*t")
  local secondtime = os.time()
  local outpunch = punch("OUT", newnow)
  local diffstring = string.format("%.2f", os.difftime(secondtime, firsttime) / 3600.00)
  local diff = tonumber(diffstring)
  local newtotal = Latest + diff
  File:write("\n" .. inpunch)
  File:write(outpunch)
  File:write("\n+ " .. diffstring)
  File:write("\nTOTAL HOURS FOR WEEK:\n")
  File:write(newtotal)
  File:close()
else
  print('What?')
end
