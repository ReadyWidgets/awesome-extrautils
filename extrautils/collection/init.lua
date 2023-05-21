local extrautils_table = require("extrautils.table")
local class = require("extrautils.class")

---@class AwesomeExtrautils.collection : AwesomeExtrautils.Table
local collection = extrautils_table.create()

collection.Enum = class.create("extrautils.collection.Enum", {
	__init = function(self, tb)
		for k, v in pairs(tb) do
			if self[v] ~= nil then
				error("ERROR: Attempted to assign enum field \"" .. tostring(v) .. "\" multiple times!")
			end

			self[v] = k
		end
	end
})

return collection
