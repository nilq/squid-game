function make(x, y)
    local squid = {
        x = x,
        y = y,

        dx = 0,
        dy = 0,

        angle = 0,
        speed = 80,
        friction = 8,
    }

    function squid:update(dt)
        local mouse_x = love.mouse.getX()
        local mouse_y = love.mouse.getY()

        local dist = math.sqrt((self.x - mouse_x)^2 + (self.y - mouse_y)^2)

        if love.mouse.isDown(1) and dist > 15 then
            local target_angle = math.atan2(mouse_y - self.y, mouse_x - self.x)

            print(math.cos(target_angle) * self.speed * dt, math.sin(target_angle) * self.speed * dt)

            self.dx = self.dx + math.cos(target_angle) * self.speed * dt
            self.dy = self.dy + math.sin(target_angle) * self.speed * dt
        end

        self.dx = math.lerp(self.dx, 0, self.friction * dt)
        self.dy = math.lerp(self.dy, 0, self.friction * dt)

        self.x = self.x + self.dx
        self.y = self.y + self.dy
    end

    function squid:draw()
        love.graphics.setColor(0, 0, 1)
        love.graphics.circle('fill', self.x, self.y, 15)
    end

    return squid
end

return {
    make = make
}