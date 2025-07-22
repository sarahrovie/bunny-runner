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
    require "obstacle"
    isPlaying = false

    cloud1 = Cloud(20)
    cloud2 = Cloud(30) 

    bunny = Bunny(40, 138)

    obstacle1 = Obstacle(704, 138)
    obstacle2 = Obstacle(704, 138)

    objects = {}
    table.insert(objects, obstacle1)
    table.insert(objects, obstacle2)

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
        
    if isPlaying == true then
        bunny:update(dt) 

        cloud1:update(dt)

        if checkPosition(cloud1, 300, 350, cloud2) then
            cloud2:update(dt) 
        end

        for i, v in ipairs(platform) do
            v:update(dt)
        end

        obstacle1:update(dt)

        if checkPosition(obstacle1, 300, 400, obstacle2) then
            obstacle2:update(dt)
        end
    end

    for i, object in ipairs(objects) do
        bunny:resolveObstacleCollision(object)
    end

    for i, tile in ipairs(platform) do
        bunny:resolvePlatformCollision(tile)
    end
end

function love.draw()
    cloud1:draw()
    cloud2:draw()
    bunny:draw()

    for i, v in ipairs(platform) do
        v:draw()
    end

    for i, v in ipairs(objects) do
        v:draw()
    end
end

function checkPosition(current, x1, x2, next, dt)
    if current.x < math.random(x1, x2) or next.x < 704 then
        return true
    end
end

function love.keypressed(key)
    if key == "space" or key == "up" then
        if isPlaying == false then
            isPlaying = true
        else
            bunny:jump()
        end
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