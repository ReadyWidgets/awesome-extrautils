local luamath = math
local luafloor = math.floor

local extrautils_table = require("extrautils.table")

---@class AwesomeExtrautils.math : AwesomeExtrautils.table.Table
local math = extrautils_table.create()

function math.round(x)
	return luafloor(x + 0.5)
end

function math.clamp(value, floor, ceiling)
	if value < floor then
		return ceiling
	elseif value > ceiling then
		return floor
	end

	return value
end

local dpi
do
	local success, beautiful = pcall(require, "beautiful")

	if not success then
		return math
	end

	dpi = beautiful.xresources.dpi
end

--- Scale a size value to support UI scaling
---@param value number
---@param screen? screen
---@param scaling_factor? number
---@return unknown
function math.scale(value, screen, scaling_factor)
	scaling_factor = scaling_factor or 1

	local scaled = value * scaling_factor

	if screen ~= nil then
		scaled = scaled * screen.scaling_factor
	end

	return dpi(scaled)
end

return math
