-- vim: set foldmethod=marker foldlevel=0 nomodeline:
-- Setup. {{{
local path = os.getenv("HOME") .. '/.luarocks/share/lua/5.2/?.lua'
local path_init = os.getenv("HOME") .. '/.luarocks/share/lua/5.2/?/init.lua'
local cpath = os.getenv("HOME") .. '/.luarocks/lib/lua/5.2/?.so'

package.path = package.path .. ';' .. path .. ';' .. path_init
package.cpath = package.cpath .. ';' .. cpath

local application = require "mjolnir.application"
local fnutils = require "mjolnir.fnutils"
local geometry = require "mjolnir.geometry"
local hotkey = require "mjolnir.hotkey"
local screen = require "mjolnir.screen"
local window = require "mjolnir.window"

local mash = {"cmd", "alt", "ctrl"}
local spectacle = {"cmd", "alt"}
local spectacleshift = {"cmd", "alt", "shift"}
-- }}}
-- Global Keyboard Shortcuts. {{{
hotkey.bind(mash, "2", function() os.execute("open \"focus://focus?minutes=25\"") end)
hotkey.bind(mash, 'B', function() application.launchorfocus('weka-3-9-2-oracle-jvm') end)
hotkey.bind(mash, 'C', function() application.launchorfocus('Calendar') end)
hotkey.bind(mash, 'E', function() application.launchorfocus('Preview') end)
hotkey.bind(mash, 'F', function() application.launchorfocus('Finder') end)
hotkey.bind(mash, 'H', function() application.launchorfocus('Google Chrome') end)
hotkey.bind(mash, 'I', function() application.launchorfocus('iTerm') end)
hotkey.bind(mash, 'K', function() application.launchorfocus('Kaleidoscope') end)
hotkey.bind(mash, 'M', function() application.launchorfocus('MindNode') end)
hotkey.bind(mash, 'O', function() application.launchorfocus('Firefox') end)
hotkey.bind(mash, 'P', function() application.launchorfocus('Spotify') end)
hotkey.bind(mash, 'R', function() application.launchorfocus('OmniFocus') end)
hotkey.bind(mash, 'S', function() application.launchorfocus('Firefox') end)
hotkey.bind(mash, 'T', function() application.launchorfocus('Contacts') end)
hotkey.bind(mash, 'U', function() application.launchorfocus('Firefox') end)
hotkey.bind(mash, 'W', function() application.launchorfocus('1Password 7') end)
hotkey.bind(mash, 'X', function() application.launchorfocus('GitX') end)
-- }}}
-- Move Windows. {{{
function moveTo(win, x, y, h, w)
  local rect = geometry.rect(x, y, h, w)
  win:movetounit(rect)
end

function moveNamedAppTo(name, x, y, h, w)
    local app = application.applicationsforbundleid(name)[1]
    moveTo(app:mainwindow(), x, y, h, w)
    app:mainwindow():focus()
end

hotkey.bind(spectacle, "H", function()
    moveTo(window.focusedwindow(), 0, 0, 0.5, 1)
end)

hotkey.bind(spectacle, "J", function()
    moveTo(window.focusedwindow(), 0, 0.5, 1, 0.5)
end)

hotkey.bind(spectacle, "K", function()
    moveTo(window.focusedwindow(), 0, 0, 1, 0.5)
end)

hotkey.bind(spectacle, "L", function()
    moveTo(window.focusedwindow(), 0.5, 0, 0.5, 1)
end)

hotkey.bind(spectacleshift, "H", function()
    moveTo(window.focusedwindow(), 0, 0, 0.5, 1)
    moveNamedAppTo('com.googlecode.iterm2', 0.5, 0, 0.5, 1)
end)

hotkey.bind(spectacleshift, "J", function()
    moveTo(window.focusedwindow(), 0, 0.5, 1, 0.5)
    moveNamedAppTo('com.googlecode.iterm2', 0, 0, 1, 0.5)
end)

hotkey.bind(spectacleshift, "K", function()
    moveTo(window.focusedwindow(), 0, 0, 1, 0.5)
    moveNamedAppTo('com.googlecode.iterm2', 0, 0.5, 1, 0.5)
end)

hotkey.bind(spectacleshift, "L", function()
    moveTo(window.focusedwindow(), 0.5, 0, 0.5, 1)
    moveNamedAppTo('com.googlecode.iterm2', 0, 0, 0.5, 1)
end)

-- Full screen.
hotkey.bind(spectacle, "F", function()
    local win = window.focusedwindow():maximize()
end)
-- }}}
