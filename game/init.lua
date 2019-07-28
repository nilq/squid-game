game = {
    sprites = {
        squid = love.graphics.newImage("res/squid/squid.png"),
        net = love.graphics.newImage("res/enemies/net.png")
    },
    sounds = {
        ink = love.audio.newSource("res/sound/ink.mp3", "static")
    },
    bottom = 550,
    top = 40,
    left = 40,
    right = 1155,
    spawner = require 'game/spawner',
}

love.graphics.setBackgroundColor(0, 0.85, 0.85)

function game.load()
    game.objects = {}
    game.ink = {}

    local entities = require 'game/entities'
    local camera   = require 'game/camera' 

    game.squid = entities.squid.make(100, 100)
    game.camera = camera(0, 0, 2, 2, 0)

    game.spawner.level = 1
    game.spawner.timer = 0

    game.crystal = entities.crystal.make(600, game.bottom - 35)
end

function game.update(dt)
    game.spawner:update(dt)

    game.squid:update(dt)

    for i, v in ipairs(game.ink) do
        if v.update then
            v:update(i, dt)
        end
    end

    for i, v in ipairs(game.objects) do
        if v.update then
            v:update(i, dt)
        end
    end
end

function game.draw()
    game.camera:set()

    game.squid:draw()
    game.crystal:draw()


    for i, v in ipairs(game.objects) do
        if v.draw then
            v:draw()
        end
    end

    for i, v in ipairs(game.ink) do
        if v.draw then
            v:draw()
        end
    end

    love.graphics.setColor(1, 0, 0)

    local mouse_x = (love.mouse.getX() * game.camera.sx + game.camera.x)
    local mouse_y = (love.mouse.getY() * game.camera.sy + game.camera.y)

    love.graphics.circle('fill', mouse_x, mouse_y, 2)

    love.graphics.setColor(1, 1, 0)
    love.graphics.rectangle('fill', 0, game.bottom, game.camera.x + 1200, 200)

    game.camera:unset()
end

function game.press(key)
    game.squid:press(key)
end

function game.release(key)
end

return game