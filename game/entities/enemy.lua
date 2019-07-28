function make(type, x, y)
    local configs = require 'game/entities/enemies'
    local config   = configs[type]

    local enemy = {
        x = x,
        y = y,
        speed = 10,
        sprite = config.sprite
    }

    enemy.update = function(self, i, dt)
        self.y = self.y + self.speed * dt

        for i, v in ipairs(game.ink) do
            if v == nil then
                goto continue
            end

            local width, height = self:get_size()

            local dist = math.distance(self.x + width / 2, self.y + height / 2, v.x, v.y)

            if dist < 25 then
                for i, v in ipairs(game.objects) do
                    if v == self then
                        table.remove(game.objects, i)
                    end
                end
            end

            ::continue::
        end
    end

    enemy.draw = function(self)
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(self.sprite, self.x, self.y, 0, 1, 1)
    end

    enemy.get_size = function(self)
        return self.sprite:getWidth(), self.sprite:getHeight()
    end

    return enemy
end

return {
    make = make,
}