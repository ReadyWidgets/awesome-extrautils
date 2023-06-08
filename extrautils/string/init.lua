local luastring = string
local lchar = luastring.char

local extrautils_table = require("extrautils.table")

---@class AwesomeExtrautils.string : AwesomeExtrautils.table.Table
local string = extrautils_table.create()

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

function string.is_empty(str)
	return (not str) or (str == "")
end

local function numbered_escape(str, i)
	return str:gsub(lchar(i), "\\" .. tostring(i))
end

--- Replace escape sequences, like a newline, with their litteral representation, like `"\n"`.
---
--- ---
---
---@param str string The string to escape
---@return string str_escaped The escaped version of `str`
function string.escape(str)
	str = str
		:gsub("\\", [[\\]])
		:gsub("\a", [[\a]])
		:gsub("\b", [[\b]])
		:gsub("\f", [[\f]])
		:gsub("\n", [[\n]])
		:gsub("\r", [[\r]])
		:gsub("\t", [[\t]])
		:gsub("\v", [[\v]])
		:gsub("\"", [[\"]])
		:gsub("\'", [[\']])
		:gsub("\127", [[\127]]) -- DEL / delete key

	--- See: https://www.asciitable.com/
	for i = 1, 26 do
		str = numbered_escape(str, i)
	end

	for i = 28, 31 do
		str = numbered_escape(str, i)
	end

	return str
end

---@param str string
---@param data table<string, any>
function string.format(str, data)
	local result = str

	for match in str:gmatch("%{([^%}]+)%}") do
		result = result:gsub("%{" .. match .. "%}", data[match], 1)
	end

	return result
end

return string
