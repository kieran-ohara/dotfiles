-- vim: set foldmethod=marker foldlevel=0 nomodeline:
-- Setup. {{{
local appfinder = hs.appfinder
local application = hs.application
local geometry = hs.geometry
local hotkey = hs.hotkey
local window = hs.window
hs.window.animationDuration = 0

local hyper = {"cmd", "alt", "ctrl", "shift"}
local meh = {"cmd", "alt", "shift"}
local spectacle = {"cmd", "alt"}

-- }}}
-- Global Keyboard Shortcuts. {{{
hotkey.bind(hyper, "2", function() os.execute("open \"focus://focus?minutes=25\"") end)
hotkey.bind(hyper, 'A', function() application.launchOrFocus('Reeder') end)
hotkey.bind(hyper, 'B', function() application.launchOrFocus('weka-3-9-2-oracle-jvm') end)
hotkey.bind(hyper, 'C', function() application.launchOrFocus('Calendar') end)
hotkey.bind(hyper, 'E', function() application.launchOrFocus('Preview') end)
hotkey.bind(hyper, 'F', function() application.launchOrFocus('Finder') end)
hotkey.bind(hyper, 'H', function() application.launchOrFocus('Visual Studio Code') end)
hotkey.bind(hyper, 'I', function() application.launchOrFocus('iTerm') end)
hotkey.bind(hyper, 'K', function() application.launchOrFocus('Kaleidoscope') end)
hotkey.bind(hyper, 'M', function() application.launchOrFocus('MindNode') end)
hotkey.bind(hyper, 'O', function() application.launchOrFocus('Firefox') end)
hotkey.bind(hyper, 'P', function() application.launchOrFocus('Spotify') end)
hotkey.bind(hyper, 'R', function() application.launchOrFocus('OmniFocus') end)
hotkey.bind(hyper, 'S', function() application.launchOrFocus('Firefox') end)
hotkey.bind(hyper, 'T', function() application.launchOrFocus('Contacts') end)
hotkey.bind(hyper, 'U', function() application.launchOrFocus('Microsoft Outlook') end)
hotkey.bind(hyper, 'W', function() application.launchOrFocus('1Password 7') end)
hotkey.bind(hyper, 'X', function() application.launchOrFocus('GitX') end)
hotkey.bind(hyper, 'Z', function() application.launchOrFocus('Zotero') end)
-- }}}
-- Move Windows. {{{
function moveTo(win, x, y, h, w)
  local rect = geometry.rect(x, y, h, w)
  hs.window.focusedWindow():moveToUnit(rect)
  -- win:moveToUnit(rect)
end

function moveNamedAppTo(name, x, y, h, w)
    local app = appfinder.appFromName(name)
    moveTo(app:mainWindow(), x, y, h, w)
    app:mainwindow():focus()
end

hotkey.bind(spectacle, "H", function()
    moveTo(window.focusedWindow(), 0, 0, 0.5, 1)
end)

hotkey.bind(spectacle, "J", function()
    moveTo(window.focusedWindow(), 0, 0.5, 1, 0.5)
end)

hotkey.bind(spectacle, "K", function()
    moveTo(window.focusedWindow(), 0, 0, 1, 0.5)
end)

hotkey.bind(spectacle, "L", function()
    moveTo(window.focusedWindow(), 0.5, 0, 0.5, 1)
end)

-- Full screen.
hotkey.bind(spectacle, "F", function()
    local win = window.focusedWindow():maximize()
end)
-- }}}
