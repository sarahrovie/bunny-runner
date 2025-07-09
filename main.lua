if arg[2] == "debug" then
    require("lldebugger").start()
end

_G.love = require("love")
love.graphics.setDefaultFilter("nearest", "nearest")

function love.load()
    love.graphics.setBackgroundColor(252/255, 223/255, 205/255)
    image = love.graphics.newImage("assets/img/Tilemap/tilemap_packed.png")

    local image_width = image:getWidth()
    local image_height = image:getHeight()

    width = 16
    height = 16
    cloud_x  = 704
    cloud_y = 50
    cloud_index = 9

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

    tilemap = {
        {5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5}
    }
end

function love.update(dt)
    if cloud_x < 0 then
        cloud_x = 704
        cloud_y = math.random(20, 80)
        cloud_index = math.random(9, 10)
    end

    cloud_x = cloud_x - 100 * dt
end

function love.draw()
    love.graphics.draw(image, quads[cloud_index], cloud_x, cloud_y, 0, 3, 3)

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