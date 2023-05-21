local luamath = math
local luafloor = math.floor

local extrautils_table = require("extrautils.table")

---@class AwesomeExtrautils.math : AwesomeExtrautils.Table
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

return math
