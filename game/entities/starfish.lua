function make(x, y)
    local starfish = {
        x = x,
        y = y,
        sprite = game.sprites.starfish,
    }

    function starfish:draw()
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(self.sprite, self.x, self.y, 0, 1, 1)
    end

    return starfish
end

return {
    make = make,
}