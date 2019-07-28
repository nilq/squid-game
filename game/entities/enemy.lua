function make(type, x, y)
    local configs = require 'game/entities/enemies'
    local config   = configs[type] 
    local enemy = {
        x = x,
        y = y,
        speed = config.speed,
        sprite = config.sprite,
        carrying = false,
        timer = 0,
        type = type,
        falling = false,

        angle = 0,
        target_wiggle = 0,
        wiggle_time = 0,

        corpse_timer = 0,
        corpse_remove = 5, -- seconds
    }

    enemy.update = function(self, i, dt)
        if config.update then
            config.update(self, dt)
        end

        if self.carrying and not self.falling then
            local width, height = self:get_size()

            game.crystal.x = math.lerp(game.crystal.x, self.x, dt * 100)
            game.crystal.y = math.lerp(game.crystal.y, self.y + height / 2 - 16, dt * 100)

            self.x = self.x + self.speed * 3 * dt

            if self.x > game.right then
                love.load(true, game.score)
            end
        else
            if not self.falling then
                local target_angle = math.atan2(game.crystal.y - self.y, game.crystal.x - self.x)

                self.x = self.x + math.cos(target_angle) * self.speed * dt
                self.y = self.y + math.sin(target_angle) * self.speed * dt

                if math.distance(self.x, self.y, game.crystal.x, game.crystal.y) < 60 then
                    if not game.crystal.carrying then
                        self.carrying = true
                        game.crystal.carrying = true
                    end
                end
            end
        end

        for i, v in ipairs(game.ink) do
            if v == nil then
                goto continue
            end

            local width, height = self:get_size()

            local offset_x, offset_y = 55 + width / -2, 6 + height / -2

            if self.type == "shooter" then
                offset_x, offset_y = 73 + width / -2, 20 + height / -2
            end

            local dist = math.distance(self.x + offset_x, self.y + offset_y, v.x, v.y)

            if dist < v.size and v.life < v.death then
                self.falling = true
                if self.carrying then
                    game.crystal.carrying = false
                end
                self.sprite = config.dead_sprite or self.sprite
            end

            if self.falling then
                self.wiggle_time = self.wiggle_time + dt * 2

                if self.y < game.bottom - self.sprite:getHeight() / 6 then
                    self.y = self.y + self.speed * dt
                    self.angle = math.lerp(self.angle, self.target_wiggle, dt * 50)
                end

                if self.wiggle_time > 0.2 then
                    self.target_wiggle = math.random(-90, 100) / 360
                end
            end

            if not (self.y < game.bottom - self.sprite:getHeight() / 6) and self.falling then
                self.corpse_timer = self.corpse_timer + dt

                if self.corpse_timer > self.corpse_remove then
                    for i, v in ipairs(game.objects) do
                        if v == self then
                            if self.carrying then
                                game.crystal.carrying = false
                            end

                            table.remove(game.objects, i)
                        end
                    end
                end
            end

            ::continue::
        end
    end

    enemy.draw = function(self)
        love.graphics.setColor(1, 1, 1)

        local width, height = self:get_size()

        love.graphics.draw(self.sprite, self.x, self.y, self.angle, 1, 1, width / 2, height / 2)
    end

    enemy.get_size = function(self)
        return self.sprite:getWidth(), self.sprite:getHeight()
    end

    return enemy
end

return {
    make = make,
}