function make(x, y)
    local crystal = {
        x = x,
        y = y,
        default_y = y,
        carrying = false,
        sprite = game.sprites.crystal,
    }

    crystal.update = function(self, dt)
        if not self.carrying and self.y > self.default_y then
            self.y = self.default_y
        end
    end

    function crystal:draw()
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(self.sprite, self.x, self.y, 0, 1, 1)
    end

    return crystal
end

return {
    make = make,
}