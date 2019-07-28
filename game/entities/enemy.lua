function make(type, x, y)
    local configs = require 'game/entities/enemies'
    local config   = configs[type] 
    local enemy = {
        x = x,
        y = y,
        speed = config.speed,
        sprite = config.sprite,
        carrying = false,
    }

    enemy.update = function(self, i, dt)
        if config.update then
            config.update(self)
        end

        local target_angle = math.atan2(game.crystal.y - self.y, game.crystal.x - self.x)

        if self.carrying then
            local width, height = self:get_size()

            game.crystal.x = math.lerp(game.crystal.x, self.x + width / 2 - 15, dt * 100)
            game.crystal.y = math.lerp(game.crystal.y, self.y + height - 16, dt * 100)

            self.x = self.x + self.speed * 3 * dt

            if self.x > game.right then
                game.load()
            end
        else
            self.x = self.x + math.cos(target_angle) * self.speed * dt
            self.y = self.y + math.sin(target_angle) * self.speed * dt

            if math.distance(self.x, self.y, game.crystal.x, game.crystal.y) < 60 then
                if not game.crystal.carrying then
                    self.carrying = true
                    game.crystal.carrying = true
                end
            end
        end

        for i, v in ipairs(game.ink) do
            if v == nil then
                goto continue
            end

            local width, height = self:get_size()

            local dist = math.distance(self.x + 55, self.y + 6, v.x, v.y)

            if dist < v.size and v.life < v.death then
                for i, v in ipairs(game.objects) do
                    if v == self then
                        if self.carrying then
                            game.crystal.carrying = false
                        end

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