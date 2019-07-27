function make(type, x, y)
    local configs = require 'game/entities/enemies'
    local enemy   = configs[type].make(x, y)

    function enemy:update(i, dt)
        self.y = self.y + self.speed * dt
    end

    function enemy:draw()
        love.graphics.setColor(0.8, 0.1, 0.1)
        love.graphics.rectangle('fill', self.x, self.y, 100, 50)
    end

    return enemy
end

return {
    make = make,
}