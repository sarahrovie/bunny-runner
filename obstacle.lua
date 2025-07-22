Obstacle = Entity:extend()

function Obstacle:new(x, y)
    Obstacle.super.new(self, x, y, "assets/tiles/obstacles/obs1.png")
    self.scale = 2
    self.width = self.width*self.scale
    self.height = self.height*self.scale
    self.index = math.random(1, 6)
    self.speed = 200
    self.weight = 0

    obstacles = {}
    for i = 1, 6 do
        table.insert(obstacles, love.graphics.newImage("assets/tiles/obstacles/obs" .. i .. ".png"))
    end
end

function Obstacle:update(dt)
    if self.x < 0 then
        self.x = 704
        self.index = math.random(1, 6)
    end

    self.x = self.x - self.speed * dt
end

function Obstacle:draw()
    love.graphics.draw(obstacles[math.floor(self.index)], self.x, self.y, 0, self.scale, self.scale)
end