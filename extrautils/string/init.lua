local luastring = string

local extrautils_table = require("extrautils.table")

---@class AwesomeExtrautils.string
local string = { mt = {} }

function string.center(str, width, char)
	char = char or " "

	local left  = char:rep(math.ceil( width / 2))
	local right = char:rep(math.floor(width / 2))

	return left .. str .. right
end

function string.get_characters(str)
	local result = extrautils_table.make_iterable()

	for i = 1, #str do
		result[#result+1] = str:sub(i, i)
	end

	return result
end

return setmetatable(string, string.mt)
