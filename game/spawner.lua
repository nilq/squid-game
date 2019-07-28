local spawner = {
    level = 3,
    hardness = 0.0025,
    timer = 0,
    spawn = 0.5,
}

local enemy = (require 'game/entities/').enemy

function spawner:update(dt)
    self.level = self.level + self.hardness * dt

    self.timer = self.timer + dt

    if self.timer > self.spawn then
        self.timer = 0

        if math.random(0, 10) == 0 then
            for i = 0, math.floor(self.level) do
                    table.insert(game.objects, enemy.make('shooter', math.random(50, 1150), 0))
            end
        end
        if math.random(0, 20) == 0 then
            for i = 0, math.floor(self.level) do
                    table.insert(game.objects, enemy.make('normal', math.random(50, 1150), 0))
            end
        end
    end
end

return spawner