function make(x, y)
    local net = {
        x = x,
        y = y,
        speed = 100,
        sprite = game.sprites.net,

        collision_enter = false,
        collision_exit = false,
        was_colliding_in_the_previous_frame = false,
    }

    net.update = function(self, _, dt)
        self.y = self.y + self.speed * dt

        self:update_squid_collision(game.squid)

        if self.collision_enter then
            game.squid.caught_in_net = game.squid.caught_in_net + 1
            print(game.squid.caught_in_net)
        end

        if self.collision_exit then
            game.squid.caught_in_net = game.squid.caught_in_net - 1
        end
    end

    net.draw = function(self)
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(self.sprite, self.x, self.y, 0, 1, 1)
    end

    net.get_size = function(sprite)
        return sprite.sprite:getWidth(), sprite.sprite:getHeight()
    end

    net.check_rectangles_overlap = function(a, b)
        local overlap = false
        if not( a.x + a.width < b.x  or b.x + b.width < a.x  or
                a.y + a.height < b.y or b.y + b.height < a.y ) then
           overlap = true
        end
        return overlap
    end

    net.colliding = function(self, other)
        local self_width, self_height = self:get_size()
        local self_rectangle = { x = self.x, y = self.y, width = self_width, height = self_height }

        local other_width, other_height = self.get_size(other)
        local other_rectangle = { x = other.x, y = other.y, width = other_width, height = other_height}

        return self.check_rectangles_overlap(self_rectangle, other_rectangle)
    end

    net.update_squid_collision = function(self, squid)
        self.collision_enter = false
        self.collision_exit = false

        if self:colliding(squid) then 
            if not self.was_colliding_in_the_previous_frame then
                self.collision_enter = true
                self.was_colliding_in_the_previous_frame = true
            end
        else
            if self.was_colliding_in_the_previous_frame then
                self.collision_exit = true
                self.was_colliding_in_the_previous_frame = false
            end
        end

    end

    return net
end

return {
    make = make,
}