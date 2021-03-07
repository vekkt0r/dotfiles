--
-- Load the information from the Alfred configuration.
--
require("alfred")

--
-- Place all your functions and configurations here. Running "hs:upgrade" will just
-- over right the alfred.lua file. DO NOT Change the alfred.lua file!
--

--
-- Turn off Animations.
--
hs.window.animationDuration = 0
--hs.loadSpoon("Display")
function caffeinateWatcher(eventType)
    if (eventType == hs.caffeinate.watcher.systemWillSleep or
            eventType == hs.caffeinate.watcher.screensDidSleep) then
            print ("WillSleep...")
            -- Execute sleep script
            hs.task.new("/Users/adam/.displaysleep", nil):start()
    elseif (eventType == hs.caffeinate.watcher.screensDidWake) then
            print ("Woken...")
            -- Execute wake script
            hs.task.new("/Users/adam/.displaywakeup", nil):start()
    end
end

sleepWatcher = hs.caffeinate.watcher.new(caffeinateWatcher)
sleepWatcher:start()
print ("Starting display.lua")

