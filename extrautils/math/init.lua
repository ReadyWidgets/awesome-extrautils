local luamath = math

---@class AwesomeExtrautils.math
local math = { mt = {} }

function math.round(x)
	return luamath(x + 0.5)
end

return setmetatable(math, math.mt)
