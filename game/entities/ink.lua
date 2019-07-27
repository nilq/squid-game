function make(x, y)
    local ink = {
        x = x,
        y = y,
        size = 0.5,
        scale = 1.5,
        life = 0,
        weed_mode = false,
        fade = 1,
        death = 1.75,
        pulse = 0,
        pulse_speed = 7,
        a = 0,
    }

    function ink:update(i, dt)
        self.life = self.life + dt * self.fade

        if self.life < self.death / 1.5 then
            self.size = self.size + dt * self.scale
        else
            self.a = self.a + dt * self.pulse_speed
            self.pulse = math.sin(self.a)
        end

        if self.life > self.death then
            self.fade = self.fade + dt * 80

            if self.fade > 255 then
                table.remove(game.objects, i)
            end
        end
    end

    function ink:draw()
        if not self.weed_mode then
            love.graphics.setColor(0, 0, 0, 1 / self.fade)
        else
            love.graphics.setColor(math.random(0, 255) / 255, math.random(0, 255) / 255, math.random(0, 255) / 255)
        end
        love.graphics.circle('fill', self.x, self.y, self.size * 20 + self.pulse * 5)
    end

    return ink
end

return {
    make = make,
}