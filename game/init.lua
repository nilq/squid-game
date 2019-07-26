game = {
    ink = {}
}

love.graphics.setBackgroundColor(0, 0.85, 0.85)

function game.load()
    entities = require 'game/entities'
    game.squid = entities.squid.make(100, 100)
end

function game.update(dt)
    for i, v in ipairs(game.ink) do
        v.life = v.life + dt * 0.85
    end

    game.squid:update(dt)
end

function game.draw()
    game.squid:draw()

    for i, v in ipairs(game.ink) do
        love.graphics.setColor(0, 0, 0, 1 / v.life)
        love.graphics.circle('fill', v.x, v.y, v.life * 50)
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