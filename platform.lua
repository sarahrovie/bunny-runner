Platform = Entity:extend()

function Platform:new(x, y)
    Platform.super.new(self, x, y, "assets/img/Tiles/tile_0004.png")
end

function Platform:update(dt)
    
end

function Platform:draw()
    love.graphics.draw(self.image, self.x, self.y)
end