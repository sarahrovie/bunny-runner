if arg[2] == "debug" then
    require("lldebugger").start()
end

_G.love = require("love")
love.graphics.setDefaultFilter("nearest", "nearest")
love.graphics.setBackgroundColor(252/255, 223/255, 205/255)
    font = love.graphics.newFont("assets/fonts/Kenney Mini.ttf", 19)

function love.load()
    love.graphics.setFont(font)

    lume = require "lume"
    Object = require "classic"
    require "cloud"
    require "entity"
    require "platform"
    require "bunny"
    require "obstacle"

    isPlaying = false
    score = 0
    highscore = 0

    if love.filesystem.getInfo("savedata.txt") then
        file = love.filesystem.read("savedata.txt")
        data = lume.deserialize(file)

        highscore = data
    end

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
        score = score + 2 * dt

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
        if bunny:resolveObstacleCollision(object) then
            if score > highscore then
                highscore = math.floor(score)
                saveGame()
            end
            love.load()
        end
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

    love.graphics.setColor(1, 1, 1)
    if highscore > 0 then
        love.graphics.print("HI " .. tostring(highscore), 580, 10) 
    end
    love.graphics.print(tostring(math.floor(score)), 650, 10)
end

function checkPosition(current, x1, x2, next, dt)
    if current.x < math.random(x1, x2) or next.x < 704 then
        return true
    end
end

function saveGame()
    hs = highscore
    serialized = lume.serialize(hs)
    love.filesystem.write("savedata.txt", serialized)
end

function love.keypressed(key)
    if key == "space" or key == "up" then
        if isPlaying == false then
            isPlaying = true
        else
            bunny:jump()
        end
    end

    if key == "r" then
        love.filesystem.remove("savedata.txt")
            love.event.quit("restart")
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