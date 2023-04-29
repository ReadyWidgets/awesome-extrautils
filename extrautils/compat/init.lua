local extrautils_table = require("extrautils.table")

---@class AwesomeExtrautils.compat : AwesomeExtrautils.Table
local compat = extrautils_table.create()

function compat.get_version()
	return tonumber(_VERSION:match("[%d.]+"))
end

compat.unpack = unpack or table.unpack

return compat
