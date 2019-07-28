local highscore = {
    text = "            GAME OVER\n\n       [SPACE] to restart\n\n\nHighscore:",
    score = 0,
}

function highscore.load(score)
    
    local data = love.filesystem.load("highscore.dat")()
    
    table.insert(data, score)

    table.sort(data, scoreCompare)

    love.filesystem.write("highscore.dat", serialize(data))

    for i, s in ipairs(data) do
        if(s == score)then
            highscore.text = highscore.text .. '\n' .. math.floor(s) .. ' seconds   (you)'
        else
        highscore.text = highscore.text .. '\n' .. math.floor(s) .. ' seconds'
        end
        print (data)
    end
end

function highscore.update(dt)

end

function highscore.draw()
    love.graphics.setBackgroundColor(1, 0.2, 0.2)
    love.graphics.setColor(1, 1, 1)

    love.graphics.scale(2, 2)
    love.graphics.print(
        highscore.text,
        love.graphics.getWidth() / 2 / 2 - love.graphics.getFont():getWidth(highscore.text) / 2,
        50
    )
end

function highscore.press(key)
    if key == "space" then
        love.load()
    end
end

function highscore.release(key)

end

function scoreCompare(a, b)
    return a > b
end

return highscore