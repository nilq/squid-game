function make(type, x, y)
    local configs = require 'game/entities/enemies'
    local config   = configs[type]

    local enemy = {
        x = x,
        y = y,
        speed = 10,
    }

    enemy.update = function(self, i, dt)
        self.y = self.y + self.speed * dt

        for i, v in ipairs(game.ink) do
            if v == nil then
                print("heskjd")
                goto continue
            end

            local dist = math.distance(self.x + 50, self.y + 25, v.x, v.y)

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
        love.graphics.setColor(0.8, 0.1, 0.1)
        love.graphics.rectangle('fill', self.x, self.y, 100, 50)
    end

    return enemy
end

return {
    make = make,
}