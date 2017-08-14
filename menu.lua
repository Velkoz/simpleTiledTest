-- Create pause menu object and function object
local M = {}
local pauseMenu = {}

-- Populate pause menu values
pauseMenu.bg = love.graphics.newImage("assets/menus/pauseBG.png")
pauseMenu.index = 0 -- Initialize to zero
pauseMenu.count = 6 -- Static, update if list below changes length.
pauseMenu.options = {"Party", "Items", "Hearts", "Map", "Save", "Quit"}

-- General menu assets
local selectArrow = love.graphics.newImage("assets/menus/selectArrow.png")

-- Pause functions
local function drawPause(x,y)
	love.graphics.draw(pauseMenu.bg, x, y, 0, 1, 1, 0, 0)

	-- Draw menu options
	for i, value in ipairs(pauseMenu.options) do
		love.graphics.print(value, love.graphics.getWidth() - 275, y + (90 * (i-1)) + 75, 0, 1, 1, 0, 0)
	end

	-- Draw selection arrow
	love.graphics.draw(selectArrow, love.graphics.getWidth() - 350, y + (90 * pauseMenu.index) + 75, 0, 1, 1, 0, 0)
end

-- Add to function object
M.pauseMenu = pauseMenu
M.drawPause = drawPause
return M