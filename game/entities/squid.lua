function make(x, y)
    local squid = {
        sprite = game.sprites.squid,

        x = x,
        y = y,

        dx = 0,
        dy = 0,
        d = 0,

        angle = 0,
        fixed_angle = 0, -- for nicer sprite
        
        acceleration = 750,
        friction = 3,

        mouse_break_distance = 40,
        breaking_friction = 6,

        ink_shoot_distance = -10,

        ink_boost = 200,
        ink_shoot_number = 3,
        ink_shoot_interval = 0.03,
        ink_cooldown = 1,

        ink_shoot_number_counter = 999,
        ink_shoot_interval_timer = 999,
        ink_cooldown_timer = 999,

        caught_in_net = 0, -- number of nets the squid is caught in
        net_friction = 50,
    }

    function squid:update(dt)
        self.fixed_angle = math.lerp_angle(self.fixed_angle, self.angle, dt * 50)

        self:movement_type_b(dt)

        self:ink_tick(dt)

        local camera_speed = 100

        game.camera.x = math.lerp(game.camera.x, self.x, dt * camera_speed)
        game.camera.y = math.lerp(game.camera.y, self.y, dt * camera_speed)

        game.camera.x = math.clamp(game.left, game.camera.x, game.right)
        game.camera.y = math.clamp(game.top, game.camera.y, game.bottom)

        self.x = math.clamp(game.left, self.x, game.right)
        self.y = math.clamp(game.top, self.y, game.bottom)
    end

    function squid:draw()
        love.graphics.setColor(1, 1, 1)

        local width, height = self:get_size()

        love.graphics.draw(self.sprite, self.x, self.y, self.fixed_angle + math.pi / 2, 1, 1, width / 2, height / 2)
    end

    function squid:get_size()
        return self.sprite:getWidth(), self.sprite:getHeight()
    end

    function squid:press(key)
        if key == "space" and self.ink_cooldown_timer > self.ink_cooldown then
            local ink = require 'game/entities/ink'

            table.insert(game.ink, ink.make(self.x + math.cos(self.angle) * self.ink_shoot_distance, self.y + math.sin(self.angle) * self.ink_shoot_distance))
            
            game.sounds.ink:stop()
            game.sounds.ink:setVolume(0.25)
            game.sounds.ink:setPitch(0.5 + math.random(0, 50) / 100)
            game.sounds.ink:play()

            self.d = self.d + self.ink_boost

            self.ink_shoot_number_counter = 1 -- already shot the first load
            self.ink_cooldown_timer = 0
            self.ink_shoot_interval_timer = 0
        end

        if key == "e" then
            local net = (require 'game/entities/net')
            local n = net.make(self.x, self.y)

            table.insert(game.objects, n)
        end
    end

    function squid:movement_type_a(dt)
        local mouse_x = (love.mouse.getX() * game.camera.sx + game.camera.x)
        local mouse_y = (love.mouse.getY() * game.camera.sy + game.camera.y)

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

        if self.caught_in_net > 0 then
            friction = self.net_friction
        end

        self.d = math.lerp(self.d, 0, friction * dt)

        self.x = self.x + math.cos(self.angle) * self.d * dt
        self.y = self.y + math.sin(self.angle) * self.d * dt
    end

    function squid:ink_tick(dt)
        self.ink_cooldown_timer = self.ink_cooldown_timer + dt
        self.ink_shoot_interval_timer = self.ink_shoot_interval_timer + dt

        if self.ink_shoot_number_counter < self.ink_shoot_number then  -- First ink shoot happens right when space is pressed.
            if self.ink_shoot_interval_timer > self.ink_shoot_interval then

                local ink = require 'game/entities/ink'
                table.insert(game.ink, ink.make(self.x + math.cos(self.angle) * self.ink_shoot_distance, self.y + math.sin(self.angle) * self.ink_shoot_distance))

                self.ink_shoot_interval_timer = 0

                self.ink_shoot_number_counter = self.ink_shoot_number_counter + 1
            end
        end
    end


    return squid
end

return {
    make = make
}