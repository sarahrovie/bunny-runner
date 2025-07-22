Bunny = Entity:extend()

function Bunny:new(x, y)
    Bunny.super.new(self, x, y, "assets/tiles/bunny/bunny1.png")
    self.scale = 2
    self.width = self.width*self.scale
    self.height = self.height*self.scale
    self.canJump = false
    self.isJumping = false

    frames = {}

    table.insert(frames, love.graphics.newImage("assets/tiles/bunny/bunny1.png"))
    table.insert(frames, love.graphics.newImage("assets/tiles/bunny/bunny2.png"))
    
    currentFrame = 1
end

function Bunny:update(dt)
    Bunny.super.update(self, dt)
    
    if self.isJumping == true then
        currentFrame = 2
    end

    currentFrame = currentFrame + 10 * dt

    if currentFrame > 3 then
        currentFrame = 1
    end
end

function Bunny:resolveObstacleCollision(e)
    if self:checkCollision(e) then
        love.load()
    end
end

function Bunny:jump()
    if self.canJump then
        self.gravity = -300
        self.isJumping = true
        self.canJump = false
    end
end

function Bunny:draw()
    love.graphics.draw(frames[math.floor(currentFrame)], self.x, self.y, 0, self.scale, self.scale)
end