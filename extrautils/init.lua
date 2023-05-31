---@class AwesomeExtrautils
local extrautils = { mt = { __name = "extrautils" } }
extrautils.mt.__index = extrautils.mt
setmetatable(extrautils, extrautils.mt)

extrautils.apps = require("extrautils.apps")
extrautils.asyncio = require("extrautils.asyncio")
extrautils.awesome = require("extrautils.awesome")
extrautils.capi = require("extrautils.capi")
extrautils.class = require("extrautils.class")
extrautils.collection = require("extrautils.collection")
extrautils.color = require("extrautils.color")
extrautils.compat = require("extrautils.compat")
extrautils.file = require("extrautils.file")
extrautils.math = require("extrautils.math")
extrautils.string = require("extrautils.string")
extrautils.table = require("extrautils.table")
extrautils.testing = require("extrautils.testing")
extrautils.verification = require("extrautils.verification")

local sub_modules = {
	"apps",
	"asyncio",
	"awesome",
	"capi",
	"class",
	"collection",
	"color",
	"compat",
	"file",
	"math",
	"string",
	"table",
	"testing",
	"verification",
}

function extrautils.mt:__tostring(depth)
	do
		local first_item = next(self)

		if (first_item == nil) or ((first_item == "mt") and (next(self, "mt") == nil)) then
			return "{}"
		end
	end

	depth = depth or 0
	local base_indent = ("    "):rep(depth)

	local out
	local longest_key_length

	if depth == 0 then
		out = self.__name .. " {\n"
		longest_key_length = 0
	else
		out = "{\n"
		longest_key_length = extrautils.table.get_longest_key_length(self)
	end

	for k, v in pairs(self) do
		if k == "mt" then
			goto _continue_0
		end

		out = out .. base_indent .. "    " .. k .. (" "):rep(longest_key_length - #k) .. " = "

		if depth == 0 then
			out = out .. self.__tostring(v, depth + 1)
		else
			out = out .. tostring(v)
		end

		out = out .. ",\n"


		::_continue_0::
	end

	return out .. base_indent .. "}"
end

return extrautils
