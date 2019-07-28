function make(x, y)
    local crystal = {
        x = x,
        y = y,
        carrying = false,
    }

    function crystal:draw()
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(game.sprites.crystal, self.x, self.y)
    end

    return crystal
end

return {
    make = make,
}