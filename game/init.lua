game = {
    objects = {}
}

love.graphics.setBackgroundColor(0, 0.85, 0.85)

function game.load()
    entities = require 'game/entities'
    game.squid = entities.squid.make(100, 100)
end

function game.update(dt)
    game.squid:update(dt)

    for i, v in ipairs(game.objects) do
        if v.update then
            v:update(i, dt)
        end
    end
end

function game.draw()
    game.squid:draw()

    for i, v in ipairs(game.objects) do
        if v.draw then
            v:draw()
        end
    end

    love.graphics.setColor(1, 0, 0)
    love.graphics.circle('fill', love.mouse.getX(), love.mouse.getY(), 2)
end

function game.press(key)
    game.squid:press(key)
end

function game.release(key)
end

return game