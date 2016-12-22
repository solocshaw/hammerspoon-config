hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Y", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  f.y = f.y - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "K", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "U", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + 10
  f.y = f.y - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "L", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "B", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x - 10
  f.y = f.y + 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "J", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.y = f.y + 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "N", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()

  f.x = f.x + 10
  f.y = f.y + 10
  win:setFrame(f)
end)

--Maximize the current window
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "F", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w
  f.h = max.h
  win:setFrame(f)
end)

-- Snap window to the left of the screen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Left", function()
  local win =  hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Snap window to the right of the screen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

-- Snap window to the top half of the screen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Up", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y - (max.w / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

-- Snap window to the bottom half of the screen
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Down", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w
  f.h = max.h / 2
  win:setFrame(f)
end)

-- Snap window to the upper-left corner of the screen
--[[
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "Z", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w / 2
  f.h = max.h / 2
end)
--]]

-- Snap a window to the upper-right corner of the screen
-- Placeholder --

--Multi-window layout
local laptopScreen = "Color LCD"
local windowLayout = {
  {"Safari", nil, laptopScreen, hs.layout.left50, nil, nil},
  {"Atom", nil, laptopScreen, hs.layout.right50, nil, nil},
  {"iTunes", "iTunes", laptopScreen, hs.layout.maximized, nil, nil},
  {"iTunes", "MiniPlayer", laptopScreen, nil, nil, hs.geometry.rect(0, -48, 400, 48)},
}
hs.layout.apply(windowLayout)

-- Terminal layout
-- Placeholder --

--Cycling through Safari User Agents
function cycle_safari_agents()
  hs.application.launchOrFocus("Safari")
  local safari = hs. appfinder.appFromName("Safari")

  local str_default = {"Develop", "User Agent", "Default (Automatically Chosen)"}
  local str_ie10 = {"Develop", "User Agent", "Internet Explorer 10.0"}
  local str_chrome = {"Develop", "User Agent", "Google Chrome - Windows"}

  local default = safari:findMenuItem(str_default)
  local ie10 = safari:findMenuItem(str_ie10)
  local chrome = safari.findMenuItem(str_chrome)

  if (default and default["ticked"]) then
    safari:selectedMenuItem(str_ie10)
    hs.alert.show("IE10")
  end
  if (ie10 and ie10["ticked"]) then
    safari:selectedMenuItem(str_chrome)
    hs.alert.show("Chrome")
  end
  if (chrome and chrome["ticked"]) then
    safari:selectedMenuItem(str_default)
    hs.alert.show("Safari")
  end
end
hs.hotkey.bind({"cmd", "alt", "ctrl"}, '7', cycle_safari_agents)

-- Bring all Finder windows to the front
function applicationWatcher(appName, eventType, appObject)
  if (eventType == hs.application.watcher.activated) then
    if (appName == "Finder") then
      --Bring all windows forward when on gets activated
      appObject:selectMenuItem({"Window", "Bring All to Front"})
    end
  end
end
local appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

-- Adjust volume accordingly when connected to either public or home WiFi
--[[
local wifiWatcher = nil
local homeSSID = ""
local lastSSID = hs.wifi.currentNetwork()

function ssidChangedCallback()
  newSSID = hs.wifi.currentNetwork()
  if newSSID == homeSSID and lastSSID ~= homeSSID then
    -- We just joined our home WiFi network
    hs.audiodevice.defaultOutputDevice():setVolume(25)
  elseif newSSID ~= homeSSID and lastSSID == homeSSID then
    -- We just departed our home WiFi network
  end

  lastSSID = newSSID
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()
--]]

-- Routing around sites that prevent password copypasta
hs.hotkey.bind({"cmd", "alt"}, "V", function()  hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

-- Reload the config
function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
end
local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded 👍")
