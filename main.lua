local game = require 'game/'

function math.lerp(a, b, t)
    return a + (b - a) * t
end

function love.run()
 
	if love.math then
		love.math.setRandomSeed(os.time())
	end
 
	if love.load then love.load(arg) end
 
	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end
 
	local dt = 0
 
	-- Main loop time.
	while true do
		local start_time = love.timer.getTime()
		-- Process events.
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end
 
		-- Update dt, as we'll be passing it to update
		if love.timer then
			love.timer.step()
			dt = love.timer.getDelta()
		end
		
		-- Call update and draw
		if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled
 
		if love.graphics and love.graphics.isActive() then
			love.graphics.clear(love.graphics.getBackgroundColor())
			love.graphics.origin()
			if love.draw then love.draw() end
			love.graphics.present()
		end
		local end_time = love.timer.getTime()
		local frame_time = end_time - start_time
		
		if love.timer then love.timer.sleep(1/60-frame_time) end
	end
 
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