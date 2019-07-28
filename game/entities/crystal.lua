function make(x, y)
    local crystal = {
        x = x,
        y = y,
        carrying = false,
    }

    function crystal:draw()
        love.graphics.setColor(1, 0, 1)
        love.graphics.rectangle('fill', self.x, self.y, 35, 35)
    end

    return crystal
end

return {
    make = make,
}