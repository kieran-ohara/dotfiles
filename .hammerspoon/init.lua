-- vim: set foldmethod=marker foldlevel=0 nomodeline:
-- Setup. {{{
local appfinder = hs.appfinder
local application = hs.application
local geometry = hs.geometry
local hotkey = hs.hotkey
local window = hs.window
hs.window.animationDuration = 0

local mash = {"cmd", "alt", "ctrl"}
local spectacle = {"cmd", "alt"}
local spectacleshift = {"cmd", "alt", "shift"}
-- }}}
-- Global Keyboard Shortcuts. {{{
hotkey.bind(mash, "2", function() os.execute("open \"focus://focus?minutes=25\"") end)
hotkey.bind(mash, 'A', function() application.launchOrFocus('Reeder') end)
hotkey.bind(mash, 'B', function() application.launchOrFocus('weka-3-9-2-oracle-jvm') end)
hotkey.bind(mash, 'C', function() application.launchOrFocus('Calendar') end)
hotkey.bind(mash, 'E', function() application.launchOrFocus('Preview') end)
hotkey.bind(mash, 'F', function() application.launchOrFocus('Finder') end)
hotkey.bind(mash, 'H', function() application.launchOrFocus('Google Chrome') end)
hotkey.bind(mash, 'I', function() application.launchOrFocus('iTerm') end)
hotkey.bind(mash, 'K', function() application.launchOrFocus('Kaleidoscope') end)
hotkey.bind(mash, 'M', function() application.launchOrFocus('MindNode') end)
hotkey.bind(mash, 'O', function() application.launchOrFocus('Firefox') end)
hotkey.bind(mash, 'P', function() application.launchOrFocus('Spotify') end)
hotkey.bind(mash, 'R', function() application.launchOrFocus('OmniFocus') end)
hotkey.bind(mash, 'S', function() application.launchOrFocus('Firefox') end)
hotkey.bind(mash, 'T', function() application.launchOrFocus('Contacts') end)
hotkey.bind(mash, 'U', function() application.launchOrFocus('Mail') end)
hotkey.bind(mash, 'W', function() application.launchOrFocus('1Password 7') end)
hotkey.bind(mash, 'X', function() application.launchOrFocus('GitX') end)
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

hotkey.bind(spectacleshift, "H", function()
    moveTo(window.focusedWindow(), 0, 0, 0.5, 1)
    moveNamedAppTo('com.googlecode.iterm2', 0.5, 0, 0.5, 1)
end)

hotkey.bind(spectacleshift, "J", function()
    moveTo(window.focusedWindow(), 0, 0.5, 1, 0.5)
    moveNamedAppTo('com.googlecode.iterm2', 0, 0, 1, 0.5)
end)

hotkey.bind(spectacleshift, "K", function()
    moveTo(window.focusedWindow(), 0, 0, 1, 0.5)
    moveNamedAppTo('com.googlecode.iterm2', 0, 0.5, 1, 0.5)
end)

hotkey.bind(spectacleshift, "L", function()
    moveTo(window.focusedWindow(), 0.5, 0, 0.5, 1)
    moveNamedAppTo('com.googlecode.iterm2', 0, 0, 0.5, 1)
end)

-- Full screen.
hotkey.bind(spectacle, "F", function()
    local win = window.focusedWindow():maximize()
end)
-- }}}
