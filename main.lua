if arg[2] == "debug" then
    require("lldebugger").start()
end

_G.love = require("love")
love.graphics.setDefaultFilter("nearest", "nearest")

function love.load()
    love.graphics.setBackgroundColor(252/255, 223/255, 205/255)
    
    Object = require "classic"
    require "cloud"

    image = love.graphics.newImage("assets/img/Tilemap/tilemap_packed.png")

    local image_width = image:getWidth()
    local image_height = image:getHeight()

    width = 16
    height = 16

    cloud1 = Cloud()
    cloud2 = Cloud() 
    cloud3 = Cloud()
    
    quads = {}

    for i= 0, 1  do
        for j = 0, 6 do
            table.insert(quads,
            love.graphics.newQuad(
                1 + j * width,
                1 + i * (height - 1),
                width, height,
                image_width, image_height
            ))
        end
    end

    platform = {}
    for i = 1, 44 do
        table.insert(platform, 5)
    end

    tilemap = {}
    table.insert(tilemap, platform)
end

function love.update(dt)
    cloud1:update(dt)
    if cloud1.x < math.random(400, 500) or cloud2.x < 704 then
        cloud2:update(dt) 
    end

    if cloud2.x < math.random(400, 500) or cloud3.x < 704 then
        cloud3:update(dt) 
    end
end

function love.draw()
    cloud1:draw()
    cloud2:draw()
    cloud3:draw()

    for i, row in ipairs(tilemap) do
        for j, tile in ipairs(row) do
            if tile ~= 0 then
                love.graphics.draw(image, quads[tile], (j - 1) * width, 170, 0, 2, 2)
            end
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