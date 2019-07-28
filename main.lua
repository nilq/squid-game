serialize = require 'ser'

function math.lerp(a, b, t)
    return a + (b - a) * t
end

function math.clamp(low, n, high)
  return math.min(math.max(low, n), high)
end

function math.lerp_angle(a, b, t)
    local pi = math.pi
    if (math.abs(a - b) > pi) then
      if (b > a) then
        a = a + pi * 2
      else
        b = b + pi * 2
      end
    end
  
    local value = (a + ((b - a) * t))
  
    local rangeZero = pi * 2
  
    if (value >= 0 and value <= pi * 2) then
      return value
    end
  
    return (value % rangeZero)
  end

function math.distance(x1, y1, x2, y2)
	return math.sqrt((x1 - x2)^2 + (y1 - y2)^2)
end

function math.vector_length(x, y)
	return math.distance(0, 0, x, y)
end


love.graphics.setDefaultFilter("nearest", "nearest") -- before game

local game = require 'game/'

function love.load(dead)
  if dead == true then
    game = require 'highscore'
  end

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