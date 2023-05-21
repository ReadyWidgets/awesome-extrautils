local luatable = table
local pairs = pairs
local getmetatable = getmetatable
local setmetatable = setmetatable

---@class AwesomeExtrautils.Table : table
---@field mt table

local function new_Table(base, mt)
	base = {}
	mt = mt or getmetatable(base) or {}
	mt.__index = mt

	base.mt = mt

	return setmetatable(base, mt)
end

---@class AwesomeExtrautils.table : AwesomeExtrautils.Table
local table = new_Table()

--- Create a new table with a metatable pre-set, accessable through the ["mt"] field.
--- The metatable has itself set as the `__index`.
---
--- Please note that, if `base` is passed and it has a metatable pre-defined, it will
--- get re-used (as supposed to overwriting it), unless `mt` was explicitly passed as well.
---
--- ---
---
---@param base? table
---@param mt? table
---@return AwesomeExtrautils.Table
function table.create(base, mt)
	return new_Table(base, mt)
end

--- Run a callback function for each field in a table, accumulating the results
--- into a new table.
---
--- ---
---
---@generic T_key, T_value, T_result
---@param tb table<T_key, T_value>
---@param callback fun(value: T_value): T_result
---@return table<T_key, T_result>
function table.map(tb, callback)
	local result = {}

	for k, v in pairs(tb) do
		result[k] = callback(v)
	end

	return result
end

--- Run a callback function for each field in a table. The field will be copied into
--- a new table, but only if the callback returns `true`.
---
--- ---
---
---@generic T_key, T_value
---@param tb table<T_key, T_value>
---@param callback fun(value: T_value): boolean
---@return table<T_key, T_value>
function table.filter(tb, callback)
	local result = {}

	for k, v in pairs(tb) do
		if callback(v) then
			result[k] = v
		end
	end

	return result
end

--- Run a callback function for each field in a table, combining each field usinga a callback.
---
--- ---
---
--- Example:
---
--- ```
--- --- Get the sum of a table of numbers
--- local mysum = table.reduce({ 13, 2, 46, 3 }, function(a, b)
--- 	return a + b
--- end)
---
--- --- Concatenate a list of strings / string-convertable objects
--- local mystring = table.reduce({ "foo", "bar", 528, { "tables won't error here" } }, function(a, b)
--- 	return tostring(a) .. tostring(b)
--- end)
--- ```
---
--- ---
---
---@generic T_key, T_value, T_result
---@param tb table<T_key, T_value>
---@param callback fun(a: T_value, b: T_value): T_result
---@return table<T_key, T_result>
function table.reduce(tb, callback)
	local result = {}

	for k, v in pairs(tb) do
		if next(tb) == nil then
			--- The last item has be reached already, since we look ahead one key in the
			--- assignment below.
			break
		end

		result[k] = callback(v, next(tb, k))
	end

	return result
end

--- Allow a table to be iterable without needing to call `pairs()` on it.
---
--- Please note that this sets a `__call` metatmethod, overwriting an existing
--- one if one was already defined.
---
--- ---
---
--- Example:
---
--- ```
--- local mytable = { "foo", "bar", "biz", "baz" }
---
--- table.make_iterable(mytable)
---
--- for k, v in mytable do
--- 	print(k ,v)
--- end
---
--- --- In this case, we probably don't need the key, so we can pass `true` as
--- --- a second parameter to ignore it.
--- table.make_iterable(mytable, true)
---
--- for i in mytable do
--- 	print(i)
--- end
--- ```
---
--- ---
---
---@param tb? table
---@param value_only? boolean If `true`, looping over `tb` will only give the value, not a key-value pair
---@return table tb The same table as was passed in (just returned for convenience)
function table.make_iterable(tb, value_only)
	tb = tb or {}
	local mt = getmetatable(tb) or {}

	local k

	if value_only then
		function mt:__call()
			local v
			k, v = next(self, k)
			return v
		end
	else
		function mt:__call()
			local v
			k, v = next(self, k)
			return k, v
		end
	end

	return setmetatable(tb, mt)
end

--- Run a callback function for each field in a table, combining each field usinga a callback.
---
--- ---
---
--- If stop is `nil`, the range will be `[1 -> start]` instead of `[start -> nil]`.
---
--- ---
---
--- Table ranges can be directly iterated without `pairs()` / `ipairs()`
---
--- Example:
---
--- ```
--- for i in table.range(5) do
--- 	print(i)
--- end
--- ```
---
--- ---
---
---@param start integer The lowest value, defaults to `1`
---@param stop? integer The highest value, has no default
---@param step? integer The size of each step to go from `start` to `stop`, also defaults to `1`
---@return integer[]
function table.range(start, stop, step)
	local result = {}

	if stop == nil then
		if start == nil then
			error("ERROR: Attempted to create a table range without providing a stop value!")
		end

		stop = start
		start = 1
	end

	step = step or 1

	for i = start, stop, step do
		result[#result+1] = i
	end

	return table.make_iterable(result, true)
end

function table.is_empty(tb)
	return (not tb) or (next(tb) ~= nil)
end

function table.get_longest_key_length(tb, stringify, use_value)
	stringify = stringify or tostring

	local longest_key_length = 0

	for k, v in pairs(tb) do
		local k_len = #stringify(use_value and v or k)

		if k_len > longest_key_length then
			longest_key_length = k_len
		end
	end

	return longest_key_length
end

---@param tb any
---@param args? table
---@return string
function table.tostring(tb, args)
	if type(tb) ~= "table" then
		return tostring(tb)
	end

	local mt = getmetatable(tb)
	if mt and rawget(mt, "__tostring") then
		return tostring(tb)
	end

	args = args or {}

	args.indent = args.indent or "    " ---@type integer|string
	if type(args.indent) == "number" then
		args.indent = (" "):rep(args.indent) ---@type string
	end
	args.depth = args.depth or 0 ---@type integer

	local out = "{\n"

	local key_tostring_cache = {}
	local longest_key_length = table.get_longest_key_length(tb, table.tostring)

	for k, v in pairs(tb) do
		local k_str = key_tostring_cache[k]
		out = out .. args.indent .. k_str .. (" "):rep(longest_key_length - #k_str) .. " = " .. table.tostring(v, {
			indent = args.indent,
			depth = args.depth + 1,
		}) .. ",\n"
	end

	return out .. "}"
end

return table
