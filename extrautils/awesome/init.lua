---@class AwesomeExtrautils.awesome
local awesome = { mt = {} }

local awful, gears, wibox
do
	local success, result = pcall(function()
		awful = require("awful")
		gears = require("gears")
		wibox = require("wibox")
	end)

	if not success then
		return
	end
end

function awesome.create_widget(args)
	args = args or {}
	args.properties = args.properties or {}
	args.parent = args.parent or wibox.widget.base
	args.init = args.init or function(widget) end

	args.new = args.new or function(args)
		local widget = args.parent()
		widget._private = widget._private or {}

		for _, property in ipairs(args.properties) do
			widget["get_" .. property] = function(self)
				return self._private[property]
			end

			widget["set_" .. property] = function(self, value)
				self._private[property] = value
			end
		end

		return widget
	end

	local widget = args.new(args)
	args.init(widget)
	return widget
end

return setmetatable(awesome, awesome.mt)
