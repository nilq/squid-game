local game = {}

love.graphics.setBackgroundColor(0, 0.85, 0.85)

function game.load()
    entities = require 'game/entities'
    game.squid = entities.squid.make(100, 100)
end

function game.update(dt)
    game.squid:update(dt)
end

function game.draw()
    game.squid:draw()

    love.graphics.setColor(1, 0, 0)
    love.graphics.circle('fill', love.mouse.getX(), love.mouse.getY(), 2)
end

function game.press(key)
end

function game.release(key)
end

return game