Bunny = Entity:extend()

function Bunny:new(x, y)
    Bunny.super.new(self, x, y, "assets/img/Tiles/tile_0045.png")
    self.scale = 2
    self.width = self.width*self.scale
    self.height = self.height*self.scale

    frames = {}

    table.insert(frames, love.graphics.newImage("assets/img/Tiles/tile_0045.png"))
    table.insert(frames, love.graphics.newImage("assets/img/Tiles/tile_0046.png"))
    
    currentFrame = 1
end

function Bunny:update(dt)
    currentFrame = currentFrame + 10 * dt
    if currentFrame > 3 then
        currentFrame = 1
    end
end

function Bunny:draw()
    love.graphics.draw(frames[math.floor(currentFrame)], self.x, self.y, 0, self.scale, self.scale)
end