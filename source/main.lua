
import "CoreLibs/graphics"
import "CoreLibs/object"
import "CoreLibs/sprites"
import "CoreLibs/timer"

local pd <const> = playdate
local gfx <const> = pd.graphics

local counter = 0
local keyTimer = nil

sprPause = nil

local sprCounter = gfx.sprite.spriteWithText("Counter - " .. counter, 300, 50)
sprCounter:moveTo(200, 120)
sprCounter:add()

function createPauseSpr()
	local spr = gfx.sprite.spriteWithText("PAUSE", 300, 50)
	spr:moveTo(math.random(350),math.random(220))
	spr:add()

	return spr
end

function pd.AButtonDown()
	print("In A Down, adding counter")

	local function incrementCounter()
		print(string.format("A Down, counter at %d", counter))
		print(keyTimer)

		if counter >= 10 then 
			-- Let's stop the repeat and show the pause sprite
			if keyTimer ~= nil then
				print("Kill Timer in Down")
				keyTimer:remove()
				keyTimer = nil
			end
			sprPause = createPauseSpr()
		else
			counter += 1
		end

		print ("End incrementCounter")
	end

	keyTimer = pd.timer.keyRepeatTimer(incrementCounter)
end

function pd.AButtonUp()
	if keyTimer ~= nil then
		print("Kill Timer in Up")
		keyTimer:remove()
		keyTimer = nil
	end
end

function pd.BButtonDown()
	-- We get out of pause
	-- counter = 0
	if sprPause ~= nil then 
		sprPause:remove()
		sprPause = nil
	end
end

function pd.update()
	local img = gfx.imageWithText("Counter - " .. counter, 300, 50)
    sprCounter:setImage(img)

	gfx.sprite.update()
	pd.timer.updateTimers()
end