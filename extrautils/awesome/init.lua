local extrautils_table = require("extrautils.table")

---@class AwesomeExtrautils.awesome : AwesomeExtrautils.table.Table
local awesome = extrautils_table.create()

local awful, gears, wibox
do
	local success, result = pcall(function()
		awful = require("awful")
		gears = require("gears")
		wibox = require("wibox")
	end)

	if not success then
		return awesome
	end
end

local timer = gears.timer
local crush = gears.table.crush

local function create_widget_instance(w)
	local mt = getmetatable(w)

	if (not mt) or (not mt.__call) then
		return crush({}, w)
	end

	return w()
end

function awesome.create_widget(args)
	args = args or {}
	args.properties = args.properties or {} ---@type string[]|table<string, string[]>
	args.parent = args.parent or wibox.widget.base.make_widget
	args.init = args.init or function(widget, ...) end

	args.new = args.new or function(cls, args_new)
		local self = crush(crush({}, create_widget_instance(args_new.parent)), cls)

		if self._private == nil then
			self._private = {}
		end

		return self
	end

	---@type table<string, any>
	local widget = { mt = {} }
	widget.mt.__index = widget.mt
	setmetatable(widget, widget.mt)

	for k, property in pairs(args.properties) do
		if (type(k) == "string") and (type(property) == "table") then
			--- {
			--- 	foobar = { "get", "set" },
			--- }
			for _, v in ipairs(property) do
				if v == "get" then
					widget["get_" .. k] = function(_self)
						return _self._private[k]
					end
				elseif v == "set" then
					widget["set_" .. k] = function(_self, value)
						_self._private[k] = value
					end
				end
			end
		else
			---@cast k integer
			---@cast property string
			--- {
			--- 	"foobar",
			--- }
			widget["get_" .. property] = function(_self)
				return _self._private[property]
			end

			widget["set_" .. property] = function(_self, value)
				_self._private[property] = value
			end
		end
	end

	function widget.mt.__call(cls, ...)
		local self = args.new(cls, ...)
		args.init(self, ...)
		return self
	end

	return widget
end

function awesome.after_timeout(timeout, callback)
	timer {
		timeout     = timeout,
		autostart   = true,
		single_shot = true,
		callback    = callback,
	}
end

return awesome
