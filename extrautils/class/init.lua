local rawget = rawget
local setmetatable = setmetatable

local extrautils_table = require("extrautils.table")

local verification = require("extrautils.verification")

---@class AwesomeExtrautils.class : AwesomeExtrautils.table.Table
local class = extrautils_table.create()

local object = {
	__new = function(cls, ...)
		local base = cls.__base

		if not base.__new then
			return setmetatable({}, base)
		end

		return base.__new(cls, ...)
	end,

	__init = function(self, ...)
		local base = self.__class.__base

		if not base.__init then
			return
		end

		base.__init(self, ...)
	end
}

local class_meta = {
	__index = function(cls, key)
		local value = rawget(rawget(cls, "__base"), key)

		if value ~= nil then
			return value
		end

		local parent = rawget(cls, "__parent")

		if parent then
			return parent.__base[key]
		end
	end,

	__call = function(cls, ...)
		local self = cls.__new(cls, ...)
		cls.__init(self, ...)
		return self
	end,

	__tostring = function(cls)
		local result = "<class \"" .. tostring(cls.__name) .. "\""

		local parent = rawget(cls, "__parent")

		if not parent then
			return result .. ">"
		end

		return result .. " (child of " .. tostring(parent) .. ")>"
	end
}

local function base_indexer(self, key)
	local mt = getmetatable(self)
	local cls = rawget(mt, "__class")

	do
		local value = rawget(cls, "__base")[key]

		if value ~= nil then
			return value
		end
	end

	local parent = cls.__parent

	if parent then
		return parent.__base[key]
	end
end

local function base_tostring(self)
	return "<instance of \"" .. tostring(self.__class.__name) .. "\">"
end

---@class AwesomeExtrautils.class.Class : AwesomeExtrautils.class.Object
---@operator call(AwesomeExtrautils.class.Class): AwesomeExtrautils.class.Object
---@field __base AwesomeExtrautils.class.Object
---@field __name string
---@field __parent AwesomeExtrautils.class.Class|table|nil
---@field __inherited (fun(cls: AwesomeExtrautils.class.Class, child: AwesomeExtrautils.class.Class))|nil
---@field __new fun(cls: AwesomeExtrautils.class.Class, ...): AwesomeExtrautils.class.Class
---@field __init fun(self: AwesomeExtrautils.class.Class, ...)
---@field __tostring fun(cls: AwesomeExtrautils.class.Class): string

---@class AwesomeExtrautils.class.Object
---@field __class AwesomeExtrautils.class.Class
---@field __index fun(self: AwesomeExtrautils.class.Object, key: any): any
---@field __tostring fun(self: AwesomeExtrautils.class.Object): string

--- Create a class, compatible with Moonscript and Yuescript
---@param name string The name of the class
---@param base table A table containing methods for the class
---@param parent? AwesomeExtrautils.class.Class|table A class or table to inherit from, or `nil` to not use inheritance (note: Multiple inheritance is NOT supported!)
---@return table   ---@return AwesomeExtrautils.awesome.class
function class.create(name, base, parent)
	verification.parameter_type("create_class", 1, "name", "string", name)
	verification.parameter_type("create_class", 2, "base", "table", base)

	if parent then
		local parent_base = parent.__base

		assert(parent_base, "ERROR: The parent given to '' appears to not be a class")

		for k, v in pairs(parent_base) do
			if base[k] == nil and k:match("^__") and not (k == "__index" and v == parent_base) then
				base[k] = v
			end
		end

		--setmetatable(base, parent_base)
	end

	base.__index = base.__index or base_indexer
	base.__tostring = base.__tostring or base_tostring

	---@type AwesomeExtrautils.class.Class
	local cls = setmetatable({
		__base = base,
		__name = name,
		__parent = parent
	}, class_meta)

	for k, v in pairs(object) do
		cls[k] = v
	end

	base.__class = cls

	if parent and parent.__inherited then
		parent.__inherited(parent, cls)
	end

	return cls
end

--- Check whether an object is an instance of a class (or one of its child classes) 
---@param instance AwesomeExtrautils.class.Object
---@param cls AwesomeExtrautils.class.Class
---@return boolean
local function isinstance(instance, cls)
	local instance_cls = instance.__class

	if not instance_cls then
		return false
	end

	if instance_cls == cls then
		return true
	end

	local parent = instance_cls.__parent

	if not parent then
		return false
	end

	return isinstance(instance, parent)
end

class.isinstance = isinstance

---@param cls AwesomeExtrautils.class.Class
function class.super(cls)
	return cls.__parent
end

return class
