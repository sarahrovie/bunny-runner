Cloud = Object:extend()

function Cloud:new()
    clouds = {}
    table.insert(clouds, love.graphics.newImage("assets/img/Tiles/tile_0011.png"))
    table.insert(clouds, love.graphics.newImage("assets/img/Tiles/tile_0012.png"))

    self.x = 704
    self.y = math.random(20, 80)
    self.index = math.random(1, 2)
    self.scale = math.random(2, 3)
    self.speed = 200
end

function Cloud:update(dt)
    if self.x < 0 then
        self.x = 704
        self.y = math.random(20, 80)
        self.index = math.random(1, 2)
    end

    self.x = self.x - self.speed * dt
end

function Cloud:draw()
    love.graphics.draw(clouds[math.floor(self.index)], self.x, self.y, 0, self.scale, self.scale)
end