if arg[2] == "debug" then
    require("lldebugger").start()
end

_G.love = require("love")
love.graphics.setDefaultFilter("nearest", "nearest")

function love.load()
    love.graphics.setBackgroundColor(252/255, 223/255, 205/255)
    
    Object = require "classic"
    require "cloud"
    require "entity"
    require "platform"
    require "bunny"

    cloud1 = Cloud()
    cloud2 = Cloud() 
    cloud3 = Cloud()
    bunny = Bunny(40, 138)

    platform = {}

    tiles = {}
    for i = 1, 44 do
        table.insert(tiles, 1)
    end

    tilemap = {}
    table.insert(tilemap, tiles)

    for i, row in ipairs(tilemap) do
        for j, w in ipairs(row) do
            if w == 1 then
                table.insert(platform, Platform((j-1) * 16, 170))
            end
        end
    end
end

function love.update(dt)
    cloud1:update(dt)
    if cloud1.x < math.random(400, 500) or cloud2.x < 704 then
        cloud2:update(dt) 
    end

    if cloud2.x < math.random(400, 500) or cloud3.x < 704 then
        cloud3:update(dt) 
    end

    bunny:update(dt)
end

function love.draw()
    cloud1:draw()
    cloud2:draw()
    cloud3:draw()
    bunny:draw()

    for i, v in ipairs(platform) do
        v:draw()
    end
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end