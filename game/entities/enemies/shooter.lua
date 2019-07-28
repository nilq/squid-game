local net = (require 'game/entities/net')

return {
    speed  = 10,
    sprite = love.graphics.newImage("res/enemies/shooter.png"),
    update = function(self, dt)
        if self.falling then
            return
        end

        self.timer = self.timer + dt

        if self.timer > 5 then
            local n = net.make(self.x - 30, self.y + 30)

            table.insert(game.objects, n)

            self.timer = 0
        end
    end
}