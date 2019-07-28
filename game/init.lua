game = {
    sprites = {
        squid = love.graphics.newImage("res/squid/squid.png"),
        net = love.graphics.newImage("res/enemies/net.png"),
        crystal = love.graphics.newImage("res/crystal.png"),
        kelp = love.graphics.newImage("res/env/kelp.png"),
        starfish = love.graphics.newImage("res/env/starfish.png")
    },
    sounds = {
        ink = love.audio.newSource("res/sound/ink3.mp3", "static")
    },
    bottom = 550,
    top = 40,
    left = 40,
    right = 1155,
    spawner = require 'game/spawner',
    score = 0,
}

love.graphics.setBackgroundColor(0, 0.85, 0.85)

function game.load()
    game.objects = {}
    game.ink = {}
    game.ocean_floor = {}

    local entities = require 'game/entities'
    local camera   = require 'game/camera' 

    game.squid = entities.squid.make(100, 400)
    game.camera = camera(0, 0, 2, 2, 0)

    game.spawner.level = 1
    game.spawner.timer = 0

    game.crystal = entities.crystal.make(100, game.bottom - 35)

    for i = 0, 25 do
        table.insert(game.ocean_floor, entities.starfish.make(math.random(game.left, game.right), game.bottom + math.random(-0, 50)))
    end

    for i = 0, 100 do
        table.insert(game.ocean_floor, entities.kelp.make(math.random(game.left, game.right), game.bottom + math.random(-40, 30)))
    end
end

function game.update(dt)
    game.score = game.score + dt

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

    game.crystal:update(dt)
end

function game.draw()
    game.camera:set()

    love.graphics.setColor(1, 1, 0)
    love.graphics.rectangle('fill', 0, game.bottom, game.camera.x + 1200, 200)

    game.crystal:draw()
    game.squid:draw()


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

    for i, v in ipairs(game.ocean_floor) do
        if v.draw then
            v:draw()
        end
    end

    game.camera:unset()
end

function game.press(key)
    game.squid:press(key)
end

function game.release(key) end

return game