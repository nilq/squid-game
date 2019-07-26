local game = {
    a = 0,
    a2 = 0,
    color = { 0, 0, 0 },
    size = 0,
}

function game.load()

end

function game.update(dt)
    game.a2 = game.a2 + dt * 4
    game.a = (game.a + dt * 2) % (math.pi * 2)
    game.color = { math.random(0, 255) / 255, math.random(0, 255) / 255, math.random(0, 255) / 255 }
    game.size = math.sin(game.a2)
end

function game.draw()
    love.graphics.setColor(game.color)
    love.graphics.arc('fill', 100 * game.size, 100 * game.size, game.size * 100, 0, 0 + game.a)
end

function game.press(key)
    print('press', key)
end

function game.release(key)
    print('release', key)
end

return game