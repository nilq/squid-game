function make(x, y)
    local squid = {
        x = x,
        y = y,

        dx = 0,
        dy = 0,
        d = 0,

        angle = 0,
        
        acceleration = 1500,
        friction = 3,

        mouse_break_distance = 40,
        breaking_friction = 6
    }

    function squid:update(dt)
        self:movement_type_b(dt)
    end

    function squid:draw()
        love.graphics.setColor(0, 0, 1)
        love.graphics.circle('fill', self.x, self.y, 15)
    end

    function squid:press(key)
        if key == "space" then
            local ink = require 'game/entities/ink'
            table.insert(game.objects, ink.make(self.x, self.y))
        end

        if key == "e" then
            local enemy = require 'game/entities/enemy'
            table.insert(game.objects, enemy.make('normal', self.x, self.y))
        end
    end

    function squid:movement_type_a(dt)
        local mouse_x = love.mouse.getX()
        local mouse_y = love.mouse.getY()

        local dist = math.distance(self.x, self.y, mouse_x, mouse_y)

        local friction = self.friction

        if love.mouse.isDown(1) then
            local target_angle = math.atan2(mouse_y - self.y, mouse_x - self.x)

            if dist > self.mouse_break_distance then
                self.dx = self.dx + math.cos(target_angle) * self.acceleration * dt
                self.dy = self.dy + math.sin(target_angle) * self.acceleration * dt
            else
                friction = self.breaking_friction
            end
        end

        self.dx = math.lerp(self.dx, 0, friction * dt)
        self.dy = math.lerp(self.dy, 0, friction * dt)

        self.x = self.x + self.dx * dt
        self.y = self.y + self.dy * dt
    end

    function squid:movement_type_b(dt)
        local mouse_x = love.mouse.getX()
        local mouse_y = love.mouse.getY()

        local dist = math.distance(self.x, self.y, mouse_x, mouse_y)

        local friction = self.friction

        if love.mouse.isDown(1) then
            local target_angle = math.atan2(mouse_y - self.y, mouse_x - self.x)

            self.angle = target_angle

            if dist > self.mouse_break_distance then
                self.d = self.d + self.acceleration * dt
            elseif dist > 1 then
                friction = self.breaking_friction
            else
                self.d = 0
            end
        end

        self.d = math.lerp(self.d, 0, friction * dt)

        self.x = self.x + math.cos(self.angle) * self.d * dt
        self.y = self.y + math.sin(self.angle) * self.d * dt
    end


    return squid
end

return {
    make = make
}