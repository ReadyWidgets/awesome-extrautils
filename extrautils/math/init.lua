local luamath = math

local extrautils_table = require("extrautils.table")

---@class AwesomeExtrautils.math : AwesomeExtrautils.Table
local math = extrautils_table.create()

function math.round(x)
	return luamath(x + 0.5)
end

return math
