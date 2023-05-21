local assert = assert

local extrautils_table = require("extrautils.table")

---@class AwesomeExtrautils.verification : AwesomeExtrautils.Table
local verification = extrautils_table.create()

---
---@param function_name string
---@param position integer
---@param parameter_name string
---@param expected_type type
---@param value any
function verification.parameter_type(function_name, position, parameter_name, expected_type, value)
	local typeof_value = type(value)
	assert(
		(typeof_value == expected_type),
		("ERROR: bad argument #%d ('%s') to '%s' (expected %s, got %s)"):format(
			position,
			parameter_name,
			function_name,
			expected_type,
			typeof_value
		)
	)
end

return verification
