local game = require 'game/'

function math.lerp(a, b, t)
    return a + (b - a) * t
end

function math.distance(x1, y1, x2, y2)
	return math.sqrt((x1 - x2)^2 + (y1 - y2)^2)
end

function math.vector_length(x, y)
	return math.distance(0, 0, x, y)
end


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