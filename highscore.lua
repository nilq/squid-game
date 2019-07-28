local highscore = {
    text = "You fucked up",
    score = 0,
}

function highscore.load()
    highscore.score = love.filesystem.load("highscore.dat")()

    highscore.text = highscore.text .. '\n' .. highscore.score.score .. ' seconds'
end

function highscore.update(dt)

end

function highscore.draw()
    love.graphics.setBackgroundColor(1, 0.2, 0.2)

    love.graphics.scale(2, 2)
    love.graphics.print(
        highscore.text,
        love.graphics.getWidth() / 2 / 2 - love.graphics.getFont():getWidth(highscore.text) / 2,
        50
    )
end

function highscore.press(key)

end

function highscore.release(key)

end

return highscore