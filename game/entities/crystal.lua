function make(x, y)
    local crystal = {
        x = x,
        y = y,
        default_y = y,
        carrying = false,
        sprite = game.sprites.crystal,
    }

    function crystal:update(dt)
        if not self.carrying and self.y < self.default_y then
            self.y = self.y + dt * 50
        end
    end

    function crystal:draw()
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(game.sprites.crystal, self.x, self.y)
    end

    return crystal
end

return {
    make = make,
}