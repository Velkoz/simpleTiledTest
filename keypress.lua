-- Import menu
local menu = require "menu"

-- Handle keypresses for menu pausing and navigation, 

function love.keypressed(key)
	-- Pause, A/B Buttons
	if key == "return" then
		if paused then
			paused = false
		else
			paused = true
		end

	elseif key == abtn then
		if paused then
			-- Select
		else
			--
		end

	elseif key == bbtn then
		if paused then
			--
		end
	
	-- --------------------------------------
	-- Up/Down/Left/Right, for menu selection
	elseif key == upbtn then
		if paused then
			if menu.pauseMenu.index > 0 then
				menu.pauseMenu.index = menu.pauseMenu.index - 1
			else
				menu.pauseMenu.index = 0
			end
			
		else
			--
		end

	elseif key == downbtn then
		if paused then
			if menu.pauseMenu.index < menu.pauseMenu.count - 1 then
				menu.pauseMenu.index = menu.pauseMenu.index + 1
			else
				menu.pauseMenu.index = menu.pauseMenu.count - 1
			end
		else
			--
		end

	elseif key == leftbtn then
		if paused then
			--
		else
			--
		end

	elseif key == rightbtn then
		if paused then
			--
		else
			--
		end
	end
end