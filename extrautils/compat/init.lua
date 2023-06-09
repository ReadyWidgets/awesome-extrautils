local extrautils_table = require("extrautils.table")

---@class AwesomeExtrautils.compat : AwesomeExtrautils.table.Table
local compat = extrautils_table.create()

function compat.get_version()
	return tonumber(_VERSION:match("[%d.]+"))
end

compat.unpack = table.unpack or unpack

compat.pack = table.pack or function(...)
	return { n = select("#", ...), ... }
end

return compat
