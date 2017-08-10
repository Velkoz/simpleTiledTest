-- Test of sti
local sti = require "lua_modules/sti"
local class = require "lua_modules/30log"
local bump = require "lua_modules/bump"

-- Keypress file
require "keypress"

-- transform values
local tx, ty, sx, sy, map
local screen_width, screen_height
tile_height = 16
player = {}

-- Menu/key input values
paused = false
inCombat = false
abtn = "z"
bbtn = "x"
upbtn, downbtn, leftbtn, rightbtn = "up", "down", "left", "right"

function love.load()
	-- Window values
	love.window.setTitle("STI Test")
	love.window.setMode(1280, 720, {resizable=true, vsync=false})
	love.graphics.setDefaultFilter("nearest", "nearest", 1)

	-- Load map file and initialize values
	map = sti("maps/first.lua", {"bump"})
	tx, ty = 0, 0
	sx, sy = 4, 4
	screen_width, screen_height = love.graphics.getWidth() / sx, love.graphics.getHeight() / sy

	-- Collision
	world = bump.newWorld(16)
	map:bump_init(world)

	-- Create sprite layer
	local spriteLayer = map:addCustomLayer("Sprites", 3)

	-- Get player object
	player = {
		sprite = love.graphics.newImage("assets/player/player.png"),
		x = 160,
		y = 160,
		w = 16,
		h = 16,
		ox = tile_height / 2,
		oy = tile_height / 2,
		dir = "down"
	}

	world:add(player, player.x, player.y, player.w, player.h)

	-- Draw player
	spriteLayer.draw = function(self)
		love.graphics.draw(
			player.sprite, math.floor(player.x), math.floor(player.y), 0, 1, 1, ox, oy)
	end
end

function love.update(dt)
	-- Update map
	map:update(dt)

	-- Update player position
	local down = love.keyboard.isDown
	local speed = 96

	if not paused then
		-- Handle key input (only handle one at a time, no diagonals)
		if down(upbtn) then
			player.y = player.y - speed * dt
			player.dir = "up"
		elseif down(downbtn) then
			player.y = player.y + speed * dt
			player.dir = "down"
		elseif down(leftbtn) then
			player.x = player.x - speed * dt
			player.dir = "left"
		elseif down(rightbtn) then
			player.x = player.x + speed * dt
			player.dir = "right"
		end

		player.x, player.y, cols = world:move(player, player.x, player.y)

	elseif paused then
		-- handle menu input
	end
end

function love.draw()
	-- Set transform values
	tx = math.floor(player.x - screen_width / 2)
	ty = math.floor(player.y - screen_height / 2)

	-- Draw map
	map:draw(-tx, -ty, sx, sy)
	--map:bump_draw(world, -tx, -ty, sx, sy)

	if paused then
		love.graphics.circle("line", love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 120, 100)
	end
end

function love.resize(w, h)
	map:resize(w, h)
end