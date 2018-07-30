local path = os.getenv("HOME") .. '/.luarocks/share/lua/5.2/?.lua'
local path_init = os.getenv("HOME") .. '/.luarocks/share/lua/5.2/?/init.lua'
local cpath = os.getenv("HOME") .. '/.luarocks/lib/lua/5.2/?.so'

package.path = package.path .. ';' .. path .. ';' .. path_init
package.cpath = package.cpath .. ';' .. cpath

local application = require "mjolnir.application"
local fnutils = require "mjolnir.fnutils"
local fnutils = require "mjolnir.fnutils"
local hotkey = require "mjolnir.hotkey"
local screen = require "mjolnir.screen"
local window = require "mjolnir.window"

local mash = {"cmd", "alt", "ctrl"}
local spectacle = {"cmd", "alt"}

-- Most common used apps get their own shortcuts.
hotkey.bind(mash, 'C', function() application.launchorfocus('Calendar') end)
hotkey.bind(mash, 'E', function() application.launchorfocus('Preview') end)
hotkey.bind(mash, 'F', function() application.launchorfocus('Finder') end)
hotkey.bind(mash, 'H', function() application.launchorfocus('Google Chrome') end)
hotkey.bind(mash, 'I', function() application.launchorfocus('iTerm') end)
hotkey.bind(mash, 'J', function() application.launchorfocus('IntelliJ IDEA CE') end)
hotkey.bind(mash, 'K', function() application.launchorfocus('Kaleidoscope') end)
hotkey.bind(mash, 'L', function() application.launchorfocus('Charles') end)
hotkey.bind(mash, 'M', function() application.launchorfocus('MindNode') end)
hotkey.bind(mash, 'N', function() application.launchorfocus('iTunes') end)
hotkey.bind(mash, 'O', function() application.launchorfocus('Firefox') end)
hotkey.bind(mash, 'P', function() application.launchorfocus('Spotify') end)
hotkey.bind(mash, 'R', function() application.launchorfocus('OmniFocus') end)
hotkey.bind(mash, 'S', function() application.launchorfocus('Slack') end)
hotkey.bind(mash, 'T', function() application.launchorfocus('Contacts') end)
hotkey.bind(mash, 'U', function() application.launchorfocus('Mail') end)
hotkey.bind(mash, 'W', function() application.launchorfocus('1Password 7') end)
hotkey.bind(mash, 'X', function() application.launchorfocus('GitX') end)

-- Left half.
local function leftHalf(win)
    local screenFrame = screen.mainscreen():frame()
    local frame = win:frame()
    frame.x = screenFrame.x
    frame.y = screenFrame.y
    frame.w = screenFrame.w / 2
    frame.h = screenFrame.h
    win:setframe(frame)
end

hotkey.bind(spectacle, "j", function()
    leftHalf(window.focusedwindow())
end)

-- Right half.
local function rightHalf(win)
    local screenFrame = screen.mainscreen():frame()
    local frame = win:frame()
    frame.x = screenFrame.x + (screenFrame.w / 2)
    frame.y = screenFrame.y
    frame.w = screenFrame.w / 2
    frame.h = screenFrame.h
    win:setframe(frame)
end

hotkey.bind(spectacle, "k", function()
    rightHalf(window.focusedwindow())
end)

-- Full screen.
hotkey.bind(spectacle, "F", function()
    local win = window.focusedwindow():maximize()
end)

-- iTerm love.
hotkey.bind(mash, "'", function()
    rightHalf(window.focusedwindow())
    local iterm = application.applicationsforbundleid('com.googlecode.iterm2')[1]
    leftHalf(iterm:mainwindow())
end)

-- Focus.
hotkey.bind(mash, "1", function()
    os.execute("open \"focus://focus?minutes=5\"")
end)

hotkey.bind(mash, "2", function()
    os.execute("open \"focus://focus?minutes=25\"")
end)
