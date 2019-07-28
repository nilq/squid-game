function make(x, y)
    local kelp = {
        x = x,
        y = y,
        sprite = game.sprites.kelp,
        red = math.random(0, 1),
        green = math.random(0, 1),
        blue = math.random(0, 1),
    }

    function kelp.draw(self)
        love.graphics.setColor(self.red, self.green, self.blue)
        love.graphics.draw(self.sprite, self.x, self.y, 0, 1, 1)
    end

    return kelp
end

return {
    make = make,
}