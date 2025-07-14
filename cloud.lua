Cloud = Object:extend()

function Cloud:new(y, speed)
    clouds = {}
    table.insert(clouds, love.graphics.newImage("assets/img/Tiles/tile_0011.png"))
    table.insert(clouds, love.graphics.newImage("assets/img/Tiles/tile_0012.png"))

    self.x = 704
    self.y = y
    self.index = math.random(1, 2)
    self.scale = 2
    self.speed = speed
end

function Cloud:update(dt)
    if self.x < 0 then
        self.x = 704
        self.index = math.random(1, 2)
    end

    self.x = self.x - self.speed * dt
end

function Cloud:draw()
    love.graphics.draw(clouds[math.floor(self.index)], self.x, self.y, 0, self.scale, self.scale)
end