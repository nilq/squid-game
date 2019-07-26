local game = require 'game/'

function love.load()
    game.load()
end

function love.update(dt)
    game.update(dt)
end

function love.draw()
    game.draw()
end

function love.keypressed(key)
    game.press(key)
end

function love.keyreleased(key)
    game.release(key)
end