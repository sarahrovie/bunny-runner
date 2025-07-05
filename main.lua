if arg[2] == "debug" then
    require("lldebugger").start()
end

_G.love = require("love")

function love.load()

end

function love.update(dt)
end

function love.draw()

end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end