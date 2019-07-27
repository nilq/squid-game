function make(x, y)
    local ink = {
        x = x,
        y = y,
        size = 0.5,
        scale = 1.5,
        life = 0,
        weed_mode = false,
        fade = 1,
        death = 3,
    }

    function ink:update(i, dt)
        self.life = self.life + dt * self.fade

        if self.life < self.death / 2 then
            self.size = self.size + dt * self.scale
        end
        
        if self.life > self.death then
            table.remove(game.objects, i)
        end
    end

    function ink:draw()
        if not self.weed_mode then
            love.graphics.setColor(0, 0, 0, 1 / self.life)
        else
            love.graphics.setColor(math.random(0, 255) / 255, math.random(0, 255) / 255, math.random(0, 255) / 255)
        end
        love.graphics.circle('fill', self.x, self.y, self.size * 25)
    end

    return ink
end

return {
    make = make,
}